//
//  SpringyFlowLayout.h
//  CollectionView
//
//  Created by Justin Madewell on 10/29/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpringyFlowLayout : UICollectionViewFlowLayout

// Caches for keeping current/previous attributes
@property (nonatomic, strong) NSMutableArray *cellAttributes;
@property (nonatomic, strong) NSMutableArray *supplementaryAttributes;
@property (nonatomic, strong) NSMutableArray *footerAttributes;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *headerAttribs;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *footerAttribs;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *cellAttribs;

@end
