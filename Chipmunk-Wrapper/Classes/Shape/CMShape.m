//
//  CMShape.m
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMShape.h"

#import "CMWrapper.h"

@implementation CMShape{
    cpShape *_shape;
}
@synthesize shape = _shape;

-(id)initWithBody:(CMBody *)body shape:(cpShape *)shape{
    self = [super init];
    if (self) {
        _shape = shape;
        cpShapeSetUserData(shape, (__bridge void*)self);
        self.body = body;
        [body addShape:self];
//        cpShapeSetFriction(_shape, 1);
    }
    return self;
}

-(void)setSensor:(BOOL)sensor{
    cpShapeSetSensor(_shape, sensor);
}
-(BOOL)isSensor{
    return cpShapeGetSensor(_shape);
}

-(void)setElasticity:(CGFloat)elasticity{
    cpShapeSetElasticity(_shape, elasticity);
}
-(CGFloat)elasticity{
    return cpShapeGetElasticity(_shape);
}

-(void)setFriction:(CGFloat)friction{
    cpShapeSetFriction(_shape, friction);
}
-(CGFloat)friction{
    return cpShapeGetFriction(_shape);
}

-(void)setSurfaceVelocity:(CGVector)surfaceVelocity{
    cpShapeSetSurfaceVelocity(_shape, cpv(surfaceVelocity.dx, surfaceVelocity.dy));
}
-(CGVector)surfaceVelocity{
    return CGVectorMake(_shape->surface_v.x, _shape->surface_v.y);
}

-(void)setCollisionType:(id)collisionType{
    cpShapeSetCollisionType(_shape, (unsigned int)(__bridge void *)collisionType);
}
-(id)collisionType{
    unsigned int p = cpShapeGetCollisionType(_shape);
    return (__bridge id)(void *)p;
}

-(void)setGroup:(id)group{
    cpShapeSetGroup(_shape, (unsigned int)(__bridge void *)group);
}
-(id)group{
    return (__bridge id)(void *)cpShapeGetGroup(_shape);
}

-(void)setLayers:(NSUInteger)layers{
    cpShapeSetLayers(_shape, layers);
}
-(NSUInteger)layers{
    return cpShapeGetLayers(_shape);
}



-(void)dealloc{
    cpShapeFree(_shape);
}

-(void)setSpace:(CMSpace *)space{
    if(self.space)cpSpaceRemoveShape(self.space.space, self.shape);
    [super setSpace:space];
    if(self.space){
        if([self.body isStatic])cpSpaceAddStaticShape(self.space.space, self.shape);
        else cpSpaceAddShape(self.space.space, self.shape);
    }
}



-(CMNearestPointQueryInfo *)nearestInfoForPoint:(CGPoint)point{
    cpNearestPointQueryInfo info = {};
    cpShapeNearestPointQuery(_shape, cpv(point.x, point.y), &info);
    return [[CMNearestPointQueryInfo alloc] initWithInfo:info];
}
-(CMSegmentQueryInfo *)segmentQueryFrom:(CGPoint)from to:(CGPoint)to{
    cpSegmentQueryInfo info = {};
    cpShapeSegmentQuery(_shape, cpv(from.x, from.y), cpv(to.x, to.y), &info);
    return [[CMSegmentQueryInfo alloc] initWithQueryInfo:info];
}

@end
