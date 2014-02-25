//
//  CMBaseObject.h
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMObject.h"

@class CMSpace;

@interface CMBaseObject : CMObject
@property (nonatomic,assign) CMSpace *space;
@end
