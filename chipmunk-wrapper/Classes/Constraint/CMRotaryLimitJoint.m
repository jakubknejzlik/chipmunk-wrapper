//
//  CMRotaryLimitJoint.m
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMRotaryLimitJoint.h"

@implementation CMRotaryLimitJoint

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB min:(CGFloat)min max:(CGFloat)max{
    self = [super initWithJoint:cpRotaryLimitJointNew(bodyA.body, bodyB.body, min, max) bodyA:bodyA bodyB:bodyB];
    return self;
}


-(void)setMin:(CGFloat)min{
    cpRotaryLimitJointSetMin(self.constraint, min);
}
-(CGFloat)min{
    return cpRotaryLimitJointGetMin(self.constraint);
}

-(void)setMax:(CGFloat)max{
    cpRotaryLimitJointSetMin(self.constraint, max);
}
-(CGFloat)max{
    return cpRotaryLimitJointGetMax(self.constraint);
}

@end
