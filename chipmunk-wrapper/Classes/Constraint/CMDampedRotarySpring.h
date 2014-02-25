//
//  CMDampedRotarySpring.h
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

@interface CMDampedRotarySpring : CMConstraint
@property (nonatomic) CGFloat restAngle;
@property (nonatomic) CGFloat stiffness;
@property (nonatomic) CGFloat damping;

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB restAngle:(CGFloat)restAngle stiffness:(CGFloat)stiffness damping:(CGFloat)damping;

@end
