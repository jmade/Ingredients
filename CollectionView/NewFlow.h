//
//  NewFlow.h
//  CollectionView
//
//  Created by Justin Madewell on 12/24/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface NewFlow : UICollectionViewFlowLayout

@property (strong, nonatomic) NSIndexPath *currentCellPath;
@property (strong, nonatomic) NSIndexPath *snappedCellPath;
@property (nonatomic) CGPoint currentCellCenter;
@property (nonatomic) CGFloat currentCellScale;
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIAttachmentBehavior *attatchmentBehavior;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@property (nonatomic, strong) NSMutableArray *pointArray;
@property (nonatomic, strong) NSArray *headerItems;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *headerAttribs;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *snappedItem;

@property (strong, nonatomic) CMMotionManager *motionManager;


@property BOOL isSnapped;






@end
