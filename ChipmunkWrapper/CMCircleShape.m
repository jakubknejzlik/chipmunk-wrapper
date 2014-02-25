//
//  CMCircleShape.m
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMCircleShape.h"

#import "CMWrapper.h"

@implementation CMCircleShape
+(CMCircleShape *)circleShapeWithBody:(CMBody *)body radius:(CGFloat)radius offset:(CGVector)offset{
    return [[CMCircleShape alloc] initWithBody:body radius:radius offset:offset];
}
-(id)initWithBody:(CMBody *)body radius:(CGFloat)radius offset:(CGVector)offset{
    return [super initWithBody:body shape:cpCircleShapeNew(body.body, radius, cpv(offset.dx, offset.dy))];
}


@end
