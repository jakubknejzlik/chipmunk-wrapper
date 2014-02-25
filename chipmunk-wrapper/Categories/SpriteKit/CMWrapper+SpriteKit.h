//
//  SKNode+ChipmunkBinding.h
//  astroman
//
//  Created by Jakub Knejzlik on 18/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "CMWrapper.h"

#define BODY_USER_DATA_KEY @"cm_body"
#define SPACE_USER_DATA_KEY @"cm_space"

@interface SKNode (ChipmunkSpriteKit) <CMBodyNode>
@property (nonatomic,strong) CMBody *chipmunk_body;
-(void)chipmunk_step:(NSTimeInterval)interval;

-(void)chipmunk_updatePhysicsBody;
-(void)chipmunk_addChild:(SKNode *)childNode;

@end


@interface SKScene (ChipmunkSpriteKit)
@property (nonatomic,strong) CMSpace *chipmunk_space;

-(void)setChipmunk_space:(CMSpace *)chipmunk_space withRootNode:(SKNode *)rootNode;

@end
