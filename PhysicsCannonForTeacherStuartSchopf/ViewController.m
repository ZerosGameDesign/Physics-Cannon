//
//  ViewController.m
//  PhysicsCannonForTeacherStuartSchopf
//
//  Created by Jacob Davis on 10/31/13.
//  Copyright (c) 2013 Jacob Davis. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "SMRotaryWheel.h"

@implementation ViewController


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        MyScene * scene = [MyScene sceneWithSize:CGSizeMake(768, 2000)];//skView.bounds.size
        scene.scaleMode = SKSceneScaleModeAspectFill;
        scene.currentAngleToShoot = 20;
        self.angleOfCannon = 20;
        scene.thrust = 300;
        [self setAngleOfCannon];
        
        SMRotaryWheel *wheel;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            wheel = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)
                                              andDelegate:self
                                             withSections:8];
            wheel.center = CGPointMake(100, 100);

        }else {
            wheel = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)
                                             andDelegate:self
                                            withSections:8];
            wheel.center = CGPointMake(60, 100);

        }
        
        
        [self.view addSubview:wheel];

        
        
        self.viewOfGame = scene;

        // Present the scene.
       [skView presentScene:scene];
    }

}

- (void) wheelDidChangeValue:(NSString *)newValue {
    
    self.angleOfCannon = newValue.floatValue;
    self.viewOfGame.currentAngleToShoot = self.angleOfCannon;
    [self setAngleOfCannon];
    
}

-(void)thrustChanged:(UISlider *)sender {
    self.viewOfGame.thrust = sender.value;
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

    
    
}

-(IBAction)angleDegreesChanged:(UITextField *)sender {
    self.angleOfCannon = [sender.text intValue];
    self.viewOfGame.currentAngleToShoot = self.angleOfCannon;
    [self setAngleOfCannon];
    
}


-(void)setAngleOfCannon {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.cannonBar.transform = CGAffineTransformMakeRotation((-self.angleOfCannon -90) *M_PI/180);
        NSLog(@"The angle is:%d\n",self.angleOfCannon);
        NSLog(@"The cannon angle rotation: %f",(self.angleOfCannon) *M_PI/180);
        
    }completion:^(BOOL finished) {
        
    }];
}

-(IBAction)moveLeft {
    if (self.viewOfGame.scene.anchorPoint.x < self.viewOfGame.scene.view.frame.size.width - 10) {
        [UIView animateWithDuration:0.1 animations:^{
            [self.viewOfGame.scene setAnchorPoint:CGPointMake(self.viewOfGame.scene.anchorPoint.x, self.viewOfGame.scene.anchorPoint.y + 1)];
        } completion:^(BOOL finished) {
            NSLog(@"%f,%f",self.viewOfGame.scene.anchorPoint.x,self.viewOfGame.scene.anchorPoint.y);

        }];
    }
    
}

-(IBAction)moveRight {
    if (self.viewOfGame.scene.anchorPoint.y < self.viewOfGame.scene.view.frame.size.width - 10) {
        NSLog(@"%f,%f",self.viewOfGame.scene.anchorPoint.x,self.viewOfGame.scene.anchorPoint.y);
        [UIView animateWithDuration:1.0 animations:^{
            [self.viewOfGame.scene setAnchorPoint:CGPointMake(self.viewOfGame.scene.anchorPoint.x, self.viewOfGame.scene.anchorPoint.y - 1)];
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
