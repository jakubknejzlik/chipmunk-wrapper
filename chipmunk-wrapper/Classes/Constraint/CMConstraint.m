//
//  CMJoint.m
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

#import "CMWrapper.h"

@implementation CMConstraint{
    cpConstraint *_constraint;
}

-(id)initWithJoint:(cpConstraint *)joint bodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB{
    self = [super init];
    if (self) {
        _constraint = joint;
        self.bodyA = bodyA;
        self.bodyB = bodyB;
    }
    return self;
}

-(void)setSpace:(CMSpace *)space{
    [super setSpace:space];
    cpSpaceAddConstraint(space.space, self.constraint);
}

-(cpConstraint *)constraint{
    return _constraint;
}

-(void)dealloc{
    cpConstraintFree(_constraint);
}

@end
