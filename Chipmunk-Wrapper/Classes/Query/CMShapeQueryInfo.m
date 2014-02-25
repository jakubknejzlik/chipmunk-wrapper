//
//  CMShapeQueryInfo.m
//  astroman
//
//  Created by Jakub Knejzlik on 22/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMShapeQueryInfo.h"

@implementation CMShapeQueryInfo{
    cpContactPointSet *_contacts;
}

-(id)initWithShape:(cpShape *)shape contacts:(cpContactPointSet *)contacts{
    self = [super init];
    if (self) {
        self.shape = (__bridge CMShape *)cpShapeGetUserData(shape);
        _contacts = contacts;
    }
    return self;
}

-(NSInteger)contactsCount{
    return _contacts->count;
}

-(CGVector)pointForContactAtIndex:(NSInteger)index{
    cpVect v = _contacts[index].points->point;
    return CGVectorMake(v.x, v.y);
}
-(CGVector)normalForContactAtIndex:(NSInteger)index{
    cpVect v = _contacts[index].points->normal;
    return CGVectorMake(v.x, v.y);
}
-(CGFloat)distanceForContactAtIndex:(NSInteger)index{
    return _contacts[index].points->dist;
}


@end
