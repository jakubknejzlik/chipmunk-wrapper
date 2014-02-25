//
//  CMPinJoint.m
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMPinJoint.h"

@implementation CMPinJoint

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB anchor1:(CGVector)anchor1 anchor2:(CGVector)anchor2{
    self = [super initWithJoint:cpPinJointNew(bodyA.body, bodyB.body, cpvzero, cpvzero) bodyA:bodyA bodyB:bodyB];
    if (self) {
        self.anchor1 = anchor1;
        self.anchor2 = anchor2;
    }
    return self;
}

-(void)setAnchor1:(CGVector)anchor1{
    cpPinJointSetAnchr1(self.constraint, cpv(anchor1.dx,anchor1.dy));
}
-(CGVector)anchor1{
    cpVect v = cpPinJointGetAnchr1(self.constraint);
    return CGVectorMake(v.x, v.y);
}

-(void)setAnchor2:(CGVector)anchor2{
    cpPinJointSetAnchr2(self.constraint, cpv(anchor2.dx,anchor2.dy));
}
-(CGVector)anchor2{
    cpVect v = cpPinJointGetAnchr2(self.constraint);
    return CGVectorMake(v.x, v.y);
}

-(void)setDistance:(CGFloat)distance{
    cpPinJointSetDist(self.constraint, distance);
}
-(CGFloat)distance{
    return cpPinJointGetDist(self.constraint);
}

@end
