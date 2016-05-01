//
//  NPDCollectionViewController.h
//  CollectionView
//
//  Created by Justin Madewell on 12/21/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface NPDCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *passedItems;
@property (nonatomic, strong) NSString *passedString;
@property (nonatomic, strong) NSString *tappedCell;

@property (nonatomic, strong) NSMutableArray *foundInProducts;

@property (nonatomic, strong) NSDictionary *productDict;
@property (nonatomic, strong) NSDictionary *rootDictionary;

@property (nonatomic, strong) UICollectionViewCell *snappedCell;

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (nonatomic, strong)  UIInterpolatingMotionEffect *tiltMotionEffectHorizontal;
@property (nonatomic, strong)  UIInterpolatingMotionEffect *tiltMotionEffectVertical;









@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UILabel *headerLabel;

@end
