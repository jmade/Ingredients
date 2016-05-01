//
//  NProductViewViewController.m
//  CollectionView
//
//  Created by Justin Madewell on 1/29/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import "NProductViewViewController.h"
#import "NGAParallaxMotion.h"
#import "TestView.h"
#import "CircleView.h"
#import "SquareView.h"
#import "DynamicBackView.h"

#import "UIImage+ImageEffects.h"
#import "Random.h"
#import "Colours.h"
#import "UIImage+AverageColor.h"

// static for the Image Offset
static CGFloat backingImageViewYOffset = 10.0;

// Degrees to radians
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))




@interface NProductViewViewController ()

@property CADisplayLink *displayLink;

@property (nonatomic, strong) UIImageView *stemsView;
@property (nonatomic, strong) UIImageView *bigFlower;
@property (nonatomic, strong) UIImageView *littleFlower;
@property (nonatomic, strong) UILabel *flowerLabel;

@property (nonatomic, strong) UIImageView *hiveView;
@property (nonatomic, strong) UIImageView *beeLeftSmall;
@property (nonatomic, strong) UIImageView *beeLeftMed;
@property (nonatomic, strong) UIImageView *beeRightLarge;
@property (nonatomic, strong) UIImageView *honeyStick;
@property (nonatomic, strong) UILabel *beeLabel;




@end

