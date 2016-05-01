//
//  SwipeInteractionController.m
//  CollectionView
//
//  Created by Justin Madewell on 11/7/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "SwipeInteractionController.h"

@implementation SwipeInteractionController {
    BOOL _shouldCompleteTransition;
    UINavigationController *_navigationController;
    CGFloat _startScale;
}

- (void)wireToViewController:(UIViewController *)viewController {
    _navigationController = viewController.navigationController;
    [self prepareGestureRecognizerInView:viewController.view];
}


- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handlePinch:(UIPinchGestureRecognizer*)gestureRecognizer {
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            _startScale = gestureRecognizer.scale;
            // 1. Start an interactive transition!
            self.interactionInProgress = YES;
            [_navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. compute the current position
            CGFloat fraction = 1.0 - gestureRecognizer.scale / _startScale;
            // 3. should we complete?
            _shouldCompleteTransition = (fraction > 0.5);
            // 4. update the animation controller
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            // 5. finish or cancel
            self.interactionInProgress = NO;
            if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }
            else {
                [self finishInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

@end
