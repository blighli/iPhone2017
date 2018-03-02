//
//  GameScene.m
//  SKGame
//
//  Created by 王奇 on 24/12/2017.
//  Copyright © 2017 kkk. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKSpriteNode *floor, *floor2, *bird;
    GameStatus gamestatus;
    UInt32 birdCategory, pipeCategory, floorCategory,meters;
    SKLabelNode *gameOverLabel, *metersLabel;
}

- (void)didMoveToView:(SKView *)view {
    // Initialize BitMask
    birdCategory = 0x1 << 0;
    pipeCategory = 0x1 << 1;
    floorCategory = 0x1 << 2;
    
    // Initialize "Game Over" label
    gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    gameOverLabel.text = @"Game Over";
    
    // Initialize meters label
    metersLabel = [SKLabelNode labelNodeWithText:@"score:0"];
    metersLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    metersLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    metersLabel.position = CGPointMake(self.size.width*0.5, self.size.height);
    metersLabel.zPosition = 100;
    [self addChild:metersLabel];
    
    // Setup your scene here
    self.backgroundColor = [SKColor colorWithRed:80.0/255.0 green:192.0/255.0 blue:203.0/255.0 alpha:1.0];
    
    // Set Floor
    floor = [SKSpriteNode spriteNodeWithImageNamed:@"floor"];
    floor.anchorPoint = CGPointMake(0, 0);
    floor.position = CGPointMake(0, 0);
    [self addChild:floor];
    
    floor2 = [SKSpriteNode spriteNodeWithImageNamed:@"floor"];
    floor2.anchorPoint = CGPointMake(0, 0);
    floor2.position = CGPointMake(floor.size.width, 0);
    [self addChild:floor2];
    
    // Set Player
    bird = [SKSpriteNode spriteNodeWithImageNamed:@"p1"];
    [self addChild:bird];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.contactDelegate = self;
    
    // Set PhysicsBody
    [self setFloorPhysicsBody];
    [self setBirdPhysicsBody];
    
    // Set Meters Label
    [self shuffle];
}

// init the game
-(void)shuffle {
    gamestatus = IDLE;
    bird.position = CGPointMake(self.size.width*0.5, self.size.height*0.5);
    [self birdStartFly];
    [self removeAllPipeNode];
    bird.physicsBody.dynamic = NO;
    [gameOverLabel removeFromParent];
    meters = 0;
}

-(void)startGame {
    gamestatus = RUNNING;
    [self startCreateRandomPipesAction];
    bird.physicsBody.dynamic = YES;
}

-(void)gameOver {
    gamestatus = OVER;
    [self birdStopFly];
    [self stopCreateRandomPipesAction];
    // unable user click when "game over" label fade in
    [self setUserInteractionEnabled:NO];
    [self addChild:gameOverLabel];
    gameOverLabel.position = CGPointMake(self.size.width*0.5, self.size.height);
    [gameOverLabel runAction:[SKAction moveBy:CGVectorMake(0, -self.size.height*0.5)
                                     duration:0.5]
                  completion:^{
                      [self setUserInteractionEnabled:YES];
                  }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    switch (gamestatus) {
        case IDLE:
            [self startGame];
            break;
        case RUNNING:
            [bird.physicsBody applyImpulse:CGVectorMake(0, 20)];
            break;
        case OVER:
            [self shuffle];
            break;
    }
}

// control the scene moving
-(void)moveScene {
    // make floor moving
    floor.position = CGPointMake(floor.position.x-1, floor.position.y);
    floor2.position = CGPointMake(floor2.position.x-1, floor2.position.y);
    
    // check floor position
    if (floor.position.x < -floor.size.width) {
        floor.position = CGPointMake(floor2.position.x + floor2.size.width, floor.position.y);
    }
    
    if (floor2.position.x < -floor2.size.width) {
        floor2.position = CGPointMake(floor.position.x + floor.size.width, floor2.position.y);
    }

    // make pipe moving
    if (gamestatus == RUNNING) {
        for (SKNode *pipe in self.children) {
            if ([pipe.name isEqual:@"pipe"]) {
                SKSpriteNode *SKpipe = (SKSpriteNode*)pipe;
                SKpipe.position = CGPointMake(SKpipe.position.x-1.0, SKpipe.position.y);
                if (SKpipe.position.x < -SKpipe.size.width*0.5) {
                    [SKpipe removeFromParent];
                }
            }
        }
    }
    
}

-(void)birdStartFly {
    SKAction *flyAction = [SKAction animateWithTextures:@[
                                                          [SKTexture textureWithImageNamed:@"p1"],
                                                          [SKTexture textureWithImageNamed:@"p2"],
                                                          [SKTexture textureWithImageNamed:@"p3"],
                                                          [SKTexture textureWithImageNamed:@"p2"]] timePerFrame:0.15];
    [bird runAction:[SKAction repeatActionForever:flyAction] withKey:@"fly"];
}

-(void)birdStopFly {
    [bird removeActionForKey:@"fly"];
}

-(void)startCreateRandomPipesAction {
    // create a waiting action, the average waiting time is arg1, the changing range is arg2
    SKAction *waitAct = [SKAction waitForDuration:4.0 withRange:1.0];
    // create a making pipe action, using the "createRandomPipes" code Block
    SKAction *generatePipeAct = [SKAction runBlock:^{[self createRandomPipes];}];
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[waitAct, generatePipeAct]]] withKey:@"createPipe"];
    
}