@implementation NProductViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setUpMotion{
    
    self.tiltMotionEffectHorizontal = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    
    self.tiltMotionEffectHorizontal.minimumRelativeValue = [NSNumber numberWithFloat:-25.0];
    
    self.tiltMotionEffectHorizontal.maximumRelativeValue = [NSNumber numberWithFloat:25.0];
    
    self.tiltMotionEffectVertical = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    self.tiltMotionEffectVertical.minimumRelativeValue = [NSNumber numberWithFloat:-25.0];
    
    self.tiltMotionEffectVertical.maximumRelativeValue = [NSNumber numberWithFloat:25.0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _firstViewLabel.alpha = 0;
    [self setUpViews];
    [self loadImageViews];
    
    _dynamicBackView = [[DynamicBackView alloc]initWithFrame:CGRectMake(0, 20, 320, 500)];
   // [self.view addSubview:_dynamicBackView];
   
    
    
    NSLog(@"Output degrees as radians: %f", DEGREES_TO_RADIANS(45));
    NSLog(@"Output radians as degrees: %f", RADIANS_TO_DEGREES(0.785398));
    
	// Do any additional setup after loading the view.
    
    _window  = [[UIView alloc]initWithFrame:CGRectMake(0, 124, 320, 320)];
    _window.alpha = 1.0;
    UIImage *productImage = [[UIImage imageNamed:[self.productDict valueForKey:@"PLU"]] applyDarkEffect];
    UIImageView *productImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:[self.productDict valueForKey:@"PLU"]] applyDarkEffect]];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(135, 70, 50, 50)];
    _topView.backgroundColor = [UIColor tealColor];
    _topView.alpha = 0;
    
    [self.view addSubview:_topView];
                
    
    
    
    
    
    
    //Backing View
    
    
    _backingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    //_backingView.backgroundColor = [UIColor whiteColor];
    
    
    //UIImageView *baseImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:[self.productDict valueForKey:@"PLU"]] applyDarkEffect]];
    //baseImageView.alpha = 0.75f;
    
    //[_backingView addSubview:baseImageView];
    
    _backingImageView = [[UIImageView alloc]initWithFrame:CGRectInset(_backingView.frame, 10, 10)];
   
    _backingImageView.image = [[UIImage imageNamed:[self.productDict valueForKey:@"PLU"]]applyDarkEffect];
    _backingImageView.contentMode = UIViewContentModeScaleAspectFit;
    _backingImageView.layer.cornerRadius = 5.0;
   

    
    [_backingImageView addMotionEffect:_tiltMotionEffectHorizontal];
    [_backingImageView addMotionEffect:_tiltMotionEffectVertical];
    
    [_backingView addSubview:_backingImageView];
    
    [_window addSubview:_backingView];
    
    
   
    
    
    
    
    
   // [_window addSubview:productImageView];
    
    [self.view addSubview:_window];
    
    // Scroll View
    CGRect scrollViewRect = self.window.bounds;
    _myScrollView = [[UIScrollView alloc]initWithFrame:scrollViewRect];
    _myScrollView.pagingEnabled = YES;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.contentSize = CGSizeMake(scrollViewRect.size.width * 3.0f, scrollViewRect.size.height);
    _myScrollView.delegate = self;
    [_window addSubview:_myScrollView];
    
    // Views
    CGRect imageViewRect = self.window.bounds;
    
    // First View
    UIView *firstView = [[UIView alloc]initWithFrame:imageViewRect];
    firstView.backgroundColor = [UIColor clearColor];
    _firstViewLabel = [[UILabel alloc]initWithFrame:CGRectInset(firstView.frame, 20, 20)];
    _firstViewLabel.text = [self.productDict valueForKey:@"subTitle"];
    _firstViewLabel.numberOfLines = 3;
    _firstViewLabel.textAlignment = NSTextAlignmentCenter;
    _firstViewLabel.textColor = [UIColor whiteColor];
    _firstViewLabel.font = [UIFont fontWithName:@"OriginalKatie" size:40];
    _firstViewLabel.adjustsFontSizeToFitWidth = YES;
    _firstViewLabel.alpha = 0;
    _firstViewLabel.enabled = YES;
    //[firstView addSubview:_aView0];
    [firstView addSubview:_firstViewLabel];
    //[firstView addSubview:_aView1];
    
    [_myScrollView addSubview:firstView];
    
    // Second View
    imageViewRect.origin.x += imageViewRect.size.width;
    UIView *secondView = [[UIView alloc]initWithFrame:imageViewRect];
    secondView.backgroundColor = [UIColor tealColor];
    secondView.alpha = 1.0;
    _secondViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _secondViewLabel.text = [self.productDict valueForKey:@"subTitle"];
    _secondViewLabel.numberOfLines = 3;
    _secondViewLabel.textAlignment = NSTextAlignmentCenter;
    _secondViewLabel.textColor = [UIColor whiteColor];
    _secondViewLabel.font = [UIFont fontWithName:@"OriginalKatie" size:40];
    _secondViewLabel.adjustsFontSizeToFitWidth = YES;
    _secondViewLabel.alpha = 0;
    _secondViewLabel.enabled = YES;
    
  
    //[secondView addSubview:_aView2];
    [secondView addSubview:_flowerLabel];
    [secondView addSubview:_stemsView];
    [secondView addSubview:_littleFlower];
    [secondView addSubview:_bigFlower];
    [_myScrollView addSubview:secondView];
    
    
    
    // Third View
    imageViewRect.origin.x += imageViewRect.size.width;
    UIView *thirdView = [[UIView alloc]initWithFrame:imageViewRect];
    thirdView.backgroundColor = [UIColor burntSiennaColor];
    thirdView.alpha = 1.0;
    //[thirdView addSubview:_aView3];
    [thirdView addSubview:_honeyStick];
    [thirdView addSubview:_beeLabel];
    [thirdView addSubview:_beeLeftSmall];
    [thirdView addSubview:_beeLeftMed];
    [thirdView addSubview:_hiveView];
    
    [thirdView addSubview:_beeRightLarge];
    
    //_circleOne = [[CircleView alloc]initWithFrame:CGRectMake(55,55, 100, 100)];
    
    //cView.contentView.backgroundColor = [UIColor orangeColor];
   // [thirdView addSubview:_circleOne];
    
    [_myScrollView addSubview:thirdView];
    


    
    
    
    
    
    

    
    
}

