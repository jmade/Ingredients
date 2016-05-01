//
//  SKHeaderView.h
//  Skeleton
//
//  Created by Justin Madewell on 10/15/13.
//  Copyright (c) 2013 Backslash Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRMotionView.h"

@interface SKHeaderView : UICollectionReusableView

@property (nonatomic) IBOutlet UILabel *headerLabel;

@property (nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic) UIImage *backgroundImage;


@property (nonatomic,strong)  UIImageView *clearImageView;

@property (nonatomic, strong) UIImageView *blurredImageView;

@property (nonatomic, strong) CRMotionView *clearMotionView;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIButton *scienceNamebutton;

@end
