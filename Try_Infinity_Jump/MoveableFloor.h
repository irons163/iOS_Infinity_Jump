//
//  MoveableFloor.h
//  Try_GoDownLayer
//
//  Created by irons on 2015/9/16.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

enum Type{
    NONE, DIE
};

typedef enum Type MyType;

@interface MoveableFloor : SKSpriteNode{
    @protected int speedX;
    @protected bool isCarStartFromLeft;
    @protected float rangeWidth;
    @protected MyType type;
}

//+(instancetype)floorWithImageNamed:(NSString *)name withRangeWidth:(float)rangeWidth;
+(instancetype)floorWithImageNamed:(NSString *)name withRangeWidth:(float)rangeWidth withDistance:(float)distance;
-(BOOL)isNeedCreateNewInstance;
-(BOOL)isNeedRemoveInstance;
-(void)move;
-(void)setSpeedX:(int)speedX;
-(void)setType:(MyType)type;
-(MyType)getType;
-(BOOL)isDieType;
@end