-(void)setUpViews{
    
    NSMutableArray *mutableColorArray = [NSMutableArray arrayWithCapacity:1];
    for (NSInteger i = 0; i < 5; i++)
    {
        CGFloat redValue = (arc4random() % 255) / 255.0f;
        CGFloat blueValue = (arc4random() % 255) / 255.0f;
        CGFloat greenValue = (arc4random() % 255) / 255.0f;
        
        [mutableColorArray addObject:[UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0f]];
        
    }

    CGRect bottomLeftCorner = CGRectMake(0, 220, 100, 100);
    CGRect bottomRightCorner = CGRectMake(220, 220, 100, 100);
    CGRect topLeftCorner = CGRectMake(0, 0, 100, 100);
    CGRect topRightCorner = CGRectMake(220, 0, 100, 100);
    CGRect centerRect = CGRectMake(55,55, 100, 100);
    
    [[UIImage imageNamed:[self.productDict valueForKey:@"PLU"]] averageColor];
    
    CGFloat redValue = (arc4random() % 255) / 255.0f;
    CGFloat blueValue = (arc4random() % 255) / 255.0f;
    CGFloat greenValue = (arc4random() % 255) / 255.0f;
    
    NSArray * cArray = [[UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0f] colorSchemeOfType:ColorSchemeAnalagous];
    
    
    
    _aView0 = [[UIView alloc]initWithFrame:topRightCorner];
    _aView0.backgroundColor = [cArray objectAtIndex:0];
    _aView0.layer.cornerRadius = 50.0;
    _aView0.layer.masksToBounds = YES;
   
    _aView1 = [[UIView alloc]initWithFrame:bottomRightCorner];
    _aView1.backgroundColor = [cArray objectAtIndex:1];
    _aView1.layer.cornerRadius = 5.0;
    _aView1.layer.masksToBounds = YES;

    _aView2 = [[SquareView alloc]initWithFrame:CGRectMake(110, 110, 110, 110)];
    _aView2.backgroundColor = [cArray objectAtIndex:2];
    
    

    _aView3 = [[UIView alloc]initWithFrame:CGRectMake(-110, 110, 100, 100)];
    _aView3.backgroundColor = [cArray objectAtIndex:3];
    _aView3.layer.cornerRadius = 50.0;
    _aView3.layer.masksToBounds = YES;
    
    
    
   

    
}


-(void)loadImageViews

{
    // Coordinates
    
    int difY = -50;
    int upY = -50;
    
    CGRect workingRect = CGRectMake(162, 110, 116, 166);
    CGRect littleRect = CGRectMake(difY+215,124, 90, 90);
    CGRect bigRect = CGRectMake(difY+130,121, 100, 100);
    CGRect stemRect = CGRectMake(difY+162,300, 116, 166);
    
    CGRect topTextRect = CGRectMake(20, 20, 300, 80);
    CGRect bottomTextRect = CGRectMake(10, 250, 280, 80);
    CGRect honeyStickRect = CGRectMake(147, 147, 85, 33);
    
    
    
    CGRect beeLeftSmall = CGRectMake(42, upY+68, 46, 35);
    CGRect beeLeftMedium = CGRectMake(49, upY+153, 77, 59);
    CGRect beeRightLarge = CGRectMake(189, upY+103, 113, 87);
    
    // Views
    _stemsView = [[UIImageView alloc]initWithFrame:stemRect];
    _stemsView.image = [UIImage imageNamed:@"stems"];
    _stemsView.alpha = 1;

    _bigFlower = [[UIImageView alloc]initWithFrame:bigRect];
    _bigFlower.image = [UIImage imageNamed:@"BigFlower"];
    
    _littleFlower = [[UIImageView alloc]initWithFrame:littleRect];
    _littleFlower.image = [UIImage imageNamed:@"LittleFlower"];
    
    _flowerLabel = [[UILabel alloc]initWithFrame:topTextRect];
    _flowerLabel.text = @"The Jasmine Flower is traditionally used as a powerful aphrodisiac.";
    _flowerLabel.alpha = 0;
    _flowerLabel.numberOfLines = 4;
    _flowerLabel.textAlignment = NSTextAlignmentJustified;
    _flowerLabel.textColor = [UIColor whiteColor];
    _flowerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    _flowerLabel.adjustsFontSizeToFitWidth = YES;
    
    //Bees
    _hiveView = [[UIImageView alloc]initWithFrame:CGRectMake(100, upY+86, 120, 148)];
    _hiveView.image = [UIImage imageNamed:@"Hive"];
    
    _beeLeftSmall = [[UIImageView alloc]initWithFrame:beeLeftSmall];
    _beeLeftSmall.image = [UIImage imageNamed:@"BeeLeft"];
    
    _beeLeftMed = [[UIImageView alloc]initWithFrame:beeLeftMedium];
    _beeLeftMed.image = [UIImage imageNamed:@"BeeLeft"];
    
    _beeRightLarge = [[UIImageView alloc]initWithFrame:beeRightLarge];
    _beeRightLarge.image = [UIImage imageNamed:@"BeeRight"];
    
    _beeLabel = [[UILabel alloc]initWithFrame:bottomTextRect];
    _beeLabel.text = @"We use four different types of honey to help thoroughly clean and soothe the skin.";
    _beeLabel.alpha = 1.0f;
    _beeLabel.numberOfLines = 3;
    _beeLabel.textAlignment = NSTextAlignmentCenter;
    _beeLabel.textColor = [UIColor whiteColor];
    _beeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    _beeLabel.adjustsFontSizeToFitWidth = YES;
    
    _honeyStick = [[UIImageView alloc]initWithFrame:honeyStickRect];
    _honeyStick.image = [UIImage imageNamed:@"HoneyStick"];

                    
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    panGesture.delaysTouchesBegan = YES;
    panGesture.delaysTouchesEnded = YES;
    
    [self.view addGestureRecognizer:panGesture];
    
    [UIView animateWithDuration:0.20
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _firstViewLabel.alpha = 1.0;}
                     completion:^(BOOL finished){}
     ];
    
    
    
    //[self setUpAnimation];
    [self setUpNewAnimation];
    [self setUpMotion];
    
}

