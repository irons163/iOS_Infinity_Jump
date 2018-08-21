//
//  GameScene.h
//  Try_Infinity_Jump
//

//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ViewController.h"

extern int junpMaxLimit;

@interface GameScene : SKScene
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval lastSpawnMoveTimeInterval;
@property (nonatomic) NSTimeInterval lastSpawnCreateFootboardTimeInterval;
@property (weak) id<gameDelegate> gameDelegate;
@end
