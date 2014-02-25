//
//  CMJoint.h
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMBaseObject.h"

#import "CMBody.h"
#import "chipmunk.h"

@interface CMConstraint : CMBaseObject
@property (nonatomic,weak) CMSpace *space;
@property (nonatomic,strong) CMBody *bodyA;
@property (nonatomic,strong) CMBody *bodyB;
@property (nonatomic,readonly) cpConstraint *constraint;

-(id)initWithJoint:(cpConstraint *)joint bodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB;

@end
