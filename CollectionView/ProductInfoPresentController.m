//
//  ProductInfoPresentController.m
//  CollectionView
//
//  Created by Justin Madewell on 1/25/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import "ProductInfoPresentController.h"
#import "Random.h"

@implementation ProductInfoPresentController



//Define the transition duration
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.90;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //STEP 1
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
     NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (self.typeTrans == PUSH) {
        
        //Insert/Stack the Views ...........................................................
        UIView *container = [transitionContext containerView];
        [container insertSubview:toViewController.view aboveSubview:fromViewController.view];
        
        CGAffineTransform rotation;
        rotation = CGAffineTransformMakeRotation(M_PI);
        toViewController.view.transform = CGAffineTransformMakeRotation(M_PI);
        
        CGFloat randX = [Random randomFloatFrom:100 to:700];
        CGFloat randY = [Random randomFloatFrom:100 to:700];
        
        // Random One or the Other
        CGFloat randPlusMinus = (CGFloat)random()/(CGFloat)RAND_MAX;
        if (randPlusMinus > 0.49){
        
        
            // Do This Stuff
            // -
           toViewController.view.frame =  CGRectOffset(screenBounds, -randY, -randX); // to the Left and Above
        }
        else
        {
            // Do it this way
            // +
            toViewController.view.frame =  CGRectOffset(screenBounds, randY, randX);
            
        }
        NSLog(@"My Starting Frame: %@", NSStringFromCGRect(toViewController.view.frame));
        //Perform the animation..............................
           
        [UIView animateWithDuration:duration
                              delay:0.0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.76
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             toViewController.view.frame = screenBounds;
                              toViewController.view.transform = CGAffineTransformMakeRotation(0);

                             fromViewController.view.alpha = 0.15;
                             fromViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                            
                             
                                                    } completion:^(BOOL finished) {
                                                        NSLog(@"PUSH Completed");
                                                        [transitionContext completeTransition:YES];
                                                    }
         ];
       
        
         }
    //STEP 2B: From the Second view(POP) -> to the First View(INITIAL)
        else
        {
        
        //Insert/Stack the Views ...........................................................
        UIView *container = [transitionContext containerView];
        [container insertSubview:fromViewController.view aboveSubview:toViewController.view];
        
        toViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        toViewController.view.alpha = 0.15;
        fromViewController.view.frame = screenBounds;
        
        //Perform the animation...............................
        
            [UIView animateWithDuration:duration
                                  delay:0.0
                 usingSpringWithDamping:0.6
                  initialSpringVelocity:0.78
                            options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 toViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                 toViewController.view.alpha = 1.0;
                                
                                CGFloat randX = [Random randomFloatFrom:400 to:700];
                                CGFloat randY = [Random randomFloatFrom:400 to:700];
                                
                                // Random One or the Other
                                CGFloat randPlusMinus = (CGFloat)random()/(CGFloat)RAND_MAX;
                                if (randPlusMinus > 0.49)
                                {
                                    fromViewController.view.frame =  CGRectOffset(screenBounds, -randY, -randX); // to the Left and Above
                                }
                                else
                                {
                                    fromViewController.view.frame =  CGRectOffset(screenBounds, randY, randX);
                                }
                             }
                             completion:^(BOOL finished) {
                                 NSLog(@"POP Completed");
                                 [transitionContext completeTransition:YES];
                             }
             ];
            
        }
    
}





@end
