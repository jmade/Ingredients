//
//  FoundInFlowLayout.m
//  CollectionView
//
//  Created by Justin Madewell on 12/20/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "FoundInFlowLayout.h"

@implementation FoundInFlowLayout

-(void)setItemSize:(CGSize)itemSize {
    CGSizeMake(75, 75);
}

-(CGSize)collectionViewContentSize {
   return self.collectionViewContentSize;
}

@end
