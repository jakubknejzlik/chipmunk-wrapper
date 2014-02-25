//
//  CMGearJoint.h
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMConstraint.h"

@interface CMGearJoint : CMConstraint
@property (nonatomic) CGFloat phase;
@property (nonatomic) CGFloat ratio;

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB phase:(CGFloat)phase ratio:(CGFloat)ratio;

@end
