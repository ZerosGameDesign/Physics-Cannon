//
//  MyScene.h
//  PhysicsCannonForTeacherStuartSchopf
//

//  Copyright (c) 2013 Jacob Davis. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene {
    void *cacheBitmap;
    CGContextRef cacheContext;
    float hue;
    
    CGPoint point0;
    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
}

@property (strong, nonatomic) UIImageView *cannonBarImage;
@property (strong, nonatomic) SKSpriteNode *cannonBallSprite;
@property (strong, nonatomic) SKSpriteNode *redLandingSprite;

@property (assign, nonatomic) CGPoint lastPositionTouched;
@property (strong, nonatomic) NSMutableArray *allCannonsBalls;
@property (assign, nonatomic) int currentAngleToShoot;
@property (assign, nonatomic) int thrust;

@end
