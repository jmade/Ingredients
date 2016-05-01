//
//  SwingController.h
//  CollectionView
//
//  Created by Justin Madewell on 12/2/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <Foundation/Foundation.h>
//Define a custom type for the transition mode
//It simply says which is the current showed view...
typedef NS_ENUM(NSUInteger, TransitionStep){
    INITIAL = 0,
    MODAL
};


@interface SwingController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) TransitionStep transitionTo;

@end
