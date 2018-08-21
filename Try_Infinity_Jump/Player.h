//
//  Player.h
//  Try_GoDownLayer
//
//  Created by irons on 2015/9/17.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Player : SKSpriteNode

-(void)jump;
-(void)setGroundY:(float)groundY;
-(void)resetJumpCount;

@end
