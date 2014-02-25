//
//  CMNearestPointQueryInfo.h
//  astroman
//
//  Created by Jakub Knejzlik on 22/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "chipmunk.h"

@class CMShape;

@interface CMNearestPointQueryInfo : NSObject
/** The nearest shape, NULL if no shape was within range.*/
@property (nonatomic,readonly) CMShape *shape;
/** The closest point on the shape's surface. (in world space coordinates) */
@property (nonatomic,readonly) CGVector point;
/** The distance to the point. The distance is negative if the point is inside the shape.*/
@property (nonatomic,readonly) CGFloat distance;
/** The gradient of the distance function. The same as info.p/info.d, but accurate even for very small values of info.d.*/
@property (nonatomic,readonly) CGVector gradient;

-(id)initWithInfo:(cpNearestPointQueryInfo)info;

@end
