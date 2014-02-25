//
//  CMNearestPointQueryInfo.m
//  astroman
//
//  Created by Jakub Knejzlik on 22/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMNearestPointQueryInfo.h"

@implementation CMNearestPointQueryInfo{
    cpNearestPointQueryInfo _info;
}

-(id)initWithInfo:(cpNearestPointQueryInfo)info{
    self = [super init];
    if (self) {
        _info = info;
    }
    return self;
}

-(CMShape *)shape{
    return (__bridge CMShape *)cpShapeGetUserData(_info.shape);
}
-(CGVector)point{
    return CGVectorMake(_info.p.x, _info.p.y);
}
-(CGFloat)distance{
    return _info.d;
}
-(CGVector)gradient{
    return CGVectorMake(_info.g.x, _info.g.y);
}

@end
