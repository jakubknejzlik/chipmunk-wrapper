//
//  CMRatchetJoint.h
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

@interface CMRatchetJoint : CMConstraint
@property (nonatomic) CGFloat phase;
@property (nonatomic) CGFloat ratchet;

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB phase:(CGFloat)phase ratchet:(CGFloat)ratchet;

@end
