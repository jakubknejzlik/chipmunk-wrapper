//
//  CMDampedSpring.h
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

@interface CMDampedSpring : CMConstraint
@property (nonatomic) CGVector anchor1;
@property (nonatomic) CGVector anchor2;
@property (nonatomic) CGFloat restLength;
@property (nonatomic) CGFloat stiffness;
@property (nonatomic) CGFloat damping;

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB anchor1:(CGVector)anchor1 anchor2:(CGVector)anchor2 restLength:(CGFloat)restLength stiffness:(CGFloat)stiffness damping:(CGFloat)damping;

@end
