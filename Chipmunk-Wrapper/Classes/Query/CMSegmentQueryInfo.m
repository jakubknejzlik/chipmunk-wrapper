//
//  CMSegmentQueryInfo.m
//  astroman
//
//  Created by Jakub Knejzlik on 22/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMSegmentQueryInfo.h"

@implementation CMSegmentQueryInfo{
    cpSegmentQueryInfo _queryInfo;
}

-(id)initWithQueryInfo:(cpSegmentQueryInfo)queryInfo{
    self = [super init];
    if (self) {
        _queryInfo = queryInfo;
    }
    return self;
}
-(id)initWithShape:(cpShape *)shape normalizedDistance:(CGFloat)normalizedDistance normal:(cpVect)normal{
    cpSegmentQueryInfo info = {};
    info.shape = shape;
    info.t = normalizedDistance;
    info.n = normal;
    self = [self initWithQueryInfo:info];
    return self;
}

-(CMShape *)shape{
    return (__bridge CMShape *)cpShapeGetUserData(_queryInfo.shape);
}
-(CGFloat)normalizedDistance{
    return _queryInfo.t;
}
-(CGVector)normal{
    return CGVectorMake(_queryInfo.n.x, _queryInfo.n.y);
}

@end
