//
//  CMRotaryLimitJoint.h
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

@interface CMRotaryLimitJoint : CMConstraint
@property (nonatomic) CGFloat min;
@property (nonatomic) CGFloat max;

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB min:(CGFloat)min max:(CGFloat)max;

@end
