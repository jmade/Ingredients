//
//  FoundInProductViewController.h
//  CollectionView
//
//  Created by Justin Madewell on 11/25/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoundInProductViewController : UIViewController

@property (nonatomic, strong) NSArray *passedItems;
@property (nonatomic, strong) NSString *passedString;
@property (nonatomic, strong) NSMutableArray *foundInItems;
@property (nonatomic, strong) NSArray *productTypeTitles;

@property (nonatomic, strong) NSMutableArray *imageViewsCreated;
@property (nonatomic, strong) NSMutableArray *imageViewLabelArray;
@property (nonatomic, strong) NSMutableArray *productTypeArray;

@property (nonatomic, strong) NSDictionary *imageDictionary;
@property (nonatomic, strong) NSDictionary *productDictionary;
@property (nonatomic, strong) NSDictionary *allProductDictionary;
@property (nonatomic, strong) NSDictionary *allIngredDictionary;

@property (nonatomic, strong) NSMutableArray *mutablePointArray;
@property (nonatomic, strong) NSArray *pointArray;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *displayArray;



@property (nonatomic, strong) UIImageView *imageView;


@end
