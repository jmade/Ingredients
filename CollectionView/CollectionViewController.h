//
//  CollectionViewController.h
//  CollectionView
//
//  Created by Justin Madewell on 10/29/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CollectionViewController : UIViewController<UIViewControllerTransitioningDelegate>
//@property (weak, nonatomic) IBOutlet UIButton *dimissView;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *downButton;

@property (nonatomic, strong) NSString *selectedCell;
@property (nonatomic, strong) NSString *ingredTitle;

@property (nonatomic, strong) NSDictionary *passedDictionary;
@property (nonatomic, strong) NSDictionary *selectedDictionary;
@property (nonatomic, strong) NSArray *cellValues;
@property (nonatomic, strong) NSArray *foundInItems;
@property (nonatomic, strong) NSMutableArray *mArray;

@property (nonatomic, strong) UINavigationController *navController;

@property (nonatomic, strong) UIImage *maskedHeaderImage;

@property (nonatomic, strong) UIImage *testImage;

@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;


// ColorArt Properties
@property (nonatomic, strong) UIColor *backgroundColorCA;
@property (nonatomic, strong) UIColor *primaryColorCA;
@property (nonatomic, strong) UIColor *secondaryColorCA;
@property (nonatomic, strong) UIColor *detailColorCA;
//





@end


