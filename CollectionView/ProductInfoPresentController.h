//
//  ProductInfoPresentController.h
//  CollectionView
//
//  Created by Justin Madewell on 1/25/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import <Foundation/Foundation.h>
//Define a custom type for the transition mode
//It simply says which is the current showed view...

typedef NS_ENUM(NSUInteger, TypeOfTrans){
    PUSH = 0,
    POP
};



@interface ProductInfoPresentController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) TypeOfTrans typeTrans;

@end
