//
//  DynamicBackView.h
//  CollectionView
//
//  Created by Justin Madewell on 2/3/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicBackView : UIView

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBeahvior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *itemBehavior;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;

@property (nonatomic, strong) UIView *itemView;

@end
