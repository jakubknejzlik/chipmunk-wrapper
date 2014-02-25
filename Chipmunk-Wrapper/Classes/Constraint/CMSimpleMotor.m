//
//  CMSimpleMotor.m
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMSimpleMotor.h"

@implementation CMSimpleMotor

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB rate:(CGFloat)rate{
    self = [super initWithJoint:cpSimpleMotorNew(bodyA.body, bodyB.body, rate) bodyA:bodyA bodyB:bodyB];
    return self;
}


-(void)setRate:(CGFloat)rate{
    cpSimpleMotorSetRate(self.constraint, rate);
}
-(CGFloat)rate{
    return cpSimpleMotorGetRate(self.constraint);
}

@end
