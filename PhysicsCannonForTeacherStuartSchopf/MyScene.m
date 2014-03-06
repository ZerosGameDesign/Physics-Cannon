//
//  MyScene.m
//  PhysicsCannonForTeacherStuartSchopf
//
//  Created by Jacob Davis on 10/31/13.
//  Copyright (c) 2013 Jacob Davis. All rights reserved.
//

#import "MyScene.h"
static const uint32_t cannonBall     =  0x1 << 0;

static const uint32_t grounda        =  0x1 << 1;

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.backgroundColor = [SKColor whiteColor];
        [self setSize:CGSizeMake(2000, self.scene.frame.size.height)];
        [self setAnchorPoint:CGPointZero];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
        
        
        [self createCannonBallAtPosition:CGPointMake(50, 50)];
        
        
        SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[UIColor purpleColor] size:CGSizeMake(2000, 10)];
        [ground setPosition:CGPointMake(1000, 250)];
        [ground setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:ground.size]];
        [ground.physicsBody setDynamic:NO];
        [ground.physicsBody setFriction:0.5];
        [ground.physicsBody setMass:10.0];
        [ground.physicsBody setResting:NO];
        [ground setName:@"ground"];
        [ground.physicsBody setCategoryBitMask:grounda];
        [ground.physicsBody setCollisionBitMask:cannonBall];
        [self addChild:ground];
        
        SKSpriteNode *spriteNodeBox = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(200, 50)];
        spriteNodeBox.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spriteNodeBox.size];
        [spriteNodeBox setPosition:CGPointMake(1000, 1000)];
        [spriteNodeBox.physicsBody setDynamic:NO];
        [self addChild:spriteNodeBox];
        
    
        self.allCannonsBalls = [NSMutableArray array];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        [self createCannonBallAtPosition:location];

        self.lastPositionTouched = location;

    }
    
    
}




- (void)didBeginContact:(SKPhysicsContact *)contact
{
    if (![contact.bodyA.node.name isEqualToString:@"CannonBall"] && [contact.bodyB.node.name isEqualToString:@"CannonBall"]) {
        if ([contact.bodyA.node.name isEqualToString:@"ground"] || [contact.bodyB.node.name isEqualToString:@"ground"]) {
            //Not another cannon and one body is the ground.
            if ([contact.bodyA.node.name isEqualToString:@"ground"]) {
                [self.allCannonsBalls removeObject:contact.bodyB];
                [contact.bodyB.node removeFromParent];
            }else {
                [self.allCannonsBalls removeObject:contact.bodyA];
                [contact.bodyA.node removeFromParent];
            }
            
        }
    }
    
  
}


-(void)createCannonBallAtPosition:(CGPoint)position {
    SKSpriteNode *newBall = [SKSpriteNode spriteNodeWithImageNamed:@"CannonBall.png"];
    [newBall setName:@"CannonBall"];
    [newBall setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:24.0]];
    [newBall.physicsBody setDynamic:YES];
    [newBall.physicsBody setAllowsRotation:YES];
    [newBall.physicsBody setAffectedByGravity:YES];
    [newBall.physicsBody setLinearDamping:0.2];
    [newBall.physicsBody setMass:10.0];
    [newBall setSize:CGSizeMake(48, 48)];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [newBall setPosition:CGPointMake(120, 300)];

    }else {
        [newBall setPosition:CGPointMake(170, 500)];

    }
    [newBall.physicsBody setResting:NO];
    [self addChild:newBall];
    [self.allCannonsBalls addObject:newBall];
    
    newBall.physicsBody.categoryBitMask = cannonBall;
    newBall.physicsBody.contactTestBitMask = grounda;
    
    point0 = CGPointMake(-1, -1);
    point1 = CGPointMake(-1, -1); // previous previous point
    point2 = CGPointMake(-1, -1); // previous touch point
    point3 = newBall.position; // current touch point
    
    //y2 - y1
    //x2 - x2
    
    
    
    float riseOfBall;
    float runOfBall;

    float currentAngle = self.currentAngleToShoot;
    
    float thrust = self.thrust;

    if (currentAngle == 90.0) {
        riseOfBall = 50.0;
        runOfBall = 0;
    }else {




        currentAngle += 90;
        float currentAngleInDeg = currentAngle * M_PI/180;
        float sinAngle = sinf(currentAngleInDeg);
        float cosAngle = cosf(currentAngleInDeg);
        runOfBall = 47 * sinAngle;
        riseOfBall = -47 * cosAngle;
        
    }
    
    
    
    
    
    
    
    CGVector thrustVector = CGVectorMake(thrust*runOfBall,
                                         thrust*riseOfBall);
    
    [newBall.physicsBody applyImpulse:thrustVector];

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    

    
}



