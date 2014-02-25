//
//  CMGrooveJoint.h
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

@interface CMGrooveJoint : CMConstraint
@property (nonatomic) CGVector grooveA;
@property (nonatomic) CGVector grooveB;
@property (nonatomic) CGVector anchor2;

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB grooveA:(CGVector)grooveA grooveB:(CGVector)grooveB anchor2:(CGVector)anchor2;

@end