-(void)setUpNewAnimation
{
    // Set up the Animator
    self.animator = [[ParallaxScrollingFramework alloc]initWithScrollView:_myScrollView];
    
    [self.animator
     setKeyFrameWithOffset:0
     translate:CGPointMake(0, 0)
     scale:CGSizeMake(1, 1)
     rotate:0
     alpha:1
     forView:_firstViewLabel];
//    
//    [self.animator
//     setKeyFrameWithOffset:0
//     translate:CGPointMake(0, 0)
//     scale:CGSizeMake(1, 1)
//     rotate:0
//     alpha:0.75
//     forView:_stemsView];
//    
    
    [self.animator
     setKeyFrameWithOffset:160
     translate:CGPointMake(0, 0)
     scale:CGSizeMake(1, 1)
     rotate:0
     alpha:0.75
     forView:_stemsView];
    
    [self.animator
     setKeyFrameWithOffset:160
     translate:CGPointMake(0, -200)
     scale:CGSizeMake(0.1, 0.1)
     rotate:0
     alpha:0.5
     forView:_bigFlower];
    
    [self.animator
     setKeyFrameWithOffset:160
     translate:CGPointMake(0, -200)
     scale:CGSizeMake(0.1, 0.1)
     rotate:0
     alpha:0.5
     forView:_littleFlower];
    
    [self.animator
     setKeyFrameWithOffset:160
     translate:CGPointMake(0, -200)
     scale:CGSizeMake(1,1)
     rotate:DEGREES_TO_RADIANS(-45)
     alpha:0.05
     forView:_flowerLabel];

    
    // 320
    [self.animator
     setKeyFrameWithOffset:320
     translate:CGPointMake(-5, 0)
     scale:CGSizeMake(1,1)
     rotate:0
     alpha:0.75
     forView:_flowerLabel];
    
    [self.animator
     setKeyFrameWithOffset:320
     translate:CGPointMake(0,-150)
     scale:CGSizeMake(1, 1)
     rotate:0
     alpha:1
     forView:_stemsView];
    
    [self.animator
     setKeyFrameWithOffset:320
     translate:CGPointMake(0, 0)
     scale:CGSizeMake(1, 1)
     rotate:0
     alpha:1
     forView:_littleFlower];
    
    [self.animator
     setKeyFrameWithOffset:320
     translate:CGPointMake(0, 0)
     scale:CGSizeMake(1,1)
     rotate:0
     alpha:1
     forView:_bigFlower];
    

    
    //415
    [self.animator
     setKeyFrameWithOffset:415
     translate:CGPointMake(45, 0)
     scale:CGSizeMake(1,1)
     rotate:0
     alpha:1
     forView:_flowerLabel];
    
    [self.animator
     setKeyFrameWithOffset:415
     translate:CGPointMake(200, 200)
     scale:CGSizeMake(0.05,0.05)
     rotate:DEGREES_TO_RADIANS(-45)
     alpha:0
     forView:_honeyStick];
    

    
    [self.animator
     setKeyFrameWithOffset:415
     translate:CGPointMake(-30, 225)
     scale:CGSizeMake(1.3,1.3)
     rotate:0
     alpha:1
     forView:_beeLeftMed];
    
    [self.animator
     setKeyFrameWithOffset:415
     translate:CGPointMake(50, 20)
     scale:CGSizeMake(0.90,0.90)
     rotate:0
     alpha:1
     forView:_beeLeftSmall];
    
    [self.animator
     setKeyFrameWithOffset:415
     translate:CGPointMake(0, 0)
     scale:CGSizeMake(1,1)
     rotate:0
     alpha:1
     forView:_hiveView];
    
    [self.animator
     setKeyFrameWithOffset:415
     translate:CGPointMake(0, 200)
     scale:CGSizeMake(1,1)
     rotate:0
     alpha:0.05
     forView:_beeLabel];
    
//    [self.animator
//     setKeyFrameWithOffset:460
//     translate:CGPointMake(40, 0)
//     scale:CGSizeMake(1,1)
//     rotate:0
//     alpha:1
//     forView:_flowerLabel];
    
    // 505
    
    [self.animator
     setKeyFrameWithOffset:505
     translate:CGPointMake(0, 0)
     scale:CGSizeMake(1,1)
     rotate:DEGREES_TO_RADIANS(0)
     alpha:1
     forView:_beeRightLarge];
    
//    [self.animator
//     setKeyFrameWithOffset:505
//     translate:CGPointMake(0, -25)
//     scale:CGSizeMake(0.5,0.5)
//     rotate:0
//     alpha:1
//     forView:_hiveView];
    
//    [self.animator
//     setKeyFrameWithOffset:550
//     translate:CGPointMake(0, 0)
//     scale:CGSizeMake(1,1)
//     rotate:DEGREES_TO_RADIANS(-10)
//     alpha:1
//     forView:_beeLeftMed];
    
    //640
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(120, 0)
     scale:CGSizeMake(1,1)
     rotate:0
     alpha:0
     forView:_flowerLabel];
    
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(-150, -20)
     scale:CGSizeMake(1.4,1.4)
     rotate:DEGREES_TO_RADIANS(12)
     alpha:1
     forView:_beeRightLarge];
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(60, -25)
     scale:CGSizeMake(0.8,0.8)
     rotate:0
     alpha:1
     forView:_hiveView];

    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(0, 0)
     scale:CGSizeMake(1,1)
     rotate:DEGREES_TO_RADIANS(90)
     alpha:1
     forView:_littleFlower];
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(0, 0)
     scale:CGSizeMake(1,1)
     rotate:DEGREES_TO_RADIANS(180)
     alpha:1
     forView:_bigFlower];
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(190, 0)
     scale:CGSizeMake(0.80,0.80)
     rotate:0
     alpha:1
     forView:_beeLeftMed];
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(80, 0)
     scale:CGSizeMake(1,1)
     rotate:DEGREES_TO_RADIANS(-10)
     alpha:1
     forView:_beeLeftSmall];
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(-25, 25)
     scale:CGSizeMake(2,2)
     rotate:DEGREES_TO_RADIANS(0)
     alpha:1
     forView:_honeyStick];
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake (8, -30)
     scale:CGSizeMake(1,1)
     rotate:0
     alpha:1
     forView:_beeLabel];
    
