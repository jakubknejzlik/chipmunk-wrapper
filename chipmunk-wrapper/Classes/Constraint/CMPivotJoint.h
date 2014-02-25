//
//  CMPivotJoint.h
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

@interface CMPivotJoint : CMConstraint
@property CGVector anchor1;
@property CGVector anchor2;

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB anchor1:(CGVector)anchor1 anchor2:(CGVector)anchor2;
-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB pivot:(CGVector)pivot;

@end
