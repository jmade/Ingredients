//
//  ItemViewController.h
//  CollectionView
//
//  Created by Justin Madewell on 1/26/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParallaxScrollingFramework.h"


@interface ItemViewController : UIViewController



@property (nonatomic, strong) NSDictionary *productDict;
@property (nonatomic, strong) UIImage *screenImage;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,strong) UILabel *firstViewLabel;

// Paralax Animation
@property (nonatomic, strong) ParallaxScrollingFramework *animator;







@end