//    [self.animator
//     setKeyFrameWithOffset:640
//     translate:CGPointMake(0, 0)
//     scale:CGSizeMake(1,1)
//     rotate:0
//     alpha:1
//     forView:_hiveView];
    
    //
    [self.animator
     setKeyFrameWithOffset:665
     translate:CGPointMake(220, 0)
     scale:CGSizeMake(0.80,0.80)
     rotate:DEGREES_TO_RADIANS(-4)
     alpha:1
     forView:_beeLeftMed];
    
    [self.animator
     setKeyFrameWithOffset:720
     translate:CGPointMake(240, -10)
     scale:CGSizeMake(0.80,0.80)
     rotate:DEGREES_TO_RADIANS(-4)
     alpha:1
     forView:_beeLeftMed];
    
    [self.animator
     setKeyFrameWithOffset:750
     translate:CGPointMake(280, -20)
     scale:CGSizeMake(1.2,1.2)
     rotate:DEGREES_TO_RADIANS(-4)
     alpha:1
     forView:_beeLeftMed];
    
    
    [self.animator
     setKeyFrameWithOffset:750
     translate:CGPointMake(150, -33)
     scale:CGSizeMake(1.12,1.12)
     rotate:DEGREES_TO_RADIANS(-8)
     alpha:1
     forView:_beeLeftSmall];
    
    [self.animator
     setKeyFrameWithOffset:750
     translate:CGPointMake(-140, 25)
     scale:CGSizeMake(3,2)
     rotate:DEGREES_TO_RADIANS(0)
     alpha:1
     forView:_honeyStick];
    

    
