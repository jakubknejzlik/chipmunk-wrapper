//
//  CMBoxShape.m
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMBoxShape.h"

#import "CMWrapper.h"

@implementation CMBoxShape

+(CMBoxShape *)boxShapeWithBody:(CMBody *)body size:(CGSize)size{
    return [[CMBoxShape alloc] initWithBody:body size:size];
}

-(id)initWithBody:(CMBody *)body size:(CGSize)size{
    return [super initWithBody:body shape:cpBoxShapeNew(body.body, size.width, size.height)];
}

@end
