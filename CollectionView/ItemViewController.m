//
//  ItemViewController.m
//  CollectionView
//
//  Created by Justin Madewell on 1/26/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import "ItemViewController.h"
#import "UIImage+ImageEffects.h"
#import "Random.h"
#import "ParallaxScrollingFramework.h"

@interface ItemViewController ()

@property UIView *window;


@end

@implementation ItemViewController



- (void)viewDidLoad

{
    [super viewDidLoad];
    _firstViewLabel.alpha = 1.0;
    
   }

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    animated = YES;
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _firstViewLabel.alpha = 1.0;}
                     completion:^(BOOL finished){}
     ];
    
    self.animator = [[ParallaxScrollingFramework alloc]initWithScrollView:_scrollView];
    
    [self.animator
     setKeyFrameWithOffset:100   // Indicates where keyframe is in ScrollView
     translate:CGPointZero       // Translation, relative to frame.origin
     scale:CGSizeMake(1, 1)      // Scaling using CGAffineTransform
     rotate:0                    // Rotation also using CGAffineTransform
     alpha:1
     forView:_firstViewLabel];
    
    [self.animator
     setKeyFrameWithOffset:300
     translate:CGPointMake(50, 100)
     scale:CGSizeMake(1.2, 1.2)
     rotate:0
     alpha:0.5
     forView:_firstViewLabel];



 
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [self.view setFrame:screenBounds];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    _window  = [[UIView alloc]initWithFrame:CGRectMake(0, 124, 320, 320)];
    _window.alpha = 1.0;
    
    //UIImageView *backingImageView = [[UIImageView alloc]initWithImage:_screenImage];
    
    //  [self.view addSubview:backingImageView];
    
	// Do any additional setup after loading the view.
    
    UIImage *productImage = [[UIImage imageNamed:[self.productDict valueForKey:@"PLU"]] applyLightEffect];
    UIImageView *productIV = [[UIImageView alloc]initWithImage:productImage];
    
    //
    //    productIV.layer.cornerRadius = 5.0;
    //    productIV.layer.masksToBounds = YES;
    
    [_window addSubview:productIV];
    [self.view addSubview:_window];
    
    
    
    // Scroll View
    
    CGRect scrollViewRect = self.window.bounds;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:scrollViewRect];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.contentSize = CGSizeMake(scrollViewRect.size.width * 3.0f, scrollViewRect.size.height);
    
    [_window addSubview:_scrollView];
    
    CGRect imageViewRect = self.window.bounds;
    
    UIView *firstView = [[UIView alloc]initWithFrame:imageViewRect];
    firstView.backgroundColor = [UIColor blueColor];
    
    
    
    _firstViewLabel = [[UILabel alloc]initWithFrame:CGRectInset(firstView.frame, 20, 20)];
    _firstViewLabel.text = [self.productDict valueForKey:@"subTitle"];
    _firstViewLabel.numberOfLines = 3;
    _firstViewLabel.textAlignment = NSTextAlignmentCenter;
    _firstViewLabel.textColor = [UIColor whiteColor];
    _firstViewLabel.font = [UIFont fontWithName:@"OriginalKatie" size:40];
    _firstViewLabel.adjustsFontSizeToFitWidth = YES;
    _firstViewLabel.alpha = 0;
    
    [firstView addSubview:_firstViewLabel];
    [_scrollView addSubview:firstView];
    
    imageViewRect.origin.x += imageViewRect.size.width;
    UIView *secondView = [[UIView alloc]initWithFrame:imageViewRect];
    secondView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:secondView];
    imageViewRect.origin.x += imageViewRect.size.width;
    UIView *thirdView = [[UIView alloc]initWithFrame:imageViewRect];
    thirdView.backgroundColor = [UIColor greenColor];
    [_scrollView addSubview:thirdView];
    
    
    
    
    
    
    
    
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    
    [self.view addGestureRecognizer:panGesture];
    
    
    
    
    //    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    //    dismissTap.numberOfTapsRequired = 2;
    //    dismissTap.delaysTouchesEnded = YES;
    //
    //    [_window addGestureRecognizer:dismissTap];
    
    
    
    

    
    
    
    
    
    
}
- (void)handlePan:(UIPanGestureRecognizer*)pan {
//    [self dismissViewControllerAnimated:YES completion:^{
//        [(UINavigationController *)self.presentingViewController popToRootViewControllerAnimated:YES];
//    }];
    
    [self dismissViewControllerAnimated:NO completion:nil];
  }


//- (void)dismiss:(UITapGestureRecognizer*)gesture {
//    
//   // [self.navigationController popViewControllerAnimated:YES];
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
