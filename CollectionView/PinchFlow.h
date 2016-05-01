//
//  PinchFlow.h
//  CollectionView
//
//  Created by Justin Madewell on 12/25/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinchFlow : UICollectionViewFlowLayout

@property (strong, nonatomic) NSIndexPath *currentCellPath;
@property (nonatomic) CGPoint currentCellCenter;
@property (nonatomic) CGFloat currentCellScale;



@end
