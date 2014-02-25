//
//  CMSpace.h
//  astroman
//
//  Created by Jakub Knejzlik on 17/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "chipmunk.h"

@class CMBaseObject,CMConstraint,CMBody,CMShape,CMArbiter,CMSegmentQueryInfo,CMShapeQueryInfo,CMNearestPointQueryInfo;
@protocol CMSpaceDelegate;

@interface CMSpace : NSObject<NSCoding>
@property (nonatomic,assign) id<CMSpaceDelegate> delegate;
@property (nonatomic,assign) id data;
@property (nonatomic,readonly) CMBody *staticBody;
@property (nonatomic,readonly) cpSpace *space;
/** Iterations allow you to control the accuracy of the solver. Defaults to 10.*/
@property (nonatomic) CGFloat iterations;
/** Global gravity applied to the space. Defaults to {0,0}.*/
@property (nonatomic) CGVector gravity;
/** Amount of simple damping to apply to the space. A value of 0.9 means that each body will lose 10% of it’s velocity per second. Defaults to 1.*/
@property (nonatomic) CGFloat damping;
/** Speed threshold for a body to be considered idle. The default value of 0 means to let the space guess a good threshold based on gravity.*/
@property (nonatomic) CGFloat idleSpeedTreshold;
/** Time a group of bodies must remain idle in order to fall asleep. The default value of INFINITY disables the sleeping feature.*/
@property (nonatomic) CGFloat sleepTimeThreshold;
/** Amount of overlap between shapes that is allowed. It’s encouraged to set this as high as you can without noticable overlapping as it improves the stability. It defaults to 0.1.*/
@property (nonatomic) CGFloat collisionSlop;
/**
 * Chipmunk allows fast moving objects to overlap, then fixes the overlap over time. Overlapping objects are unavoidable even if swept collisions are supported, and this is an efficient and stable way to deal with overlapping objects.
 * The bias value controls what percentage of overlap remains unfixed after a second and defaults to ~0.2%. Valid values are in the range from 0 to 1, but using 0 is not recommended for stability reasons.
 * The default value is calculated as cpfpow(1.0f - 0.1f, 60.0f) meaning that Chipmunk attempts to correct 10% of error ever 1/60th of a second. Note: Very very few games will need to change this value.
 */
@property (nonatomic) CGFloat collisionBias;
/** The number of frames the space keeps collision solutions around for. Helps prevent jittering contacts from getting worse. This defaults to 3 and very very very few games will need to change this value.*/
@property (nonatomic) NSUInteger collisionPersistence;
/** Retrieves the current (if you are in a callback from cpSpaceStep()) or most recent (outside of a cpSpaceStep() call) timestep.*/
@property (nonatomic,readonly) CGFloat currentTimeStep;

@property CGFloat currentRepeatInterval;

@property CGFloat simulationSpeed;
@property (getter = isPaused) BOOL paused;
@property (nonatomic,strong) NSMutableSet *baseObjects;

-(id)initWithBoundaries:(CGRect)boundaries;

-(void)step:(NSTimeInterval)interval;

-(void)startSimulation:(NSTimeInterval)repeatInterval;
-(void)stopSimulation;


-(void)addPostStepBlock:(void(^)(CMSpace *space))block;
-(void)addCollisionHandlerTypeA:(id)typeA typeB:(id)typeB begin:(BOOL(^)(CMArbiter *arbiter, CMSpace *space))begin preSolve:(BOOL(^)(CMArbiter *arbiter, CMSpace *space))preSolve postSolve:(void(^)(CMArbiter *arbiter, CMSpace *space))postSolve separate:(void(^)(CMArbiter *arbiter, CMSpace *space))separate;

-(CMBaseObject *)addBaseObject:(CMBaseObject *)object;
-(void)removeBaseObject:(CMBaseObject *)object;
-(void)postStepRemoval:(CMBaseObject *)object;

/** Query space at point and return the closest shape within maxDistance units of distance. out is an optional pointer to a cpNearestPointQueryInfo if you want additional information about the match.*/
-(CMNearestPointQueryInfo *)nearestInfoForPoint:(CGPoint)point maxDistance:(CGFloat)maxDistance layers:(NSUInteger)layers group:(id)group;
-(NSArray *)segmentQueryFrom:(CGPoint)from to:(CGPoint)to layers:(NSUInteger)layers group:(id)group;
-(CMSegmentQueryInfo *)segmentQueryFirstFrom:(CGPoint)from to:(CGPoint)to layers:(NSUInteger)layers group:(id)group;
-(NSArray *)shapesInRect:(CGRect)rect layers:(NSUInteger)layers group:(id)group;
-(NSArray *)shapesInCircleAtPoint:(CGPoint)center radius:(CGFloat)radius layers:(NSUInteger)layers group:(id)group;
-(NSArray *)shapesOverlapingShape:(CMShape *)shape;

-(CMShape *)shapeAtPoint:(CGPoint)point layers:(cpLayers)layers group:(id)group;
-(NSArray *)shapesAtPoint:(CGPoint)point layers:(cpLayers)layers group:(id)group;

@end

@protocol CMSpaceDelegate <NSObject>
@optional
-(void)space:(CMSpace *)space willStepWithInterval:(NSTimeInterval)interval;
-(void)space:(CMSpace *)space didStepWithInterval:(NSTimeInterval)interval;

@end
