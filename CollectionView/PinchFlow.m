//
//  PinchFlow.m
//  CollectionView
//
//  Created by Justin Madewell on 12/25/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "PinchFlow.h"

@implementation PinchFlow

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(75, 75);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(160, 10, 10, 10);
   // self.headerReferenceSize = CGSizeMake(320, 160);
   // self.footerReferenceSize = CGSizeMake(320, 44);
}

-(void)setCurrentCellScale:(CGFloat)scale;
{
    _currentCellScale = scale;
    [self invalidateLayout];
    
}

-(void)setCurrentCellCenter:(CGPoint)origin
{
    _currentCellCenter = origin;
    [self invalidateLayout];
}

-(CGSize)collectionViewContentSize {
    //return CGSizeMake(320, 568);
    return self.collectionView.contentSize;
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Get the current attributes for the item at the indexPath
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    //Modify them to match the pinch values
    [self modifyForPinchLayoutAttibutes:attributes];
    return attributes;
}

-(void)modifyForPinchLayoutAttibutes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    //If the indexPath matches the one we have stored
    if ([layoutAttributes.indexPath isEqual:_currentCellPath])
    {
        //Assign new layout attributes
        layoutAttributes.transform3D = CATransform3DMakeScale(_currentCellScale, _currentCellScale, 1.0);
        layoutAttributes.center = _currentCellCenter;
        layoutAttributes.zIndex = 1;
    }
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // Get all the attributes for the elements in the specified frame
    NSArray *allAttributesInRect = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *cellAttributes in allAttributesInRect)
    {
        // Modify the attributes for the cells in the frame rect
        [self modifyForPinchLayoutAttibutes:cellAttributes];
    }
    return allAttributesInRect;
}


@end
