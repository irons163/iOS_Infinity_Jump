//
//  GameScene.m
//  Try_Infinity_Jump
//
//  Created by irons on 2015/10/7.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "GameScene.h"
#import "MoveableFloor.h"
#import "Player.h"
#import "Star.h"
#import "TextureHelper.h"


int FOOTBOARD_SPEED = 3;
int FOOTBOARD_SPEED_Faster = 4;
int FOOTBOARD_Fastest = 5;
float DOWNSPEED = 10;
int junpMaxLimit = 2;

@implementation GameScene{
    bool isGameRun;
    NSMutableArray * enemyArray;
    //    SKSpriteNode * player;
    NSMutableArray * floorArray;
    Player* player;
    bool isStandOnFootboard;
    NSMutableArray * footbardsByLines;
    
    bool isJumping;
    bool isFromLeft;
    float groundY;
    
    SKLabelNode *beatEnemyNumberLabel, *eatStarNumberLabel;
    SKLabelNode *gameOverLabel;
    int beatEnemyNumber;
    int eatStarNumber;
//    int currentJumpCount;
    
    NSArray * rightNsArray;
    NSArray * sheepMoveNsArray;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        isGameRun = YES;
        
        floorArray = [NSMutableArray array];
        
//        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

        SKSpriteNode* bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
        bg.size = self.frame.size;
        bg.anchorPoint = CGPointZero;
//        bg.xScale = -1;
        [self addChild:bg];
        
        gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        gameOverLabel.text = @"Game Over!";
        gameOverLabel.fontSize = 30;
        gameOverLabel.fontColor = [UIColor blackColor];
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                                         CGRectGetMaxY(self.frame) - 100);
        
        [self addChild:gameOverLabel];
        gameOverLabel.hidden = YES;
        
        SKLabelNode * beatEnemyNumberTitleLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        beatEnemyNumberTitleLabel.text = @"Beat Enemy Number:";
        beatEnemyNumberTitleLabel.fontSize = 15;
        beatEnemyNumberTitleLabel.fontColor = [UIColor blackColor];
        beatEnemyNumberTitleLabel.position = CGPointMake(CGRectGetMinX(self.frame) + 100,
                                                    CGRectGetMaxY(self.frame) - 40);
        
        [self addChild:beatEnemyNumberTitleLabel];
        
        beatEnemyNumberLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        beatEnemyNumberLabel.text = @"000";
        beatEnemyNumberLabel.fontSize = 15;
        beatEnemyNumberLabel.fontColor = [UIColor blackColor];
        beatEnemyNumberLabel.position = CGPointMake(beatEnemyNumberTitleLabel.position.x + beatEnemyNumberTitleLabel.frame.size.width/2 + 20,
                                       beatEnemyNumberTitleLabel.position.y);
        
        [self addChild:beatEnemyNumberLabel];
        
        SKLabelNode * eatStarNumberTitleLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        eatStarNumberTitleLabel.text = @"Eat Star Number:";
        eatStarNumberTitleLabel.fontSize = 15;
        eatStarNumberTitleLabel.fontColor = [UIColor blackColor];
        eatStarNumberTitleLabel.position = CGPointMake(CGRectGetMinX(self.frame) + 100,
                                                         CGRectGetMaxY(self.frame) - 70);
        
        [self addChild:eatStarNumberTitleLabel];
        
        eatStarNumberLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        eatStarNumberLabel.text = @"000";
        eatStarNumberLabel.fontSize = 15;
        eatStarNumberLabel.fontColor = [UIColor blackColor];
        eatStarNumberLabel.position = CGPointMake(eatStarNumberTitleLabel.position.x + eatStarNumberTitleLabel.frame.size.width/2 + 20,
                                                  eatStarNumberTitleLabel.position.y);
        
        [self addChild:eatStarNumberLabel];
        
        player = [Player spriteNodeWithImageNamed:@"yellow_point"];
        
        player.size = CGSizeMake(50, 50);
//        player.anchorPoint = CGPointMake(0.5f, 0);
        player.position = CGPointMake(self.frame.size.width/3*2, groundY);
        [player setGroundY:groundY];//        player.stop
        
        [self addChild:player];
        
        junpMaxLimit = 2;
    }
    return self;
}

-(void)showScore{
    
}

-(void)createEnemy{
    SKSpriteNode * enemy = [SKSpriteNode spriteNodeWithImageNamed:@""];
    enemy.size = CGSizeMake(50, 50);
    enemy.position = CGPointMake(0, 0);
    
    SKAction * moveAction = [SKAction moveToX:self.frame.size.width duration:5];
    [enemy runAction:moveAction];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
    }
    [player jump];
}

-(void)initFloorPool{
    
}

