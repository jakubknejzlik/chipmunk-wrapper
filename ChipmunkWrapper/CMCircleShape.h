//
//  CMCircleShape.h
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMShape.h"

@interface CMCircleShape : CMShape

+(CMCircleShape *)circleShapeWithBody:(CMBody *)body radius:(CGFloat)radius offset:(CGVector)offset;

-(id)initWithBody:(CMBody *)body radius:(CGFloat)radius offset:(CGVector)offset;

@end
