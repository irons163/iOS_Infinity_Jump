//
//  MoveableFloor.m
//  Try_GoDownLayer
//
//  Created by irons on 2015/9/16.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "MoveableFloor.h"

static int CAR_DISTANCE = 100;

@implementation MoveableFloor{
    
//    int carX;
//    int carY;
    
    
}

+(instancetype)floorWithImageNamed:(NSString *)name withRangeWidth:(float)rangeWidth withDistance:(float)distance{
    MoveableFloor* floor = [MoveableFloor spriteNodeWithImageNamed:name];
    floor->isCarStartFromLeft = YES;
    floor->rangeWidth = rangeWidth;
    CAR_DISTANCE = distance;
    return floor;
}

-(BOOL)isNeedCreateNewInstance{
    bool isNeedCreateNewInstance = false;
    if(isCarStartFromLeft && self.position.x >= CAR_DISTANCE){
        isNeedCreateNewInstance = true;
    }else if(!isCarStartFromLeft && self.position.x <= rangeWidth - CAR_DISTANCE){
        isNeedCreateNewInstance = true;
    }
    return isNeedCreateNewInstance;
}

-(BOOL)isNeedRemoveInstance{
    bool isNeedRemoveInstance = false;
    if(isCarStartFromLeft && self.position.x >= rangeWidth){
        isNeedRemoveInstance = true;
    }else if(!isCarStartFromLeft && self.position.x <= 0){
        isNeedRemoveInstance = true;
    }
    return isNeedRemoveInstance;
}

-(void)move{
    self.position = CGPointMake(self.position.x + speedX, self.position.y);
}

-(void)setSpeedX:(int)speedX{
    self->speedX = speedX;
}

-(void)setType:(MyType)type{
    self->type = type;
}

-(MyType)getType{
    return self->type;
}

-(BOOL)isDieType{
    if(self->type == DIE)
        return true;
    return false;
}

@end
