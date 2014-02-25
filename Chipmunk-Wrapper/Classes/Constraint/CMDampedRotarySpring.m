//
//  CMDampedRotarySpring.m
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMDampedRotarySpring.h"

@implementation CMDampedRotarySpring

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB restAngle:(CGFloat)restAngle stiffness:(CGFloat)stiffness damping:(CGFloat)damping{
    self = [super initWithJoint:cpDampedRotarySpringNew(bodyA.body, bodyB.body, restAngle, stiffness, damping) bodyA:bodyA bodyB:bodyB];
    return self;
}

-(void)setRestAngle:(CGFloat)restAngle{
    cpDampedRotarySpringSetRestAngle(self.constraint, restAngle);
}
-(CGFloat)restAngle{
    return cpDampedRotarySpringGetRestAngle(self.constraint);
}

-(void)setDamping:(CGFloat)damping{
    cpDampedRotarySpringSetDamping(self.constraint, damping);
}
-(CGFloat)damping{
    return cpDampedRotarySpringGetDamping(self.constraint);
}

-(void)setStiffness:(CGFloat)stiffness{
    cpDampedRotarySpringSetStiffness(self.constraint, stiffness);
}
-(CGFloat)stiffness{
    return cpDampedRotarySpringGetStiffness(self.constraint);
}

@end