//    [self.animator
//     setKeyFrameWithOffset:720
//     translate:CGPointMake(300, 100)
//     scale:CGSizeMake(0.90,0.90)
//     rotate:0
//     alpha:0
//     forView:_beeLeftMed];
    
    [self.animator
     setKeyFrameWithOffset:750
     translate:CGPointMake(55, -20)
     scale:CGSizeMake(0.80,0.80)
     rotate:0
     alpha:1
     forView:_hiveView];
    
    [self.animator
     setKeyFrameWithOffset:750
     translate:CGPointMake(-200, -60)
     scale:CGSizeMake(1.3,1.3)
     rotate:DEGREES_TO_RADIANS(12)
     alpha:1
     forView:_beeRightLarge];
    
    [self.animator
     setKeyFrameWithOffset:750
     translate:CGPointMake(25, -20)
     scale:CGSizeMake(1,1)
     rotate:0
     alpha:1
     forView:_beeLabel];
    
//    [self.animator
//     setKeyFrameWithOffset:480
//     translate:CGPointMake(0, 0)
//     scale:CGSizeMake(1,1)
//     rotate:DEGREES_TO_RADIANS(360)
//     alpha:1
//     forView:_littleFlower];
//    
//    [self.animator
//     setKeyFrameWithOffset:480
//     translate:CGPointMake(0, 0)
//     scale:CGSizeMake(1,1)
//     rotate:DEGREES_TO_RADIANS(360)
//     alpha:1
//     forView:_bigFlower];


    
    
}

