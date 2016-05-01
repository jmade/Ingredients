//
//  SwipeInteractionController.h
//  CollectionView
//
//  Created by Justin Madewell on 11/7/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeInteractionController : UIPercentDrivenInteractiveTransition



- (void)wireToViewController:(UIViewController*)viewController;

@property (nonatomic, assign) BOOL interactionInProgress;


@end
