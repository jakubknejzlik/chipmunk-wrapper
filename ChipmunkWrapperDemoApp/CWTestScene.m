//
//  CWTestScene.m
//  ChipmunkWrapper
//
//  Created by Jakub Knejzlik on 25/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CWTestScene.h"

#import "CMWrapper+SpriteKit.h"

@implementation CWTestScene

-(id)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if (self) {
        self.chipmunk_space = [[CMSpace alloc] initWithBoundaries:self.frame];
        self.chipmunk_space.gravity = CGVectorMake(0, -100);
        
        [self.chipmunk_space startSimulation:1.0/60.0];
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    SKSpriteNode *node = [[SKSpriteNode alloc] initWithImageNamed:@"sprite.png"];
    node.position = [[touches anyObject] locationInNode:self];
    node.size = CGSizeMake(30, 30);
    
    node.chipmunk_body = [CMBody boxBodyWithMass:10 size:node.size];
    
    CMShape *shape = [CMBoxShape boxShapeWithBody:node.chipmunk_body size:node.size];
    shape.friction = 1;
    [node.chipmunk_body addShape:shape];
    
    [self chipmunk_addChild:node];
}

@end