-(void)setUpAnimation{
    
    
    // Set up the Animator
    self.animator = [[ParallaxScrollingFramework alloc]initWithScrollView:_myScrollView];

    [self.animator
     setKeyFrameWithOffset:0   // Indicates where keyframe is in ScrollView
     translate:CGPointMake(-150, 50)       // Translation, relative to frame.origin
     scale:CGSizeMake(1, 1)      // Scaling using CGAffineTransform
     rotate:0                    // Rotation also using CGAffineTransform
     alpha:0
     forView:_topView];

    [self.animator
     setKeyFrameWithOffset:0   // Indicates where keyframe is in ScrollView
     translate:CGPointZero       // Translation, relative to frame.origin
     scale:CGSizeMake(1, 1)      // Scaling using CGAffineTransform
     rotate:0                    // Rotation also using CGAffineTransform
     alpha:1
     forView:_firstViewLabel];
    
    [self.animator
     setKeyFrameWithOffset:0   // Indicates where keyframe is in ScrollView
     translate:CGPointZero       // Translation, relative to frame.origin
     scale:CGSizeMake(1, 1)      // Scaling using CGAffineTransform
     rotate:0                    // Rotation also using CGAffineTransform
     alpha:1
     forView:_aView0];
    
    [self.animator
     setKeyFrameWithOffset:0   // Indicates where keyframe is in ScrollView
     translate:CGPointZero       // Translation, relative to frame.origin
     scale:CGSizeMake(1, 1)      // Scaling using CGAffineTransform
     rotate:0                    // Rotation also using CGAffineTransform
     alpha:1
     forView:_aView1];
    
    [self.animator
     setKeyFrameWithOffset:0   // Indicates where keyframe is in ScrollView
     translate:CGPointZero       // Translation, relative to frame.origin
     scale:CGSizeMake(1, 1)      // Scaling using CGAffineTransform
     rotate:0                    // Rotation also using CGAffineTransform
     alpha:1
     forView:_aView2];
    
    [self.animator
     setKeyFrameWithOffset:0   // Indicates where keyframe is in ScrollView
     translate:CGPointZero       // Translation, relative to frame.origin
     scale:CGSizeMake(1, 1)      // Scaling using CGAffineTransform
     rotate:0                    // Rotation also using CGAffineTransform
     alpha:1
     forView:_aView3];
    
    
    [self.animator
     setKeyFrameWithOffset:300
     translate:CGPointMake(-200, -50)
     scale:CGSizeMake(0.5, 0.5)
     rotate:0
     alpha:0
     forView:_firstViewLabel];
    
    [self.animator
     setKeyFrameWithOffset:320
     translate:CGPointMake(100, 220)
     scale:CGSizeMake(1, 1)
     rotate:DEGREES_TO_RADIANS(180)
     alpha:1
     forView:_aView0];
    
    [self.animator
     setKeyFrameWithOffset:320
     translate:CGPointMake(100, -220)
     scale:CGSizeMake(1, 1)
     rotate:DEGREES_TO_RADIANS(270)
     alpha:1
     forView:_aView1];
    
    [self.animator
     setKeyFrameWithOffset:320
     translate:CGPointMake(0, 0)
     scale:CGSizeMake(1, 1)
     rotate:DEGREES_TO_RADIANS(45)
     alpha:1
     forView:_topView];
    
    
    
    [self.animator
     setKeyFrameWithOffset:320
     translate:CGPointZero
     scale:CGSizeMake(2, 2)
     rotate:0
     alpha:1
     forView:_aView2];
    
    [self.animator
     setKeyFrameWithOffset:420
     translate:CGPointMake(100, 220)
     scale:CGSizeMake(1.5, 1.5)
     rotate:0
     alpha:1
     forView:_aView0];
    
    [self.animator
     setKeyFrameWithOffset:420
     translate:CGPointMake(100, -220)
     scale:CGSizeMake(1.5, 1.5)
     rotate:0
     alpha:1
     forView:_aView1];

    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(0, -25)
     scale:CGSizeMake(1.5, 1.5)
     rotate:0
     alpha:1
     forView:_topView];
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(110, 0)
     scale:CGSizeMake(1, 1)
     rotate:DEGREES_TO_RADIANS(180)
     alpha:1
     forView:_aView3];
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointMake(110, 0)
     scale:CGSizeMake(3, 3)
     rotate:0
     alpha:1
     forView:_aView2];
    
    [self.animator
     setKeyFrameWithOffset:640
     translate:CGPointZero
     scale:CGSizeMake(1, 1)
     rotate:0 // DEGREES_TO_RADIANS(180)
     alpha:1
     forView:_circleOne];
    
    [self.animator
     setKeyFrameWithOffset:700
     translate:CGPointMake(0, -25)
     scale:CGSizeMake(2, 2)
     rotate:DEGREES_TO_RADIANS(270)
     alpha:1
     forView:_topView];
    
    [self.animator
     setKeyFrameWithOffset:700
     translate:CGPointMake(-35,0)
     scale:CGSizeMake(1.5, 1.5)
     rotate:0 // DEGREES_TO_RADIANS(180)
     alpha:1
     forView:_circleOne];
    
    [self.animator
     setKeyFrameWithOffset:700
     translate:CGPointMake(300,0)
     scale:CGSizeMake(3, 3)
     rotate:0
     alpha:1
     forView:_aView2];
    
    [self.animator
     setKeyFrameWithOffset:700
     translate:CGPointMake(300, -200)
     scale:CGSizeMake(0.5, 0.5)
     rotate:DEGREES_TO_RADIANS(180)
     alpha:1
     forView:_aView3];
    
   
    
    
    
    
    
    
    
    // Template
    
