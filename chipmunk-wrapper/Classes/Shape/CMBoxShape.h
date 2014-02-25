//
//  CMBoxShape.h
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMShape.h"

@interface CMBoxShape : CMShape

+(CMBoxShape *)boxShapeWithBody:(CMBody *)body size:(CGSize)size;
-(id)initWithBody:(CMBody *)body size:(CGSize)size;

@end
