//
//  CMSpace.m
//  astroman
//
//  Created by Jakub Knejzlik on 17/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMSpace.h"

#import "CMWrapper.h"

@interface CMSpace (){
    cpSpace *_space;
    CFTimeInterval lastTimeStamp;
    double accumulator;
}
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSMutableSet *bodies;
@property (nonatomic,strong) NSMutableSet *postStepBlocks;
@property (nonatomic,strong) NSMutableSet *collisionHandlerBlocks;
@end

@interface CMCollisionBlocks : NSObject
@property (nonatomic,copy) BOOL (^beginBlock)(CMArbiter *arbiter,CMSpace *space);
@property (nonatomic,copy) BOOL (^preSolve)(CMArbiter *arbiter,CMSpace *space);
@property (nonatomic,copy) void (^postSolve)(CMArbiter *arbiter,CMSpace *space);
@property (nonatomic,copy) void (^separate)(CMArbiter *arbiter,CMSpace *space);
@end
@implementation CMCollisionBlocks
@end


static void postStepBlock(cpSpace *space, void *key, void *unused)
{
    CMSpace *_space = (__bridge CMSpace *)cpSpaceGetUserData(space);
    for (void (^postStepBlock)(CMSpace *space) in _space.postStepBlocks) {
        postStepBlock(_space);
    }
    [_space.postStepBlocks removeAllObjects];
//    cpSpaceRemoveBody(space, shape->body);
//    cpBodyFree(shape->body);
//    
//    cpSpaceRemoveShape(space, shape);
//    cpShapeFree(shape);
}
static int handleBegin(cpArbiter *arb, cpSpace *space, void *data)
{
    CMCollisionBlocks *blocks = (__bridge CMCollisionBlocks *)data;
    if(blocks.beginBlock){
        CMArbiter *arbiter = [[CMArbiter alloc] initWithArbiter:arb];
        return blocks.beginBlock(arbiter,(__bridge CMSpace *)cpSpaceGetUserData(space));
    }
    return 1;
}
static int handlePreSolve(cpArbiter *arb, cpSpace *space, void *data)
{
    CMCollisionBlocks *blocks = (__bridge CMCollisionBlocks *)data;
    if(blocks.preSolve){
        CMArbiter *arbiter = [[CMArbiter alloc] initWithArbiter:arb];
        return blocks.preSolve(arbiter,(__bridge CMSpace *)cpSpaceGetUserData(space));
    }
    return 1;
}
static void handlePostSolve(cpArbiter *arb, cpSpace *space, void *data)
{
    CMCollisionBlocks *blocks = (__bridge CMCollisionBlocks *)data;
    if(blocks.postSolve){
        CMArbiter *arbiter = [[CMArbiter alloc] initWithArbiter:arb];
        blocks.postSolve(arbiter,(__bridge CMSpace *)cpSpaceGetUserData(space));
    }
}
static void handleSeparate(cpArbiter *arb, cpSpace *space, void *data)
{
    CMCollisionBlocks *blocks = (__bridge CMCollisionBlocks *)data;
    if(blocks.separate){
        CMArbiter *arbiter = [[CMArbiter alloc] initWithArbiter:arb];
        blocks.separate(arbiter,(__bridge CMSpace *)cpSpaceGetUserData(space));
    }
}


@implementation CMSpace
@synthesize space = _space;

-(id)init{
    self = [super init];
    if (self) {
        _space = cpSpaceNew();
        
        _space->gravity = cpv(0, -100);
//        _space->damping = 0.7;
//        cpSpaceSetDamping(_space, 0.1);
        
//        cpSpaceSetCollisionBias(_space, 0);
//        cpSpaceSetCollisionPersistence(_space, 10);
        
        cpSpaceSetUserData(_space, (__bridge void*)self);
        
        _staticBody = [CMBody staticBodyWithBody:_space->staticBody];
        
        self.simulationSpeed = 1.0;
        accumulator = 0;
        
        self.baseObjects = [NSMutableSet set];
        self.bodies = [NSMutableSet set];
        self.postStepBlocks = [NSMutableSet set];
        self.collisionHandlerBlocks = [NSMutableSet set];
        
        [self performSelector:@selector(initCallbacks) withObject:nil afterDelay:2];
    }
    return self;
}

