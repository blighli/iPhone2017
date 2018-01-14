//
//  GameScene.h
//  SKGame
//
//  Created by 王奇 on 24/12/2017.
//  Copyright © 2017 kkk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>

typedef NS_ENUM(NSInteger, GameStatus) {
    IDLE,
    RUNNING,
    OVER
};

@end