//

- (BOOL) initContext:(CGSize)size {
	
	int bitmapByteCount;
	int	bitmapBytesPerRow;
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow = (size.width * 4);
	bitmapByteCount = (bitmapBytesPerRow * size.height);
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	cacheBitmap = malloc( bitmapByteCount );
	if (cacheBitmap == NULL){
		return NO;
	}
	cacheContext = CGBitmapContextCreate (cacheBitmap, size.width, size.height, 8, bitmapBytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
	return YES;
}



- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    
}

- (void) drawToCache {
    if(point1.x > -1){
        hue += 0.005;
        if(hue > 1.0) hue = 0.0;
        UIColor *color = [UIColor colorWithHue:hue saturation:0.7 brightness:1.0 alpha:1.0];
        
            UIGraphicsBeginImageContext(self.view.frame.size);
        
        CGContextSetStrokeColorWithColor(cacheContext, [color CGColor]);
        CGContextSetLineCap(cacheContext, kCGLineCapRound);
        CGContextSetLineWidth(cacheContext, 15);
        
        double x0 = (point0.x > -1) ? point0.x : point1.x; //after 4 touches we should have a back anchor point, if not, use the current anchor point
        double y0 = (point0.y > -1) ? point0.y : point1.y; //after 4 touches we should have a back anchor point, if not, use the current anchor point
        double x1 = point1.x;
        double y1 = point1.y;
        double x2 = point2.x;
        double y2 = point2.y;
        double x3 = point3.x;
        double y3 = point3.y;
        // Assume we need to calculate the control
        // points between (x1,y1) and (x2,y2).
        // Then x0,y0 - the previous vertex,
        //      x3,y3 - the next one.
        
        double xc1 = (x0 + x1) / 2.0;
        double yc1 = (y0 + y1) / 2.0;
        double xc2 = (x1 + x2) / 2.0;
        double yc2 = (y1 + y2) / 2.0;
        double xc3 = (x2 + x3) / 2.0;
        double yc3 = (y2 + y3) / 2.0;
        
        double len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
        double len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
        double len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
        
        double k1 = len1 / (len1 + len2);
        double k2 = len2 / (len2 + len3);
        
        double xm1 = xc1 + (xc2 - xc1) * k1;
        double ym1 = yc1 + (yc2 - yc1) * k1;
        
        double xm2 = xc2 + (xc3 - xc2) * k2;
        double ym2 = yc2 + (yc3 - yc2) * k2;
        double smooth_value = 0.8;
        // Resulting control points. Here smooth_value is mentioned
        // above coefficient K whose value should be in range [0...1].
        float ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
        float ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
        
        float ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
        float ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
        
        CGContextMoveToPoint(cacheContext, point1.x, point1.y);
        CGContextAddCurveToPoint(cacheContext, ctrl1_x, ctrl1_y, ctrl2_x, ctrl2_y, point2.x, point2.y);
        CGContextStrokePath(cacheContext);
                UIGraphicsEndImageContext();
        CGRect dirtyPoint1 = CGRectMake(point1.x-10, point1.y-10, 20, 20);
        CGRect dirtyPoint2 = CGRectMake(point2.x-10, point2.y-10, 20, 20);
        [self.view setNeedsDisplayInRect:CGRectUnion(dirtyPoint1, dirtyPoint2)];
        
    }
}

- (void) drawRect:(CGRect)rect {
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef cacheImage = CGBitmapContextCreateImage(cacheContext);
    CGContextDrawImage(context, self.view.bounds, cacheImage);
    CGImageRelease(cacheImage);
            UIGraphicsEndImageContext();
}





@end
