//
//  CMDampedSpring.m
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMDampedSpring.h"

@implementation CMDampedSpring

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB anchor1:(CGVector)anchor1 anchor2:(CGVector)anchor2 restLength:(CGFloat)restLength stiffness:(CGFloat)stiffness damping:(CGFloat)damping{
    self = [super initWithJoint:cpDampedSpringNew(bodyA.body, bodyB.body, cpv(anchor1.dx, anchor1.dy), cpv(anchor2.dx, anchor2.dy), restLength, stiffness, damping) bodyA:bodyA bodyB:bodyB];
    return self;
}


-(void)setAnchor1:(CGVector)anchor1{
    cpDampedSpringSetAnchr1(self.constraint, cpv(anchor1.dx, anchor1.dy));
}
-(CGVector)anchor1{
    cpVect v = cpDampedSpringGetAnchr1(self.constraint);
    return CGVectorMake(v.x, v.y);
}

-(void)setAnchor2:(CGVector)anchor2{
    cpDampedSpringSetAnchr1(self.constraint, cpv(anchor2.dx, anchor2.dy));
}
-(CGVector)anchor2{
    cpVect v = cpDampedSpringGetAnchr2(self.constraint);
    return CGVectorMake(v.x, v.y);
}

-(void)setRestLength:(CGFloat)restLength{
    cpDampedSpringSetRestLength(self.constraint, restLength);
}
-(CGFloat)restLength{
    return cpDampedSpringGetRestLength(self.constraint);
}

-(void)setStiffness:(CGFloat)stiffness{
    cpDampedSpringSetStiffness(self.constraint, stiffness);
}
-(CGFloat)stiffness{
    return cpDampedSpringGetStiffness(self.constraint);
}

-(void)setDamping:(CGFloat)damping{
    cpDampedSpringSetDamping(self.constraint, damping);
}
-(CGFloat)damping{
    return cpDampedSpringGetDamping(self.constraint);
}

@end