-(id)initWithBoundaries:(CGRect)boundaries{
    self = [self init];
    if (self) {
        [self addBoundaryFrom:cpv(CGRectGetMinX(boundaries), CGRectGetMinY(boundaries)) to:cpv(CGRectGetMaxX(boundaries), CGRectGetMinY(boundaries))];
        [self addBoundaryFrom:cpv(CGRectGetMinX(boundaries), CGRectGetMaxY(boundaries)) to:cpv(CGRectGetMaxX(boundaries), CGRectGetMaxY(boundaries))];
        [self addBoundaryFrom:cpv(CGRectGetMinX(boundaries), CGRectGetMinY(boundaries)) to:cpv(CGRectGetMinX(boundaries), CGRectGetMaxY(boundaries))];
        [self addBoundaryFrom:cpv(CGRectGetMaxX(boundaries), CGRectGetMinY(boundaries)) to:cpv(CGRectGetMaxX(boundaries), CGRectGetMaxY(boundaries))];
    }
    return self;
}
-(void)addBoundaryFrom:(cpVect)from to:(cpVect)to{
    cpShape *ground = cpSegmentShapeNew(self.space->staticBody, from,to, 0);
    cpShapeSetFriction(ground, 1);
    cpShapeSetElasticity(ground, 0);
    cpSpaceAddStaticShape(self.space, ground);
}

-(void)dealloc{
    cpSpaceFree(_space);
}


-(void)initCallbacks{
}


#pragma mark - NSCoding Delegate Methods
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [self init];
    if (self) {
        self.gravity = CGVectorMake([aDecoder decodeFloatForKey:@"gravity_x"], [aDecoder decodeFloatForKey:@"gravity_y"]);
        self.damping = [aDecoder decodeFloatForKey:@"dampping"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeFloat:self.gravity.dx forKey:@"gravity_x"];
    [aCoder encodeFloat:self.gravity.dy forKey:@"gravity_y"];
    [aCoder encodeFloat:self.damping forKey:@"damping"];
}


#pragma mark - Automatic Simulation
-(void)startSimulation:(NSTimeInterval)repeatInterval{
    self.currentRepeatInterval = repeatInterval;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:repeatInterval target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}
-(void)stopSimulation{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)tick:(NSTimer *)timer {
    if(lastTimeStamp == 0)lastTimeStamp = CACurrentMediaTime();
    else{
        CFTimeInterval newTimeStamp = CACurrentMediaTime();
        NSTimeInterval dt = timer.timeInterval;
        CGFloat frameTime = (newTimeStamp - lastTimeStamp)*self.simulationSpeed;
        if(frameTime > dt*10){
            frameTime = dt*10;
        }
        accumulator += frameTime;
        while (accumulator > dt) {
            [self step:dt updateNodes:NO];
            accumulator -= dt;
        }
        [self updateBodiesWithDelta:(1-accumulator/dt) repeatInterval:self.currentRepeatInterval];
        lastTimeStamp = newTimeStamp;
    }
}


-(void)step:(NSTimeInterval)interval{
//    NSLog(@"step %f",interval);
    [self step:interval updateNodes:YES];
}
-(void)step:(NSTimeInterval)interval updateNodes:(BOOL)update{
    if(self.paused)return;
    for (CMBody *body in self.bodies) {
        body.previousPosition = body.position;
        body.previousAngle = body.angle;
        [body.node chipmunk_step:interval];
    }
    if([self.delegate respondsToSelector:@selector(space:willStepWithInterval:)])[self.delegate space:self willStepWithInterval:interval];
    cpSpaceStep(_space, interval);
    if(update)[self updateBodiesWithDelta:1 repeatInterval:self.currentRepeatInterval];
    if([self.delegate respondsToSelector:@selector(space:didStepWithInterval:)])[self.delegate space:self didStepWithInterval:interval];
}

