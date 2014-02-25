//
//  CMArbiter.h
//  astroman
//
//  Created by Jakub Knejzlik on 21/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "chipmunk.h"

@interface CMArbiter : NSObject
/** The calculated elasticity for this collision pair. Setting the value in a preSolve() callback will override the value calculated by the space. The default calculation multiplies the elasticity of the two shapes together.*/
@property (nonatomic) CGFloat elasticity;
/** The calculated friction for this collision pair. Setting the value in a preSolve() callback will override the value calculated by the space. The default calculation multiplies the friction of the two shapes together.*/
@property (nonatomic) CGFloat friction;
/** The calculated surface velocity for this collision pair. Setting the value in a preSolve() callback will override the value calculated by the space. the default calculation subtracts the surface velocity of the second shape from the first and then projects that onto the tangent of the collision. This is so that only friction is affected by default calculation. Using a custom calculation, you can make something that responds like a pinball bumper, or where the surface velocity is dependent on the location of the contact point. */
@property (nonatomic) CGVector surfaceVelocity;
/** Get the number of contacts tracked by this arbiter or the specific collision point, collision normal or penetration depth of a collision point.*/
@property (nonatomic,readonly) int count;
-(CGVector)normalForContactAtIndex:(int)contactIndex;
-(CGVector)pointForContactAtIndex:(int)contactIndex;
-(CGFloat)depthForContactAtIndex:(int)contactIndex;
/** Returns true if this is the first step the two shapes started touching. This can be useful for sound effects for instance. If it’s the first frame for a certain collision, check the energy of the collision in a postStep() callbock and use that to determine the volume of a sound effect to play.*/
@property (nonatomic,getter = isFirstContact) BOOL firstContact;

-(NSArray *)shapes;
-(NSArray *)bodies;

-(id)initWithArbiter:(cpArbiter *)arbiter;

@end
