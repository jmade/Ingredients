//
//  ShrinkDismissAnimationController.m
//  CollectionView
//
//  Created by Justin Madewell on 11/7/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "ShrinkDismissAnimationController.h"

@implementation ShrinkDismissAnimationController

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.50;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // 1. obtain state from the context
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    // 2. obtain the container view
    UIView *containerView = [transitionContext containerView];
    
    // 3. set initial state
    toViewController.view.frame = finalFrame;
    toViewController.view.alpha = 0.5;
    
    // 4. add the view
    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];
    
    // 1. Determine the intermediate and final frame for the from view
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect shrunkenFrame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width/4, fromViewController.view.frame.size.height/4);
    CGRect fromFinalFrame = CGRectOffset(shrunkenFrame, 0, screenBounds.size.height);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // animate with keyframes
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  // 2a. keyframe one
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    fromViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                                                                    toViewController.view.alpha = 0.5;
                                                                }];
                                  // 2b. keyframe two
                                  [UIView addKeyframeWithRelativeStartTime:0.5
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    fromViewController.view.frame = fromFinalFrame;
                                                                    toViewController.view.alpha = 1.0;
                                                                }];
                              }
                              completion:^(BOOL finished) {
                                  // 3. inform the context of completion
                                  NSShadow *shadow = [[NSShadow alloc] init];
                                  //shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
                                  shadow.shadowColor = [UIColor clearColor];
                                  shadow.shadowOffset = CGSizeMake(0, 1);
                                  
                                  [UIColor colorWithRed:41/255.0f green:158/255.0f blue:255/255.0f alpha:0.20];
                                  
                                 
                                  
                                  [[UINavigationBar appearance] setTitleTextAttributes:
                                   [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0],
                                    NSForegroundColorAttributeName, shadow, NSShadowAttributeName,
                                    [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0], NSFontAttributeName, nil]];
//                                  [toViewController.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                                                               [UIColor whiteColor],
//                                                                                                               NSForegroundColorAttributeName, shadow, NSShadowAttributeName,
//                                                                                                               [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0], NSFontAttributeName, nil]];
                                  
                                  [toViewController.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0f green:158/255.0f blue:255/255.0f alpha:0.75]];
                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
    
}

@end