-(void)updateBodiesWithDelta:(CGFloat)delta repeatInterval:(NSTimeInterval)repeatInterval{
//    NSLog(@"delta %f",delta);
    for (CMBody *body in self.bodies) {
        id<CMBodyNode> node = body.node;
        [node chipmunk_update:repeatInterval delta:delta];
        //        [node chipmunk_step:interval];
    }
}


#pragma mark - Properties
-(void)setIterations:(CGFloat)iterations{
    cpSpaceSetIterations(_space, iterations);
}
-(CGFloat)iterations{
    return cpSpaceGetIterations(_space);
}
-(void)setGravity:(CGVector)gravity{
    _space->gravity = cpv(gravity.dx, gravity.dy);
}
-(CGVector)gravity{
    return CGVectorMake(_space->gravity.x, _space->gravity.y);
}
-(void)setDamping:(CGFloat)damping{
    cpSpaceSetDamping(_space, damping);
}
-(CGFloat)damping{
    return cpSpaceGetDamping(_space);
}
-(void)setIdleSpeedTreshold:(CGFloat)idleSpeedTreshold{
    cpSpaceSetIdleSpeedThreshold(_space, idleSpeedTreshold);
}
-(CGFloat)idleSpeedTreshold{
    return cpSpaceGetIdleSpeedThreshold(_space);
}
-(void)setSleepTimeThreshold:(CGFloat)sleepTimeThreshold{
    cpSpaceSetSleepTimeThreshold(_space, sleepTimeThreshold);
}
-(CGFloat)sleepTimeThreshold{
    return cpSpaceGetSleepTimeThreshold(_space);
}
-(void)setCollisionSlop:(CGFloat)collisionSlop{
    cpSpaceSetCollisionSlop(_space, collisionSlop);
}
-(CGFloat)collisionSlop{
    return cpSpaceGetCollisionSlop(_space);
}
-(void)setCollisionBias:(CGFloat)collisionBias{
    cpSpaceSetCollisionBias(_space, collisionBias);
}
-(CGFloat)collisionBias{
    return cpSpaceGetCollisionBias(_space);
}
-(void)setCollisionPersistence:(NSUInteger)collisionPersistence{
    cpSpaceSetCollisionPersistence(_space, collisionPersistence);
}
-(NSUInteger)collisionPersistence{
    return cpSpaceGetCollisionPersistence(_space);
}
-(CGFloat)currentTimeStep{
    return cpSpaceGetCurrentTimeStep(_space);
}


-(void)addPostStepBlock:(void(^)(CMSpace *space))block{
    [self.postStepBlocks addObject:[block copy]];
    if([self.postStepBlocks count] == 1)cpSpaceAddPostStepCallback(self.space, (cpPostStepFunc)postStepBlock, NULL, NULL);
}
-(void)addCollisionHandlerTypeA:(id)typeA typeB:(id)typeB begin:(BOOL(^)(CMArbiter *arbiter, CMSpace *space))begin preSolve:(BOOL(^)(CMArbiter *arbiter, CMSpace *space))preSolve postSolve:(void(^)(CMArbiter *arbiter, CMSpace *space))postSolve separate:(void(^)(CMArbiter *arbiter, CMSpace *space))separate{
    CMCollisionBlocks *blocks = [[CMCollisionBlocks alloc] init];
    blocks.beginBlock = begin;
    blocks.preSolve = preSolve;
    blocks.postSolve = postSolve;
    blocks.separate = separate;
    [self.collisionHandlerBlocks addObject:blocks];
    cpSpaceAddCollisionHandler(self.space, (unsigned int)(__bridge void *)typeA, (unsigned int)(__bridge void *)typeB, handleBegin, handlePreSolve, handlePostSolve, handleSeparate, (__bridge void *)blocks);
}

