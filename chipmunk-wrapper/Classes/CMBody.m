//
//  CMBody.m
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMBody.h"

#import "CMSpace.h"
#import "CMShape.h"


@implementation CMBody{
    cpBody *_body;
}
@synthesize body = _body;


+(CMBody *)boxBodyWithMass:(CGFloat)mass size:(CGSize)size{
    return [CMBody bodyWithMass:mass moment:cpMomentForBox(mass, size.width, size.height)];
}
+(CMBody *)circleBodyWithMass:(CGFloat)mass radius:(CGFloat)radius{
    return [CMBody circleBodyWithMass:mass radius:radius offset:CGVectorMake(0, 0)];
}
+(CMBody *)circleBodyWithMass:(CGFloat)mass radius:(CGFloat)radius offset:(CGVector)offset{
    return [CMBody bodyWithMass:mass moment:cpMomentForCircle(mass, 0, radius, cpv(offset.dx,offset.dy))];
}


+(CMBody *)bodyWithMass:(CGFloat)mass moment:(CGFloat)moment{
    return [[CMBody alloc] initWithMass:mass moment:moment];
}
+(CMBody *)staticBody{
    return [[CMBody alloc] initStaticBody];
}
+(CMBody *)staticBodyWithBody:(cpBody *)body{
    return [[CMBody alloc] initWithBody:body];
}


-(id)initWithBody:(cpBody *)body{
    self = [super init];
    if (self) {
        _body = body;
        cpBodySetUserData(body, (__bridge void*)self);
    }
    return self;
}

-(id)initWithMass:(CGFloat)mass moment:(CGFloat)moment{
    self = [self initWithBody:cpBodyNew(mass, moment)];
    return self;
}
-(id)initStaticBody{
    return [self initWithBody:cpBodyNewStatic()];
}

-(void)dealloc{
    cpBodyFree(_body);
}


#pragma mark - NSCoding Delegate Methods
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [self initWithMass:[aDecoder decodeFloatForKey:@"mass"] moment:[aDecoder decodeFloatForKey:@"moment"]];
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeFloat:self.mass forKey:@"mass"];
    [aCoder encodeFloat:self.moment forKey:@"moment"];
#warning encode other values and test (position,force,...)
}


-(CGFloat)mass{
    return cpBodyGetMass(_body);
}
-(void)setMass:(CGFloat)mass{
    cpBodySetMass(_body, mass);
}

-(CGFloat)moment{
    return cpBodyGetMoment(_body);
}
-(void)setMoment:(CGFloat)moment{
    cpBodySetMoment(_body, moment);
}

-(void)setPosition:(CGPoint)position{
    cpBodySetPos(_body, cpv(position.x, position.y));
    [self reindexShapes];
}
-(CGPoint)position{
    return CGPointMake(_body->p.x, _body->p.y);
}

-(void)setVelocity:(CGVector)velocity{
    cpBodySetVel(_body, cpv(velocity.dx, velocity.dy));
}
-(CGVector)velocity{
    return CGVectorMake(_body->v.x, _body->v.y);
}

-(void)setForce:(CGVector)force{
    cpBodySetForce(_body, cpv(force.dx, force.dy));
}
-(CGVector)force{
    return CGVectorMake(_body->f.x, _body->f.y);
}

-(void)setAngle:(CGFloat)angle{
    cpBodySetAngle(_body, angle);
    [self reindexShapes];
}
-(CGFloat)angle{
    return cpBodyGetAngle(_body);
}

-(void)setAngularVelocity:(CGFloat)angularVelocity{
    cpBodySetAngVel(_body, angularVelocity);
}
-(CGFloat)angularVelocity{
    return cpBodyGetAngVel(_body);
}

-(void)setTorque:(CGFloat)torque{
    cpBodySetTorque(_body, torque);
}
-(CGFloat)torque{
    return cpBodyGetTorque(_body);
}

-(void)setMaxAngularVelocity:(CGFloat)maxAngularVelocity{
    cpBodySetAngVelLimit(_body, maxAngularVelocity);
}
-(CGFloat)maxAngularVelocity{
    return cpBodyGetAngVelLimit(_body);
}

-(void)setMaxVelocity:(CGFloat)maxVelocity{
    cpBodySetVelLimit(_body, maxVelocity);
}
-(CGFloat)maxVelocity{
    return cpBodyGetVelLimit(_body);
}

-(BOOL)isSleeping{
    return cpBodyIsSleeping(_body);
}
-(BOOL)isRogue{
    return cpBodyIsRogue(_body);
}
-(BOOL)isStatic{
    return cpBodyIsStatic(_body);
}


-(void)reindexShapes{
    if(self.space){
        cpSpaceReindexShapesForBody(self.space.space, self.body);
    }
}

#pragma mark - Shapes
-(CMShape *)addShape:(CMShape *)shape{
    if(!_shapes)_shapes = [NSMutableSet set];
    shape.body = self;
    [(NSMutableSet *)self.shapes addObject:shape];
    if(self.space)[self.space addBaseObject:shape];
    return shape;
}

#pragma mark - Space Assigning

-(void)setSpace:(CMSpace *)space{
    if (self.space) {
        cpSpaceRemoveBody(self.space.space, self.body);
    }
    [super setSpace:space];
    if (self.space && ![self isStatic]) {
        cpSpaceAddBody(self.space.space, self.body);
    }
    [self updatePositionFromNode];
    for (CMShape *shape in self.shapes) {
        [self.space addBaseObject:shape];
    }
}

-(void)updatePositionFromNode{
    [self.node chipmunk_updateBodyPosition:self];
}

#pragma mark - Forces
-(void)resetForces{
    cpBodyResetForces(self.body);
}
-(void)applyForce:(CGVector)force{
    [self applyForce:force offset:CGVectorMake(0, 0)];
}
-(void)applyForce:(CGVector)force offset:(CGVector)offset{
    cpBodyApplyForce(self.body, cpv(force.dx, force.dy), cpv(offset.dx, offset.dy));
}
-(void)applyImpulse:(CGVector)impulse{
    [self applyImpulse:impulse offset:CGVectorMake(0, 0)];
}
-(void)applyImpulse:(CGVector)impulse offset:(CGVector)offset{
    cpBodyApplyForce(self.body, cpv(impulse.dx, impulse.dy), cpv(offset.dx, offset.dy));
}

//#pragma mark - Node
//-(void)setNode:(id<CMBodyNode>)node{
//    cpBodySetUserData(_body, (__bridge void*)node);
//}
//-(id<CMBodyNode>)node{
//    return (__bridge id<CMBodyNode>)cpBodyGetUserData(_body);
//}

@end
