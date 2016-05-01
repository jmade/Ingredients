//
//  NewFoundInViewController.h
//  CollectionView
//
//  Created by Justin Madewell on 12/20/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFoundInViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *passedItems;
@property (nonatomic, strong) NSString *passedString;

@property (nonatomic, strong) NSMutableArray *foundInProducts;

@property (nonatomic, strong) UICollectionView *collectionView;


@end
