//
//  SKNode+ChipmunkBinding.m
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CMWrapper+SpriteKit.h"

#import "CMBody.h"
#import "CMSpace.h"

@implementation SKNode (ChipmunkSpriteKit)

-(void)setChipmunk_body:(CMBody *)chipmunk_body{
    [[self _userData] setObject:chipmunk_body forKey:BODY_USER_DATA_KEY];
    chipmunk_body.node = self;
}
-(CMBody *)chipmunk_body{
    return [[self _userData] objectForKey:BODY_USER_DATA_KEY];
}


-(NSMutableDictionary *)_userData{
    if(!self.userData)self.userData = [NSMutableDictionary dictionary];
    return self.userData;
}

-(void)chipmunk_update:(NSTimeInterval)repeatInterval delta:(CGFloat)delta{
    if(!self.chipmunk_body.isStatic){
//        NSLog(@"%@ ... %@",NSStringFromCGPoint(self.chipmunk_body.previousPosition),NSStringFromCGPoint(self.chipmunk_body.position));
        CMBody *body = self.chipmunk_body;
        cpVect pos = body.position;
        //????
        cpVect prevPos = body.previousPosition;//[(SKNode *)self.chipmunk_body.space.data convertPoint:self.position fromNode:self.parent];
        self.position = cpvlerp(prevPos, pos, delta);
//        CGVector vel = body.velocity;
//        self.position = cpvlerp(pos, cpv(pos.x + vel.dx*repeatInterval,pos.y + vel.dy*repeatInterval), delta);//[(SKNode *)self.chipmunk_body.space.data convertPoint:self.chipmunk_body.position toNode:self.parent];
//        NSLog(@"%@ + %@ * %f => %@",NSStringFromCGPoint(prevPos),NSStringFromCGPoint(pos),delta,NSStringFromCGPoint(self.position));
    //    self.position = cpvlerp(pos, cpv(pos.x + self.chipmunk_body.velocity.dx,pos.y + self.chipmunk_body.velocity.dy), delta);
        self.zRotation = cpflerp(body.previousAngle, body.angle, delta);
        
//        NSLog(@"%@",NSStringFromCGPoint(self.position));
//        self.position = self.chipmunk_body.position;
//        self.zRotation = self.chipmunk_body.angle;
    }else {
        self.position = self.chipmunk_body.position;
        self.zRotation = self.chipmunk_body.angle;
    }
}

-(void)chipmunk_updatePhysicsBody{
    [self chipmunk_updateBodyPosition:self.chipmunk_body];
}
-(void)chipmunk_updateBodyPosition:(CMBody *)body{
    body.position = [(SKNode *)body.space.data convertPoint:self.position fromNode:self.parent];
    body.angle = self.zRotation;
}


-(void)chipmunk_step:(NSTimeInterval)interval{
}
-(void)chipmunk_addChild:(SKNode *)childNode{
    [self addChild:childNode];
    if(childNode.chipmunk_body)[self.scene.chipmunk_space addBaseObject:childNode.chipmunk_body];
}

@end


@implementation SKScene (ChipmunkSpriteKit)

-(void)setChipmunk_space:(CMSpace *)chipmunk_space{
    [self setChipmunk_space:chipmunk_space withRootNode:self];
}
-(void)setChipmunk_space:(CMSpace *)chipmunk_space withRootNode:(SKNode *)rootNode{
    [[self _userData] setObject:chipmunk_space forKey:SPACE_USER_DATA_KEY];
    chipmunk_space.data = rootNode;
}
-(CMSpace *)chipmunk_space{
    return [[self _userData] objectForKey:SPACE_USER_DATA_KEY];
}

@end