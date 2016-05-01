//
//  AppDelegate.m
//  CollectionView
//
//  Created by Justin Madewell on 10/29/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIColor *blueSteele = [UIColor colorWithRed:41/255.0f green:158/255.0f blue:255/255.0f alpha:0.75f];
    UIColor *redAppTintColor = [UIColor colorWithRed:103/255.0f green:153/255.0f blue:170/255.0f alpha:1.0];
    UIColor *lushGreen = [UIColor colorWithRed:78/255.0f green:179/255.0f blue:87/255.0f alpha:1.0f];
    UIColor *lushYellow = [UIColor colorWithRed:238/255.0f green:219/255.0f blue:56/255.0f alpha:1.0f];

//    
    NSShadow *shadow = [[NSShadow alloc] init];
    //shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, 1);
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      lushYellow,
//      NSForegroundColorAttributeName, shadow, NSShadowAttributeName,
//      [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor],NSForegroundColorAttributeName, shadow,NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0], NSFontAttributeName, nil]];
    
    
    
    [[UINavigationBar appearance] setBarTintColor:blueSteele];
    [[UINavigationBar appearance] setTintColor:redAppTintColor];
    //[[UINavigationBar appearance] setTranslucent:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    

    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    
    MasterViewController *ingredientController = [[navController viewControllers] objectAtIndex:0];
   
    
    
    NSString *ingredientData = [[NSString alloc] init];
    ingredientData = [[NSBundle mainBundle] pathForResource:@"NewIngredientDataApp" ofType:@"plist"];
    NSURL *ingredientDataUrl = [[NSURL alloc] initFileURLWithPath:ingredientData isDirectory:NO];
    NSDictionary *ingredientDict = [[NSDictionary alloc] initWithContentsOfURL:ingredientDataUrl];
    NSArray *ingredientKeys = [ingredientDict allKeys];
    
    ingredientController.ingredientKeys = ingredientKeys;
    ingredientController.ingredientDict = ingredientDict;
    ingredientController.navController = navController;
    
    
    
  
   
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
