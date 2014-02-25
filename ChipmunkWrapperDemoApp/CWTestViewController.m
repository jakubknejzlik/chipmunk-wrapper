//
//  CWTestViewController.m
//  ChipmunkWrapper
//
//  Created by Jakub Knejzlik on 25/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CWTestViewController.h"

#import "CWTestScene.h"

@interface CWTestViewController ()

@end

@implementation CWTestViewController

-(void)loadView{
    SKView *view = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    view.showsFPS = YES;
    view.showsNodeCount = YES;
    
    self.view = view;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    CWTestScene *scene = [[CWTestScene alloc] initWithSize:self.view.bounds.size];
    
    [(SKView *)self.view presentScene:scene];
}

@end
