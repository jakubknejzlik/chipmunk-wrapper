//
//  CMSlideJoint.m
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMSlideJoint.h"

@implementation CMSlideJoint

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB anchor1:(CGVector)anchor1 anchor2:(CGVector)anchor2 min:(CGFloat)min max:(CGFloat)max{
    self = [super initWithJoint:cpSlideJointNew(bodyA.body, bodyB.body, cpv(anchor1.dx, anchor1.dy), cpv(anchor2.dx, anchor2.dy), min, max) bodyA:bodyA bodyB:bodyB];
    if (self) {
        
    }
    return self;
}

-(void)setMin:(CGFloat)min{
    cpSlideJointSetMin(self.constraint, min);
}
-(CGFloat)min{
    return cpSlideJointGetMin(self.constraint);
}

-(void)setMax:(CGFloat)max{
    cpSlideJointSetMax(self.constraint, max);
}
-(CGFloat)max{
    return cpSlideJointGetMax(self.constraint);
}


@end
