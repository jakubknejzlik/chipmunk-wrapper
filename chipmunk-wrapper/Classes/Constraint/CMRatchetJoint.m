//
//  CMRatchetJoint.m
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMRatchetJoint.h"

@implementation CMRatchetJoint

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB phase:(CGFloat)phase ratchet:(CGFloat)ratchet{
    self = [super initWithJoint:cpRatchetJointNew(bodyA.body, bodyB.body, phase, ratchet) bodyA:bodyA bodyB:bodyB];
    return self;
}


-(void)setPhase:(CGFloat)phase{
    cpRatchetJointSetPhase(self.constraint, phase);
}
-(CGFloat)phase{
    return cpRatchetJointGetPhase(self.constraint);
}

-(void)setRatchet:(CGFloat)ratchet{
    cpRatchetJointSetRatchet(self.constraint, ratchet);
}
-(CGFloat)ratchet{
    return cpRatchetJointGetRatchet(self.constraint);
}

@end
