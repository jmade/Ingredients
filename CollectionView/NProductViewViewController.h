//
//  NProductViewViewController.h
//  CollectionView
//
//  Created by Justin Madewell on 1/29/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParallaxScrollingFramework.h"
#import "CircleView.h"
#import "SquareView.h"
#import "DynamicBackView.h"

@interface NProductViewViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) NSDictionary *productDict;
@property (nonatomic, strong) UIImage *screenImage;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIView *window;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic, strong) UIImageView *backingImageView;
@property (nonatomic, strong) UIView *backingView;

// Animated Views
@property (nonatomic, strong) UIView *aView0;
@property (nonatomic, strong) UIView *aView1;
@property (nonatomic, strong) SquareView *aView2;
@property (nonatomic, strong) UIView *aView3;
@property (nonatomic, strong) UIView *aView4;

@property (nonatomic, strong) CircleView *circleOne;
@property (nonatomic, strong) SquareView *squareOne;
@property (nonatomic, strong) DynamicBackView *dynamicBackView;

@property (nonatomic, strong) UIView *topView;



@property (nonatomic,strong) UILabel *firstViewLabel;
@property (nonatomic,strong) UILabel *secondViewLabel;

@property (nonatomic, strong)  UIInterpolatingMotionEffect *tiltMotionEffectHorizontal;
@property (nonatomic, strong)  UIInterpolatingMotionEffect *tiltMotionEffectVertical;


@property (nonatomic, strong) ParallaxScrollingFramework *animator;




@end
