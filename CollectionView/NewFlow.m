//
//  NewFlow.m
//  CollectionView
//
//  Created by Justin Madewell on 12/24/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "NewFlow.h"
#import "NPDCollectionViewController.h"
#import "CollectionViewController.h"
#import "NPDHeaderView.h"
#import "Random.h"


@interface NewFlow () <UICollisionBehaviorDelegate>
@property (nonatomic, strong) UIGravityBehavior *gravityBeahvior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *itemBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *augmentedItemBehavior;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;

@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@property (nonatomic, strong)  UIInterpolatingMotionEffect *tiltMotionEffectHorizontal;
@property (nonatomic, strong)  UIInterpolatingMotionEffect *tiltMotionEffectVertical;





@property BOOL hasBeenResized;



@end

@implementation NewFlow




-(void)setCurrentCellPath:(NSIndexPath*)indexPath;
{
    
   // [self getCurrentSnappedItem];
    [self resetSnappedCell];
    _snappedCellPath = indexPath;
    _currentCellPath = indexPath;
    UICollectionViewLayoutAttributes *selectedCellAttributes = [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
    selectedCellAttributes.size = CGSizeMake(75, 75);
    CGPoint centerSnap = CGPointMake(self.collectionView.frame.size.width/2, 200);

    [self snapItem:selectedCellAttributes withPoint:&centerSnap];
  
    

}

-(void)resetSnappedCell{
    
    if (_pushBehavior != Nil) {
        [_dynamicAnimator removeBehavior:_pushBehavior];
        [_dynamicAnimator removeBehavior:_augmentedItemBehavior];
    }

    // Random Number Creation
    CGFloat randAugPlusMinus = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat randMagnitude = ([Random randomFloatFrom:1.0 to:4.0]-2.0);
    NSLog(@"Random Magnitude is %f",randMagnitude);
    // New Random Function
    srand48(time(0));
    double r = drand48();
    NSLog(@"r is %f", r);
    
    CGRect snappedRect = CGRectMake(84.955, 126.955, 150.09, 150.09);
    
    CGRectMake(self.collectionView.frame.size.width/2, 200, 20, 20);

    NSArray *dynamicAray = [_dynamicAnimator itemsInRect:snappedRect];
    
    
    for (UICollectionViewLayoutAttributes *item in dynamicAray)
        //Set up for Dynamic Item Behaviors
    {
        item.alpha = 1.0;
        item.size = CGSizeMake(75, 75);
        _pushBehavior = [[UIPushBehavior alloc]initWithItems:nil mode:UIPushBehaviorModeInstantaneous];
        [_pushBehavior addItem:item];
        _augmentedItemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:nil];
        [_augmentedItemBehavior addItem:item];
    
         NSUInteger i = rand()%10+1; NSLog(@"Random Number: %lu", (unsigned long)i);
        
        float angleR = ((float)arc4random_uniform(1000) - 500) * M_PI;
        NSLog(@"Random Angle is %f",angleR);
        
        [_pushBehavior setAngle:angleR magnitude:randMagnitude];
        
        

        
        
        
        CGFloat randAngularVelocity = [Random randomFloatFrom:10.5 to:15.5];
        if (randAugPlusMinus > 0.49)
        
        {
            [_augmentedItemBehavior addAngularVelocity:(r+randAngularVelocity) forItem:item];
        }
        else
        {
            [_augmentedItemBehavior addAngularVelocity:(r-randAngularVelocity) forItem:item];
        }

        
    }
    
    [_dynamicAnimator addBehavior:_pushBehavior];
    [_dynamicAnimator addBehavior:_augmentedItemBehavior];
}

-(void)setup {
 // SETUP CODE HERE
  
    
    
    
  
    
}