//    [self.animator
//     setKeyFrameWithOffset:000
//     translate:CGPointMake(0, 0) // CGPointZero
//     scale:CGSizeMake(1, 1)
//     rotate:0 // DEGREES_TO_RADIANS(180)
//     alpha:1
//     forView:viewHere];

    
//    [self.animator
//     setKeyFrameWithOffset:600
//     translate:CGPointZero
//     scale:CGSizeMake(0.25, 0.25)
//     rotate:0
//     alpha:1
//     forView:_aView0];
//    
//    [self.animator
//     setKeyFrameWithOffset:600
//     translate:CGPointZero
//     scale:CGSizeMake(0.25, 0.25)
//     rotate:0
//     alpha:1
//     forView:_aView1];
    
    
//    
//   
//    
//    
//      [self.animator
//     setKeyFrameWithOffset:300
//     translate:CGPointZero
//     scale:CGSizeMake(1, 1)
//     rotate:0
//     alpha:1
//     forView:_secondViewLabel];
//    
//    [self.animator
//     setKeyFrameWithOffset:310
//     translate:CGPointMake(100, 75)
//     scale:CGSizeMake(1.5, 1.5)
//     rotate:0
//     alpha:0.75
//     forView:_secondViewLabel];
//    
//    [self.animator
//     setKeyFrameWithOffset:330
//     translate:CGPointMake(100, 150)
//     scale:CGSizeMake(1.75, 1.75)
//     rotate:DEGREES_TO_RADIANS(180)
//     alpha:0.50
//     forView:_secondViewLabel];
//    
//    
//    [self.animator
//     setKeyFrameWithOffset:350
//     translate:CGPointMake(100, 50)
//     scale:CGSizeMake(1, 1)
//     rotate:DEGREES_TO_RADIANS(360)
//     alpha:1
//     forView:_secondViewLabel];
//    
//    [self.animator
//     setKeyFrameWithOffset:375
//     translate:CGPointMake(0, -50)
//     scale:CGSizeMake(0.75, 0.75)
//     rotate:DEGREES_TO_RADIANS(180)
//     alpha:0.75
//     forView:_secondViewLabel];
//    
//    [self.animator
//     setKeyFrameWithOffset:400
//     translate:CGPointMake(-50, -100)
//     scale:CGSizeMake(0.25, 0.25)
//     rotate:DEGREES_TO_RADIANS(360)
//     alpha:0.0
//     forView:_secondViewLabel];
//
//    [self.animator
//     setKeyFrameWithOffset:275
//     translate:CGPointMake(100, 150)
//     scale:CGSizeMake(1.75, 1.75)
//     rotate:1
//     alpha:0
//     forView:_firstViewLabel];
//    
//    [self.animator
//     setKeyFrameWithOffset:276
//     translate:CGPointMake(20, 20)
//     scale:CGSizeMake(0.25, 0.25)
//     rotate:0.25
//     alpha:0.25
//     forView:_secondViewLabel];
//    
//    [self.animator
//     setKeyFrameWithOffset:300
//     translate:CGPointMake(85, 127.5)
//     scale:CGSizeMake(0.50, 0.50)
//     rotate:0.75
//     alpha:0.75
//     forView:_secondViewLabel];
//
    
}

-(void)handlePan:(UIPanGestureRecognizer *)pan{
  
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
   
}

-(void)viewWillDisappear:(BOOL)animated{
    
      [super viewDidDisappear:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView == _myScrollView)
    {
        int page = _myScrollView.contentOffset.x/_myScrollView.frame.size.width;
        NSLog(@"%d", page);
        
        CGFloat scrollOffset = scrollView.contentOffset.x;
        NSLog(@"%f", scrollOffset);
        CGRect backingImageViewFrame = _backingImageView.frame;
        
        if (scrollOffset < 0) {
            // Adjust image proportionally
            backingImageViewFrame.origin.x = backingImageViewYOffset + (scrollOffset); //- ((scrollOffset / 3));
        } else {
            // We're scrolling up, return to normal behavior
            backingImageViewFrame.origin.x = backingImageViewYOffset + (scrollOffset);
        }
        _backingImageView.frame = backingImageViewFrame;
        
    }
    
    return;

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView == _myScrollView){
        [self startDisplayLinkIfNeeded];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView == _myScrollView){
        if (!decelerate) {
            [self stopDisplayLink];
        }
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == _myScrollView){
        [self stopDisplayLink];
        
    }
}

#pragma mark Display Link

- (void)startDisplayLinkIfNeeded
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fixAnimation)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    }
}


- (void)stopDisplayLink
{
    [_displayLink invalidate];
    _displayLink = nil;
}

-(void)fixAnimation
{
    [_myScrollView reloadInputViews];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