-(void)stopCreateRandomPipesAction {
    [self removeActionForKey:@"createPipe"];
}

-(void)createRandomPipes {
    // available height
    CGFloat height = self.size.height - floor.size.height;
    CGFloat pipeGap = (CGFloat)arc4random_uniform((UInt32)bird.size.height) + bird.size.height*2;
    CGFloat pipeWidth = (CGFloat)60.0;
    
    CGFloat topPipeHeight = (CGFloat)arc4random_uniform((UInt32)(height - pipeGap));
    CGFloat bottomPipeHeight = height - pipeGap - topPipeHeight;
    
    [self addPipesWithTopSIze:CGSizeMake(pipeWidth, topPipeHeight) AndBottomSize:CGSizeMake(pipeWidth, bottomPipeHeight)];
    
}

-(void)addPipesWithTopSIze:(CGSize)topSize AndBottomSize:(CGSize)bottomSize {
    // create top pipe
    SKTexture *topTexture = [SKTexture textureWithImageNamed:@"toppipe"];
    SKSpriteNode *topPipe = [SKSpriteNode spriteNodeWithTexture:topTexture size:topSize];
    topPipe.name = @"pipe";
    topPipe.position = CGPointMake(self.size.width + topPipe.size.width*0.5, self.size.height - topPipe.size.height*0.5);
    
    // create bottom pipe
    SKTexture *bottomTexture = [SKTexture textureWithImageNamed:@"bottompipe"];
    SKSpriteNode *bottomPipe = [SKSpriteNode spriteNodeWithTexture:bottomTexture size:bottomSize];
    bottomPipe.name = @"pipe";
    bottomPipe.position = CGPointMake(self.size.width + bottomPipe.size.width*0.5, floor.size.height + bottomPipe.size.height*0.5);
    
    // set pipe physics
    topPipe.physicsBody = [SKPhysicsBody bodyWithTexture:topTexture size:topSize];
    topPipe.physicsBody.dynamic = NO;
    topPipe.physicsBody.categoryBitMask = pipeCategory;
    
    bottomPipe.physicsBody = [SKPhysicsBody bodyWithTexture:bottomTexture size:bottomSize];
    bottomPipe.physicsBody.dynamic = NO;
    bottomPipe.physicsBody.categoryBitMask = pipeCategory;
    
    [self addChild:topPipe];
    [self addChild:bottomPipe];
}

-(void)removeAllPipeNode {
    for (SKNode *pipe in self.children) {
        if ([pipe.name isEqual:@"pipe"]) {
            [pipe removeFromParent];
        }
    }
}

-(void)setFloorPhysicsBody{
    floor.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, floor.size.width, floor.size.height)];
    floor.physicsBody.categoryBitMask = floorCategory;
    
    floor2.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, floor2.size.width, floor2.size.height)];
    floor2.physicsBody.categoryBitMask = floorCategory;
}
-(void)setBirdPhysicsBody{
    bird.physicsBody = [SKPhysicsBody bodyWithTexture:bird.texture size:bird.size];
    bird.physicsBody.allowsRotation = NO;
    bird.physicsBody.categoryBitMask = birdCategory;
    bird.physicsBody.contactTestBitMask = floorCategory | pipeCategory;
    
}

-(void) didBeginContact:(SKPhysicsContact *)contact{
    if (gamestatus != RUNNING) {
        return;
    }
    SKPhysicsBody *bodyA;
    SKPhysicsBody *bodyB;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        bodyA = contact.bodyA;
        bodyB = contact.bodyB;
    } else {
        bodyB = contact.bodyA;
        bodyA = contact.bodyB;
    }
    if ((bodyA.categoryBitMask == birdCategory && bodyB.categoryBitMask == floorCategory) ||
        (bodyA.categoryBitMask == birdCategory && bodyB.categoryBitMask == pipeCategory)) {
        [self gameOver];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    if (gamestatus != OVER) {
        [self moveScene];
    }
    if (gamestatus == RUNNING) {
        metersLabel.text = [NSString stringWithFormat:@"score:%d",meters++];
    }
}
@end
