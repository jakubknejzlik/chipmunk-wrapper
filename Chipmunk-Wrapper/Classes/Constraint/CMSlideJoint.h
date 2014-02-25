//
//  CMSlideJoint.h
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

@interface CMSlideJoint : CMConstraint
@property (nonatomic) CGFloat min;
@property (nonatomic) CGFloat max;

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB anchor1:(CGVector)anchor1 anchor2:(CGVector)anchor2 min:(CGFloat)min max:(CGFloat)max;

@end
