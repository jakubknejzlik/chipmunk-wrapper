//
//  CMShape.h
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMBaseObject.h"

#import "chipmunk.h"

@class CMBody,CMSpace,CMNearestPointQueryInfo,CMSegmentQueryInfo;

@interface CMShape : CMBaseObject
@property (nonatomic,weak) CMSpace *space;
@property (nonatomic,weak) CMBody *body;
@property (nonatomic,readonly) cpShape *shape;
/** A boolean value if this shape is a sensor or not. Sensors only call collision callbacks, and never generate real collisions.*/
@property (nonatomic,getter = isSensor) BOOL sensor;
/** Elasticity of the shape. A value of 0.0 gives no bounce, while a value of 1.0 will give a “perfect” bounce. However due to inaccuracies in the simulation using 1.0 or greater is not recommended however. The elasticity for a collision is found by multiplying the elasticity of the individual shapes together. */
@property (nonatomic) CGFloat elasticity;
/** Friction coefficient. Chipmunk uses the Coulomb friction model, a value of 0.0 is frictionless. The friction for a collision is found by multiplying the friction of the individual shapes together. */
@property (nonatomic) CGFloat friction;
/** The surface velocity of the object. Useful for creating conveyor belts or players that move around. This value is only used when calculating friction, not resolving the collision. */
@property (nonatomic) CGVector surfaceVelocity;
/** You can assign types to Chipmunk collision shapes that trigger callbacks when objects of certain types touch.*/
@property (nonatomic) id collisionType;
/** Shapes in the same non-zero group do not generate collisions. Useful when creating an object out of many shapes that you don’t want to self collide. Defaults to CP_NO_GROUP. */
@property (nonatomic) id group;
/** Shapes only collide if they are in the same bit-planes. i.e. (a->layers & b->layers) != 0 By default, a shape occupies all bit-planes. */
@property (nonatomic) NSUInteger layers;


-(id)initWithBody:(CMBody *)body shape:(cpShape *)shape;

-(CMNearestPointQueryInfo *)nearestInfoForPoint:(CGPoint)point;
-(CMSegmentQueryInfo *)segmentQueryFrom:(CGPoint)from to:(CGPoint)to;

@end