- (void)prepareLayout {
    
        
    self.itemSize = CGSizeMake(75, 75);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.headerReferenceSize = CGSizeMake(320, 200);
    
    
    
    if (!_dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];

        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 201, 320, 468)];
        _headerItems = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, 320, 200)];
        _headerAttribs = [_headerItems firstObject];
        _headerAttribs.zIndex = -1;
        
        for (UICollectionViewLayoutAttributes *item in items)
            //Set up for Dynamic Item Behaviors
        {
            

            item.size = CGSizeMake(75, 75);
            item.zIndex = 1;
            _snapBehavior = [[UISnapBehavior alloc]initWithItem:item snapToPoint:item.center];
            
            CGFloat randElasticity = [Random randomFloatFrom:0.4 to:0.6];
            CGFloat randDensity =  [Random randomFloatFrom:0.75 to:1.5];
            CGFloat randAngularVelocity = (CGFloat)random()/(CGFloat)RAND_MAX;
            CGFloat randPlusMinus = (CGFloat)random()/(CGFloat)RAND_MAX;
            
            UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:nil];
            
            [dynamicItemBehavior addItem:item];
            dynamicItemBehavior.elasticity = (randElasticity+0.12);
            dynamicItemBehavior.density = randDensity;
            dynamicItemBehavior.allowsRotation = YES;
            CGFloat randAddedAngularVelocity = [Random randomFloatFrom:8.5 to:13.5];
            if (randPlusMinus > 0.49)
                {
                [dynamicItemBehavior addAngularVelocity:(randAngularVelocity+randAddedAngularVelocity) forItem:item];
                }
            else
                {
                [dynamicItemBehavior addAngularVelocity:(randAngularVelocity-randAddedAngularVelocity) forItem:item];
                }

            [_dynamicAnimator addBehavior:dynamicItemBehavior];
            
            
        }
        
        // CollisionBehavior
        _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
        _collisionBehavior.collisionDelegate = self;
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        _collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
        [_dynamicAnimator addBehavior:_collisionBehavior];
        
        CGPoint endPoint = CGPointMake(self.collectionView.frame.size.height, self.collectionView.frame.size.width);
        CGPoint startPoint = CGPointMake(self.collectionView.frame.size.height, 0);
        
        [_collisionBehavior addBoundaryWithIdentifier:@"bottom" fromPoint:startPoint toPoint:endPoint];
        
        
        
        // Gravity Behavior
        _gravityBeahvior = [[UIGravityBehavior alloc]initWithItems:items];
        [_dynamicAnimator addBehavior:_gravityBeahvior];
        
        
        
        
        
       // [self startUpdates];
    }
}

-(CGSize)collectionViewContentSize {
    return self.collectionView.contentSize;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *animatedAttributes = [_dynamicAnimator itemsInRect:rect];
  
    NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:animatedAttributes];
    [allAttributes addObject:_headerAttribs];

    return allAttributes;
}

-(void)snapItem:(UICollectionViewLayoutAttributes *)theItem withPoint:(CGPoint *)snapPoint
{
    
    if (_snapBehavior != Nil) {
        [_dynamicAnimator removeBehavior:_snapBehavior];
    }
    
        CGFloat randDamping = [Random randomFloatFrom:0.60 to:0.82];
        _snapBehavior = [[UISnapBehavior alloc] initWithItem:theItem snapToPoint:*snapPoint];
        _snapBehavior.damping = randDamping;
    
        NSLog(@"Random Damping CGFloat: %f",randDamping);
    
        [_dynamicAnimator addBehavior:_snapBehavior];
        theItem.size = CGSizeMake(150, 150);
    
    [_dynamicAnimator updateItemUsingCurrentState:theItem];
    }

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id)item withBoundaryIdentifier:(id)identifier atPoint:(CGPoint)p {
    
   // [(UICollectionViewLayoutAttributes*)item setSize:CGSizeMake(75, 75)];
    
    
//    [UIView animateWithDuration:0.10
//                          delay:0.00
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         [(UICollectionViewLayoutAttributes*)item setSize:CGSizeMake(75, 75)];}
//                     completion:^(BOOL finished){}
//     ];
}
    

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return _headerAttribs;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *animatedAttributes = [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
    if (animatedAttributes.indexPath == _currentCellPath) {
        animatedAttributes.size = CGSizeMake(150, 150);
    }
    else {
        animatedAttributes.size = CGSizeMake(75, 75);
        
    }
    
    if (indexPath == 0)
        return _headerAttribs;
    else
        return animatedAttributes;
}

#pragma mark - scroll Ending

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        //[self updateStuff];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // [self updateStuff];
}





@end