#pragma mark - Base Objects
-(CMBaseObject *)addBaseObject:(CMBaseObject *)object{
    if(object){
        object.space = self;
        [self.baseObjects addObject:object];
        if([object isKindOfClass:[CMBody class]])[self.bodies addObject:object];
    }
    return object;
}
-(void)removeBaseObject:(CMBaseObject *)object{
    object.space = nil;
}
-(void)postStepRemoval:(CMBaseObject *)object{
    [self addPostStepBlock:^(CMSpace *space) {
        object.space = nil;
    }];
}


#pragma mark - Queries
-(CMNearestPointQueryInfo *)nearestInfoForPoint:(CGPoint)point maxDistance:(CGFloat)maxDistance layers:(NSUInteger)layers group:(id)group{
    cpNearestPointQueryInfo info = {};
    cpSpaceNearestPointQueryNearest(self.space, cpv(point.x, point.y), maxDistance, layers, (unsigned int)(__bridge void *)group, &info);
    return [[CMNearestPointQueryInfo alloc] initWithInfo:info];
}
-(NSArray *)segmentQueryFrom:(CGPoint)from to:(CGPoint)to layers:(NSUInteger)layers group:(id)group{
    NSMutableArray *array = [NSMutableArray array];
    __weak NSMutableArray *weakArray = array;
    cpSpaceSegmentQuery_b(_space, cpv(from.x, from.y), cpv(to.x, to.y), layers, (unsigned int)(__bridge void *)group, ^(cpShape *shape, cpFloat t, cpVect n) {
        [weakArray addObject:[[CMSegmentQueryInfo alloc] initWithShape:shape normalizedDistance:t normal:n]];
    });
    return array;
}
-(CMSegmentQueryInfo *)segmentQueryFirstFrom:(CGPoint)from to:(CGPoint)to layers:(NSUInteger)layers group:(id)group{
    cpSegmentQueryInfo info = {};
    cpSpaceSegmentQueryFirst(_space, cpv(from.x, from.y), cpv(to.x, to.y), layers, (unsigned int)(__bridge void *)group, &info);
    return [[CMSegmentQueryInfo alloc] initWithQueryInfo:info];
}
-(NSArray *)shapesInBB:(cpBB)bb layers:(NSUInteger)layers group:(id)group{
    NSMutableArray *array = [NSMutableArray array];
    __weak NSMutableArray *weakArray = array;
    cpSpaceBBQuery_b(_space, bb, layers, (unsigned int)(__bridge void *)group, ^(cpShape *shape) {
        [weakArray addObject:(__bridge CMShape *)cpShapeGetUserData(shape)];
    });
    return array;
}
-(NSArray *)shapesInRect:(CGRect)rect layers:(NSUInteger)layers group:(id)group{
    return [self shapesInBB:cpBBNew(CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect)) layers:layers group:group];
}
-(NSArray *)shapesInCircleAtPoint:(CGPoint)center radius:(CGFloat)radius layers:(NSUInteger)layers group:(id)group{
    return [self shapesInBB:cpBBNewForCircle(cpv(center.x, center.y), radius) layers:layers group:group];
}
-(NSArray *)shapesOverlapingShape:(CMShape *)shape{
    NSMutableArray *array = [NSMutableArray array];
    __weak NSMutableArray *weakArray = array;
    cpSpaceShapeQuery_b(_space, shape.shape, ^(cpShape *shape, cpContactPointSet *points) {
        [weakArray addObject:[[CMShapeQueryInfo alloc] initWithShape:shape contacts:points]];
    });
    return array;
}

-(CMShape *)shapeAtPoint:(CGPoint)point layers:(cpLayers)layers group:(id)group{
    NSArray *array = [self shapesAtPoint:point layers:layers group:group];
    if([array count] > 0)return [array objectAtIndex:0];
    return nil;
}
-(NSArray *)shapesAtPoint:(CGPoint)point layers:(cpLayers)layers group:(id)group{
    NSArray *array = [self shapesInCircleAtPoint:point radius:1 layers:layers group:group];
    return array;
}
//#pragma mark - data
//-(void)setData:(id)data{
//    cpSpaceSetUserData(_space, (__bridge void*)data);
//}
//-(id)data{
//    return (__bridge id)cpSpaceGetUserData(_space);
//}

@end
