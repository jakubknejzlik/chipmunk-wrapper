//
//  CMGearJoint.m
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMGearJoint.h"

@implementation CMGearJoint

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB phase:(CGFloat)phase ratio:(CGFloat)ratio{
    self = [super initWithJoint:cpGearJointNew(bodyA.body, bodyB.body, phase, ratio) bodyA:bodyA bodyB:bodyB];
    return self;
}

-(void)setPhase:(CGFloat)phase{
    cpGearJointSetPhase(self.constraint, phase);
}
-(CGFloat)phase{
    return cpGearJointGetPhase(self.constraint);
}

-(void)setRatio:(CGFloat)ratio{
    cpGearJointSetRatio(self.constraint, ratio);
}
-(CGFloat)ratio{
    return cpGearJointGetRatio(self.constraint);
}


@end
