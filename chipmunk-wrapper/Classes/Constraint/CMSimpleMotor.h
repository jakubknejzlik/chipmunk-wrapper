//
//  CMSimpleMotor.h
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

@interface CMSimpleMotor : CMConstraint
@property (nonatomic) CGFloat rate;

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB rate:(CGFloat)rate;

@end
