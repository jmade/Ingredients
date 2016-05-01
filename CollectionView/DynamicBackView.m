//
//  DynamicBackView.m
//  CollectionView
//
//  Created by Justin Madewell on 2/3/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import "DynamicBackView.h"

@implementation DynamicBackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        
        _itemView = [[UIView alloc]initWithFrame:CGRectMake(160, 0, 50 , 50)];
        _itemView.backgroundColor = [UIColor purpleColor];
        
        _itemView.layer.cornerRadius = 25;
        _itemView.layer.masksToBounds = YES;
        [self addSubview:_itemView];
        
        
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
        _gravityBeahvior = [[UIGravityBehavior alloc]init];
        _collisionBehavior = [[UICollisionBehavior alloc]init];
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        _collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
        _itemBehavior = [[UIDynamicItemBehavior alloc]init];
        
        

        
        [_itemBehavior addItem:_itemView];
        _itemBehavior.elasticity = 0.95;
        //_itemBehavior.resistance = 0.6;
        _itemBehavior.allowsRotation = YES;
        [_gravityBeahvior addItem:_itemView];
        [_collisionBehavior addItem:_itemView];
       
        
        [_animator addBehavior:_itemBehavior];
        [_animator addBehavior:_gravityBeahvior];
        [_animator addBehavior:_collisionBehavior];
        
        
        
        
        
        
        
        
        // Initialization code
        
        
        
        
        
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
