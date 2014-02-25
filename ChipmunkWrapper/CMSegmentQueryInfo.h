//
//  CMSegmentQueryInfo.h
//  astroman
//
//  Created by Jakub Knejzlik on 22/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "chipmunk.h"

@class CMShape;

@interface CMSegmentQueryInfo : NSObject
/** The shape that was hit, NULL if no collision occured. */
@property (nonatomic,readonly) CMShape *shape;
/** The normalized distance along the query segment in the range [0, 1]. */
@property (nonatomic,readonly) CGFloat normalizedDistance;
/** The normal of the surface hit. */
@property (nonatomic,readonly) CGVector normal;


-(id)initWithQueryInfo:(cpSegmentQueryInfo)queryInfo;
-(id)initWithShape:(cpShape *)shape normalizedDistance:(CGFloat)normalizedDistance normal:(cpVect)normal;

@end