-(void)createFloor{
    bool isNeedCreate = true;
    MoveableFloor* floor = [floorArray lastObject];
  
    if(!floor || [floor isNeedCreateNewInstance]){
        int range = arc4random_uniform(100)+50;
        int r = arc4random_uniform(20);
        MoveableFloor* newFloor;
        if(r < 1){
            newFloor = [Star floorWithImageNamed:@"red_point" withRangeWidth:self.frame.size.width withDistance:range];
                        ((Star*)newFloor).type = 1;
            
//            newFloor = [MoveableFloor floorWithImageNamed:@"red_point" withRangeWidth:self.frame.size.width withDistance:range];

            [newFloor setSpeedX:FOOTBOARD_SPEED];
        }else if(r < 3){
            newFloor = [MoveableFloor floorWithImageNamed:@"red_point" withRangeWidth:self.frame.size.width withDistance:range];
//            ((Star*)newFloor).type = 0;
            [newFloor setSpeedX:FOOTBOARD_SPEED];
            [self createCat:newFloor];
        }else if(r < 13){
            newFloor = [MoveableFloor floorWithImageNamed:@"red_point" withRangeWidth:self.frame.size.width withDistance:range];
            [newFloor setSpeedX:FOOTBOARD_SPEED];
            [self createHamster:newFloor];
        }else if(r < 18){
            newFloor = [MoveableFloor floorWithImageNamed:@"red_point" withRangeWidth:self.frame.size.width withDistance:range];
            [newFloor setSpeedX:FOOTBOARD_SPEED_Faster];
            [self createSheep:newFloor];
        }else{
            newFloor = [MoveableFloor floorWithImageNamed:@"red_point" withRangeWidth:self.frame.size.width withDistance:range];
            [newFloor setSpeedX:FOOTBOARD_Fastest];
            [self createFireball:newFloor];
        }
        
        newFloor.position = CGPointMake(0, 50);
        
        [self addChild:newFloor];
        [floorArray addObject:newFloor];
    }
}

-(void)removeFloor{
    MoveableFloor* floor = [floorArray firstObject];
    
    if([floor isNeedRemoveInstance]){
        [floor removeFromParent];
        [floorArray removeObject:floor];
    }
}

-(void)moveFloor{
    for(int i = 0; i < floorArray.count; i++){
        MoveableFloor* floor = floorArray[i];
        [floor move];
    }
}

-(void)checkPlayerIsOnFloor{
    isStandOnFootboard = false;
    MoveableFloor* standedFootboard = nil;
    
    for (NSMutableArray * footbardsLine in footbardsByLines) {
        for (MoveableFloor * footboard in footbardsLine) {
            CGRect p = player.calculateAccumulatedFrame;
            CGRect f = footboard.calculateAccumulatedFrame;

            float SMOOTH_DEVIATION = 1;
            float footboardWidth = footboard.frame.size.width;
            bool b1 = footboard.position.x < player.position.x + player.size.width - SMOOTH_DEVIATION*4;
            bool b2 = footboard.position.x + footboardWidth > player.position.x + SMOOTH_DEVIATION*4;
            bool b3 = footboard.position.y <= player.position.y +1;
            bool b4 = footboard.position.y > player.position.y
            - DOWNSPEED - FOOTBOARD_SPEED;
            if(b1
               && b2
               &&
               (
                b3 &&
                b4)){
                   
                   isStandOnFootboard = true;
                   standedFootboard = footboard;
                   break;
               }
        }
    }
    
    //    [self moveFootboard];
    
    if(isStandOnFootboard){
        //            [self checkPlayerMoved];
        player.position = CGPointMake(player.position.x, standedFootboard.position.y);
    }else{
        player.position = CGPointMake(player.position.x, player.position.y-DOWNSPEED);
    }
}

-(void)checkPlayerDown{
    if(player.position.y < groundY){
        player.position = CGPointMake(100, groundY);
        [self resetJumpCOunt];
    }
    
}

-(void)resetJumpCOunt{
    [player resetJumpCount];
}

-(void)checkHitEnemy{

}

-(void)createFootboard{
    NSMutableArray * footbardsLine;
    footbardsLine = [NSMutableArray array];
    NSMutableArray * tmpfootbardsLine;
    tmpfootbardsLine = [NSMutableArray array];
    NSMutableArray * tmpfootbardsLineIndex;
    tmpfootbardsLineIndex = [NSMutableArray array];
    
    for(int i = 0; i < 6; i++){
        [self createFloor];
    }
    
    for(int i = 0; i < tmpfootbardsLine.count; i++){
        NSInteger index = ((NSInteger)[tmpfootbardsLineIndex indexOfObject:[NSNumber numberWithInt:i]]);
        [footbardsLine addObject:tmpfootbardsLine[index]];
    }
    
    [footbardsByLines addObject:footbardsLine];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if(!isGameRun){
        [self setViewRun:false];
        return;
    }
    
    /* Called before each frame is rendered */
    // 获取时间增量
    // 如果我们运行的每秒帧数低于60，我们依然希望一切和每秒60帧移动的位移相同
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // 如果上次更新后得时间增量大于1秒
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    self.lastSpawnTimeInterval += timeSinceLast;
    self.lastSpawnMoveTimeInterval += timeSinceLast;
    self.lastSpawnCreateFootboardTimeInterval += timeSinceLast;
    
    if (self.lastSpawnMoveTimeInterval > 0.1) {
        self.lastSpawnMoveTimeInterval = 0;
        
        [self removeFloor];
        [self createFloor];
        [self moveFloor];
        
        [self checkPlayerHitEnemy];
        
        [self checkPlayerDown];
    }
    
    if(self.lastSpawnCreateFootboardTimeInterval > 3.0){
        self.lastSpawnCreateFootboardTimeInterval = 0;
    }
}

