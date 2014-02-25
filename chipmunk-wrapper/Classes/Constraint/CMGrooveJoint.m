//
//  CMGrooveJoint.m
//  astroman
//
//  Created by Jakub Knejzlik on 19/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMGrooveJoint.h"

@implementation CMGrooveJoint

-(id)initWithBodyA:(CMBody *)bodyA bodyB:(CMBody *)bodyB grooveA:(CGVector)grooveA grooveB:(CGVector)grooveB anchor2:(CGVector)anchor2{
    self = [super initWithJoint:cpGrooveJointNew(bodyA.body, bodyB.body, cpv(grooveA.dx, grooveA.dy), cpv(grooveB.dx, grooveB.dy), cpv(anchor2.dx, anchor2.dy)) bodyA:bodyA bodyB:bodyB];
    return self;
}


-(void)setGrooveA:(CGVector)grooveA{
    cpGrooveJointSetGrooveA(self.constraint, cpv(grooveA.dx, grooveA.dy));
}
-(CGVector)grooveA{
    cpVect v = cpGrooveJointGetGrooveA(self.constraint);
    return CGVectorMake(v.x, v.y);
}

-(void)setGrooveB:(CGVector)grooveB{
    cpGrooveJointSetGrooveB(self.constraint, cpv(grooveB.dx, grooveB.dy));
}
-(CGVector)grooveB{
    cpVect v = cpGrooveJointGetGrooveB(self.constraint);
    return CGVectorMake(v.x, v.y);
}

-(void)setAnchor2:(CGVector)anchor2{
    cpGrooveJointSetAnchr2(self.constraint, cpv(anchor2.dx, anchor2.dy));
}
-(CGVector)anchor2{
    cpVect v = cpGrooveJointGetAnchr2(self.constraint);
    return CGVectorMake(v.x, v.y);
}



@end
