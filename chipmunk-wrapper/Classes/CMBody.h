//
//  CMBody.h
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMBaseObject.h"

#import "chipmunk.h"

@class CMShape,CMSpace;
@protocol CMBodyNode;

@interface CMBody : CMBaseObject
@property (nonatomic,readonly) cpBody *body;
@property (nonatomic) CGFloat mass;
@property (nonatomic) CGFloat moment;
@property (nonatomic) CGPoint position;
@property (nonatomic) CGVector velocity;
@property (nonatomic) CGVector force;
@property (nonatomic) CGFloat angle;
@property (nonatomic) CGFloat angularVelocity;
@property (nonatomic) CGFloat torque;
@property (nonatomic) CGFloat maxAngularVelocity;
@property (nonatomic) CGFloat maxVelocity;
@property (nonatomic,readonly) NSSet *shapes;

@property CGPoint previousPosition; // user for interpolation
@property CGFloat previousAngle; // user for interpolation


@property (nonatomic,strong) id<CMBodyNode> node;

+(CMBody *)boxBodyWithMass:(CGFloat)mass size:(CGSize)size;
+(CMBody *)circleBodyWithMass:(CGFloat)mass radius:(CGFloat)radius;
+(CMBody *)circleBodyWithMass:(CGFloat)mass radius:(CGFloat)radius offset:(CGVector)offset;

+(CMBody *)bodyWithMass:(CGFloat)mass moment:(CGFloat)moment;
+(CMBody *)staticBody;
+(CMBody *)staticBodyWithBody:(cpBody *)body;

-(id)initWithMass:(CGFloat)mass moment:(CGFloat)moment;
-(id)initStaticBody;
-(id)initWithBody:(cpBody *)body;

-(BOOL)isSleeping;
-(BOOL)isRogue;
-(BOOL)isStatic;


-(CMShape *)addShape:(CMShape *)shape;

-(void)updatePositionFromNode;

-(void)resetForces;
-(void)applyForce:(CGVector)force;
-(void)applyForce:(CGVector)force offset:(CGVector)offset;
-(void)applyImpulse:(CGVector)impulse;
-(void)applyImpulse:(CGVector)impulse offset:(CGVector)offset;
@end


@protocol CMBodyNode <NSObject>

-(void)chipmunk_updateBodyPosition:(CMBody *)body;
-(void)chipmunk_step:(NSTimeInterval)interval;
-(void)chipmunk_update:(NSTimeInterval)repeatInterval delta:(CGFloat)delta;

@end
