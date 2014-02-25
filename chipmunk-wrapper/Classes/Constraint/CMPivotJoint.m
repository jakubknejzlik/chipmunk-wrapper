//
//  CMPivotJoint.m
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMPivotJoint.h"

@implementation CMPivotJoint

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB anchor1:(CGVector)anchor1 anchor2:(CGVector)anchor2{
    self = [super initWithJoint:cpPivotJointNew2(bodyA.body, bodyB.body, cpv(anchor1.dx, anchor1.dy), cpv(anchor2.dx, anchor2.dy)) bodyA:bodyA bodyB:bodyB];
    return self;
}
-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB pivot:(CGVector)pivot{
    self = [super initWithJoint:cpPivotJointNew(bodyA.body, bodyB.body, cpv(pivot.dx, pivot.dy)) bodyA:bodyA bodyB:bodyB];
    return self;
}

-(void)setAnchor1:(CGVector)anchor1{
    cpPivotJointSetAnchr1(self.constraint, cpv(anchor1.dx,anchor1.dy));
}
-(CGVector)anchor1{
    cpVect v = cpPivotJointGetAnchr1(self.constraint);
    return CGVectorMake(v.x, v.y);
}

-(void)setAnchor2:(CGVector)anchor2{
    cpPivotJointSetAnchr2(self.constraint, cpv(anchor2.dx,anchor2.dy));
}
-(CGVector)anchor2{
    cpVect v = cpPivotJointGetAnchr2(self.constraint);
    return CGVectorMake(v.x, v.y);
}

@end
