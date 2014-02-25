//
//  CMArbiter.m
//  astroman
//
//  Created by Jakub Knejzlik on 21/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMArbiter.h"

#import "CMWrapper.h"

@interface CMArbiter ()
@property (nonatomic) cpArbiter *arbiter;
@end

@implementation CMArbiter

-(id)initWithArbiter:(cpArbiter *)arbiter{
    self = [super init];
    if (self) {
        self.arbiter = arbiter;
    }
    return self;
}


-(void)setElasticity:(CGFloat)elasticity{
    cpArbiterSetElasticity(self.arbiter, elasticity);
}
-(CGFloat)elasticity{
    return cpArbiterGetElasticity(self.arbiter);
}

-(void)setFriction:(CGFloat)friction{
    cpArbiterSetFriction(self.arbiter, friction);
}
-(CGFloat)friction{
    return cpArbiterGetFriction(self.arbiter);
}

-(void)setSurfaceVelocity:(CGVector)surfaceVelocity{
    cpArbiterSetSurfaceVelocity(self.arbiter, cpv(surfaceVelocity.dx, surfaceVelocity.dy));
}
-(CGVector)surfaceVelocity{
    return CGVectorMake(self.arbiter->surface_vr.x, self.arbiter->surface_vr.y);
}

-(int)count{
    return cpArbiterGetCount(self.arbiter);
}
-(CGVector)normalForContactAtIndex:(int)contactIndex{
    cpVect v = cpArbiterGetNormal(self.arbiter, contactIndex);
    return CGVectorMake(v.x, v.y);
}
-(CGVector)pointForContactAtIndex:(int)contactIndex{
    cpVect v = cpArbiterGetPoint(self.arbiter, contactIndex);
    return CGVectorMake(v.x, v.y);
}
-(CGFloat)depthForContactAtIndex:(int)contactIndex{
    return cpArbiterGetDepth(self.arbiter, contactIndex);
}

-(BOOL)isFirstContact{
    return cpArbiterIsFirstContact(self.arbiter);
}

-(NSArray *)shapes{
    cpShape *a,*b;
    cpArbiterGetShapes(self.arbiter, &a, &b);
    return [NSArray arrayWithObjects:(__bridge CMShape *)cpShapeGetUserData(a),(__bridge CMShape *)cpShapeGetUserData(b), nil];
}
-(NSArray *)bodies{
    cpBody *a,*b;
    cpArbiterGetBodies(self.arbiter, &a, &b);
    return [NSArray arrayWithObjects:(__bridge CMBody *)cpBodyGetUserData(a),(__bridge CMBody *)cpBodyGetUserData(b), nil];
}


@end