-(void)setViewRun:(bool)isrun{
    isGameRun = isrun;
    
    for (int i = 0; i < [self children].count; i++) {
        SKNode * n = [self children][i];
        n.paused = !isrun;
    }
}


-(void)checkPlayerHitEnemy{
    for (int i = 0; i < floorArray.count; i++) {
        MoveableFloor * enemy = floorArray[i];
        
        if(CGRectIntersectsRect(player.calculateAccumulatedFrame, enemy.calculateAccumulatedFrame)){
            if(isStandOnFootboard){
                //gameover
                [self gameover];
            }else{
                [self resetJumpCOunt];
                [player jump];
                [enemy removeFromParent];
                if([enemy isDieType])
                    [self gameover];
                else if([enemy isKindOfClass:Star.class])
                    [self changeEatStarNumber];
                else
                    [self changeBeatEnemyNumber];
                [floorArray removeObject:enemy];
                
            }
        }
    }
}

-(void)changeBeatEnemyNumber{
    beatEnemyNumber++;
    beatEnemyNumberLabel.text = [NSString stringWithFormat:@"%d", beatEnemyNumber];
}

-(void)changeEatStarNumber{
    eatStarNumber++;
    eatStarNumberLabel.text = [NSString stringWithFormat:@"%d", eatStarNumber];
}

-(void)resetBeatEnemyNumber{
    beatEnemyNumber=0;
    beatEnemyNumberLabel.text = [NSString stringWithFormat:@"%d", beatEnemyNumber];
}

-(void)resetEatStarNumber{
    eatStarNumber=0;
    eatStarNumberLabel.text = [NSString stringWithFormat:@"%d", eatStarNumber];
}

-(void)gameover{
    isGameRun = false;
    gameOverLabel.hidden = NO;
}

-(void)restart{
    [self resetBeatEnemyNumber];
    [self resetEatStarNumber];
    [floorArray removeAllObjects];
    
    isGameRun = true;
    [self setViewRun:true];
}

-(void)createHamster:(MoveableFloor*)floor{
    rightNsArray = [TextureHelper getTexturesWithSpriteSheetNamed:@"hamster" withinNode:nil sourceRect:CGRectMake(0, 0, 192, 200) andRowNumberOfSprites:2 andColNumberOfSprites:7
                    //            sequence:[NSArray arrayWithObjects:@"10",@"11",@"12",@"11",@"10", nil]];
                                                         sequence:@[@5,@6]];
    
    floor.xScale = -1;
//    if(!isMoving){
//        isMoving = true;
        SKAction* move = [SKAction animateWithTextures:rightNsArray timePerFrame:0.2];
        [floor runAction:[SKAction repeatActionForever:move]];
}

-(void)createSheep:(MoveableFloor*)floor{
    sheepMoveNsArray = @[[SKTexture textureWithImageNamed:@"sheep_mimi01"],
                         [SKTexture textureWithImageNamed:@"sheep_mimi02"],
                         [SKTexture textureWithImageNamed:@"sheep_mimi03"]];
    SKAction* move = [SKAction animateWithTextures:sheepMoveNsArray timePerFrame:0.2];
    [floor runAction:[SKAction repeatActionForever:move]];
    floor.xScale = -1;
}

-(void)createCat:(MoveableFloor*)floor{
    int r = arc4random_uniform(5);
    switch (r) {
        case 0:
            floor.texture = [SKTexture textureWithImageNamed:@"cat01_1"];
            break;
        case 1:
            floor.texture = [SKTexture textureWithImageNamed:@"cat02_1"];
            break;
        case 2:
            floor.texture = [SKTexture textureWithImageNamed:@"cat03_1"];
            break;
        case 3:
floor.texture = [SKTexture textureWithImageNamed:@"cat04_1"];
            break;
        case 4:
                  floor.texture = [SKTexture textureWithImageNamed:@"cat05_1"];
            break;
    }
    
}

-(void)createFireball:(MoveableFloor*)floor{
    floor.texture = [SKTexture textureWithImageNamed:@"fireball"];
    floor.zRotation = -80;
    [floor setType:DIE];
}

@end
