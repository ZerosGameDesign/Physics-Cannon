//
//  ViewController.h
//  PhysicsCannonForTeacherStuartSchopf
//

//  Copyright (c) 2013 Jacob Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"
#import "SMRotaryProtocol.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *cannonBar;
@property (strong, nonatomic) IBOutlet UIImageView *cannonBall;
@property (strong, nonatomic) IBOutlet UIScrollView *cannonScrollView;
@property (strong, nonatomic) IBOutlet UIView *cannonShootingView;
@property (strong, nonatomic) MyScene *viewOfGame;
@property (assign, nonatomic) int angleOfCannon;

-(IBAction)angleDegreesChanged:(UITextField *)sender;
-(IBAction)thrustChanged:(UISlider *)sender;

-(IBAction)moveLeft;
-(IBAction)moveRight;



@end
