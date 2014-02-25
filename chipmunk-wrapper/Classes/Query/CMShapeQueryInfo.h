//
//  CMShapeQueryInfo.h
//  astroman
//
//  Created by Jakub Knejzlik on 22/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CMWrapper.h"

@class CMShape;

@interface CMShapeQueryInfo : NSObject
@property (nonatomic,assign) CMShape *shape;
@property (nonatomic,readonly) NSInteger contactsCount;

-(id)initWithShape:(cpShape *)shape contacts:(cpContactPointSet *)contacts;

/** The position of the contact point. */
-(CGVector)pointForContactAtIndex:(NSInteger)index;
/** The normal of the contact point. */
-(CGVector)normalForContactAtIndex:(NSInteger)index;
/** The depth of the contact point. */
-(CGFloat)distanceForContactAtIndex:(NSInteger)index;

@end
