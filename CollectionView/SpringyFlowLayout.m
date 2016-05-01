//
//  SpringyFlowLayout.m
//  CollectionView
//
//  Created by Justin Madewell on 10/29/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "SpringyFlowLayout.h"
#import "CollectionViewController.h"
#import "TagCollectionViewCell.h"
#import "SKHeaderView.h"
#import "FooterView.h"

@interface SpringyFlowLayout ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;

// Needed for tiling
@property (nonatomic, strong) NSMutableSet *visibleIndexPathsSet;
@property (nonatomic, assign) CGFloat latestDelta;
@property (nonatomic, assign) UIInterfaceOrientation interfaceOrientation;

@end


@implementation SpringyFlowLayout

-(id)init {
    if (!(self = [super init])) return nil;
    
    self.minimumInteritemSpacing = 5;
//    self.minimumLineSpacing = 10;
    
    
    
    return self;
}


- (void)prepareLayout {
    [super prepareLayout];
    
    //Set Header & Footer Sizes
    self.headerReferenceSize = CGSizeMake(320, 200);
    self.footerReferenceSize = CGSizeMake(320, 80);
    
    // Get Content Size
    CGSize contentSize = [self collectionViewContentSize];
    
    // Header
    NSArray *headerAttributeArray = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, self.headerReferenceSize.width, self.headerReferenceSize.height)];
    _headerAttribs = [headerAttributeArray firstObject];
    
    // Cells
    NSArray *cellAttributeArray = [super layoutAttributesForElementsInRect:CGRectMake(0,self.headerReferenceSize.height+1, contentSize.width, contentSize.height-((self.headerReferenceSize.height+1) + (self.footerReferenceSize.height+1)))];

    // Footer
    NSArray *footerAttributeArray = [super layoutAttributesForElementsInRect:CGRectMake(0, contentSize.height-self.footerReferenceSize.height, contentSize.width, self.footerReferenceSize.height)];
    _footerAttribs = [footerAttributeArray firstObject];

    //CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    if (!_dynamicAnimator)
    {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];

        
        for (UICollectionViewLayoutAttributes *item in cellAttributeArray)
        {
            CGPoint center = item.center;
            UIAttachmentBehavior *springBehaviour = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:center];
            
            springBehaviour.length = 0.5;
            springBehaviour.damping = 0.8f;
            springBehaviour.frequency = 1.0f;
            
            
            [_dynamicAnimator addBehavior:springBehaviour];

        }
        
    }

}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *animatedAttributes  = [_dynamicAnimator itemsInRect:rect];
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:animatedAttributes];
    [allAttributes addObject:_headerAttribs];
    [allAttributes addObject:_footerAttribs];
    
 
    
    CGPoint offset = [self.collectionView contentOffset];
   // NSLog(@"OFFSET: %f",offset.y);
    CGFloat inset = -48;
    
    if (offset.y < inset)
    {
        CGFloat deltaY = fabsf(offset.y - inset);
        //NSLog(@"DELTA: %f",deltaY);
        
        for (UICollectionViewLayoutAttributes *attrs in allAttributes)
        { 
            if ([attrs representedElementCategory] == UICollectionElementCategoryCell)
            {
                 CGFloat cellFloat = (deltaY/100)+1;
            }
        }
        
        
        for (UICollectionViewLayoutAttributes *attrs in allAttributes)
        {
            
            if ([attrs representedElementKind] == UICollectionElementKindSectionHeader)
            {
                
                CGRect headerRect = [attrs frame];
                //headerRect.size.height = MAX(minY, headerSize.height + deltaY);
                //headerRect.origin.y = headerRect.origin.y + deltaY/2;
                
                CGRect finalRect = CGRectMake(headerRect.origin.x, headerRect.origin.y, headerRect.size.width, headerRect.size.height+deltaY);
                
                [attrs setFrame:finalRect];
                attrs.zIndex = -10;
                CGFloat scaleFloat = (deltaY/100)+1;
                //NSLog(@"Scale: %f",scaleFloat);
                attrs.transform = CGAffineTransformScale(attrs.transform, scaleFloat, scaleFloat);
                
                break;
            }
        }
    }


    
    return allAttributes;
}




-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    CGFloat newDelta = scrollView.contentOffset.y;
   // NSLog(@"New Delta: %f",newDelta);
    
    self.latestDelta = delta;
    
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [_dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
        CGFloat distanceFromTouch = fabsf(touchLocation.y - springBehaviour.anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / 2000.0f;
        
        UICollectionViewLayoutAttributes *item = [springBehaviour.items firstObject];
        CGPoint center = item.center;
        if (delta < 0) {
            center.y += MAX(delta, delta*scrollResistance);
        }
        else {
            center.y += MIN(delta, delta*scrollResistance);
        }
        item.center = center;
        
        [_dynamicAnimator updateItemUsingCurrentState:item];
    }];
    
    if (newDelta < -32) {
        return YES;
    }
    else {
        return NO;
    }
    
    
}
@end
