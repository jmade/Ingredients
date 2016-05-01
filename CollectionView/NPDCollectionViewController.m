//
//  NPDCollectionViewController.m
//  CollectionView
//
//  Created by Justin Madewell on 12/21/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "NPDCollectionViewController.h"
#import "NPDCell.h"
#import "NewCell.h"
#import "NewFlow.h"
#import "NGAParallaxMotion.h"
#import "NPDHeaderView.h"
#import "UIImage+ImageEffects.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"
#import "UIImage+AverageColor.h"
#import "Random.h"
#import "NSString+StripHTML.h"
#import "ItemViewController.h"
#import "ProductInfoPresentController.h"
#import "NProductViewViewController.h"


const NSTimeInterval kAnimationDuration = 0.20;

@interface NPDCollectionViewController () <UIViewControllerTransitioningDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) ProductInfoPresentController *transitionManager;


@property CGFloat typeNameLabelAlpha;
@property CGFloat productTitleLabelAlpha;

@property NSString *typeNameLabelString;
@property NSString *productTitleLabelString;

@property UILabel *productTitleLabel;
@property UILabel *typeNameLabel;

@property UIView *backingHeaderView;
@property UIImageView *headerImageView;
@property UIImageView *frontImageView;
@property UIImageView *backImageView;
@property UIImage *tappedImage;
@property UITapGestureRecognizer *cellTap;



@property UIColor *darkColor;
@property UIColor *wood;
@property BOOL imageHasDropped;
@end

@implementation NPDCollectionViewController {
    
}

@synthesize foundInProducts;

- (void)setup {
    //TransitionManager class implements the UIViewControllerAnimatedTransitioning protocol
    //Its instance is responsible to mange transitions in this controller.
    self.transitionManager = [[ProductInfoPresentController alloc]init];
}




- (void)viewWillAppear:(BOOL)animated{
    
   
    
    [self setUpMotion];
    [self setup];
    
    
    // Create an empty table header view with small bottom border view
    _backingHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, self.view.frame.size.width, 200.0)];
    
    
    _typeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 305, 20)];
    _typeNameLabel.numberOfLines = 1;
    _typeNameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    _typeNameLabel.adjustsFontSizeToFitWidth = YES;
    _typeNameLabel.textAlignment = NSTextAlignmentCenter;
    _typeNameLabel.contentMode = UIViewContentModeScaleAspectFit;
    _typeNameLabel.textColor = [UIColor whiteColor];
    _typeNameLabel.text = @"";
    _typeNameLabel.alpha = 0;
    
    [_backingHeaderView addSubview:_typeNameLabel];
    
    _productTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 305, 40)];
    _productTitleLabel.numberOfLines = 1;
    _productTitleLabel.font = [UIFont fontWithName:@"OriginalKatie" size:40];
    _productTitleLabel.adjustsFontSizeToFitWidth = YES;
    _productTitleLabel.contentMode = UIViewContentModeTop;
    _productTitleLabel.textAlignment = NSTextAlignmentCenter;
    _productTitleLabel.textColor = [UIColor whiteColor];
    _productTitleLabel.text = @"";
    _productTitleLabel.alpha = 0;
    
    [_backingHeaderView addSubview:_productTitleLabel];
    
    [self.view addSubview:_backingHeaderView];

    foundInProducts = [[NSMutableArray alloc]initWithArray:self.passedItems];
    NSLog(@"foundInItmes Array: %@",foundInProducts);
    
    
    CGFloat h = 480; // 568
    
    [self.collectionView setContentSize:CGSizeMake(320, h)];
    
  
    
    
 
    
    UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Chalkboard Background"]];
    self.collectionView.backgroundView = backView;
    // Register the Cell Nib with the CollectionView
	UINib *cellNib = [UINib nibWithNibName:@"NewCell" bundle:nil];
	[self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"NewCell"];
    _wood = [UIColor colorWithPatternImage:[UIImage imageNamed:@"purty_wood"]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

     [super viewWillAppear:YES];
    animated = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [self setUpMotion];
    [self setup];
    
    
    // Create an empty table header view with small bottom border view
    _backingHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, self.view.frame.size.width, 200.0)];
    
    
    _typeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 305, 20)];
    _typeNameLabel.numberOfLines = 1;
    _typeNameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    _typeNameLabel.adjustsFontSizeToFitWidth = YES;
    _typeNameLabel.textAlignment = NSTextAlignmentCenter;
    _typeNameLabel.contentMode = UIViewContentModeScaleAspectFit;
    _typeNameLabel.textColor = [UIColor whiteColor];
    _typeNameLabel.text = @"";
    _typeNameLabel.alpha = 0;
    
    [_backingHeaderView addSubview:_typeNameLabel];
    
    _productTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 305, 40)];
    _productTitleLabel.numberOfLines = 1;
    _productTitleLabel.font = [UIFont fontWithName:@"OriginalKatie" size:40];
    _productTitleLabel.adjustsFontSizeToFitWidth = YES;
    _productTitleLabel.contentMode = UIViewContentModeTop;
    _productTitleLabel.textAlignment = NSTextAlignmentCenter;
    _productTitleLabel.textColor = [UIColor whiteColor];
    _productTitleLabel.text = @"";
    _productTitleLabel.alpha = 0;
    
    [_backingHeaderView addSubview:_productTitleLabel];
    
    [self.view addSubview:_backingHeaderView];
    
    foundInProducts = [[NSMutableArray alloc]initWithArray:self.passedItems];
    NSLog(@"foundInItmes Array: %@",foundInProducts);
    
    
     CGFloat h = 480; // 568
    
    [self.collectionView setContentSize:CGSizeMake(320, h)];
    
    
    
    
    UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Chalkboard Background"]];
    self.collectionView.backgroundView = backView;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    animated = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.allowsMultipleSelection = NO;
    self.collectionView.allowsSelection = YES;
    
    // Register the Header View with the Collection View
    [self.collectionView registerClass:[NPDHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    // Register the Cell Nib with the CollectionView
	UINib *cellNib = [UINib nibWithNibName:@"NewCell" bundle:nil];
	[self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"NewCell"];
    _wood = [UIColor colorWithPatternImage:[UIImage imageNamed:@"purty_wood"]];

    
    [self.collectionView registerClass:[NPDCell class] forCellWithReuseIdentifier:@"myCell"];
	// Do any additional setup after loading the view.
    
    //Simple gesture recognizer for Swipe left
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:swipe];
    
    //Get the Product Dictionary
    NSString *rootData = [[NSString alloc] init];
    rootData = [[NSBundle mainBundle] pathForResource:@"NEWPRODUCTDATA" ofType:@"plist"];
    NSURL *rootDataUrl = [[NSURL alloc] initFileURLWithPath:rootData isDirectory:NO];
    _rootDictionary = [[NSDictionary alloc] initWithContentsOfURL:rootDataUrl];
    
    _productDict = [_rootDictionary objectForKey:self.passedString];
    
    NSString * displayNameString = [self.productDict objectForKey:@"displayName"];
    
    NSLog(@"displayNameString: %@", displayNameString);
    

}

-(void)setUpMotion{
    self.tiltMotionEffectHorizontal = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    
    self.tiltMotionEffectHorizontal.minimumRelativeValue = [NSNumber numberWithFloat:-5.0];
    
    self.tiltMotionEffectHorizontal.maximumRelativeValue = [NSNumber numberWithFloat:5.0];
    
    self.tiltMotionEffectVertical = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    self.tiltMotionEffectVertical.minimumRelativeValue = [NSNumber numberWithFloat:-5.0];
    
    self.tiltMotionEffectVertical.maximumRelativeValue = [NSNumber numberWithFloat:5.0];
    
  
    

}





-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NPDHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    return header;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return foundInProducts.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = _wood;
    
    UIImage *cellImage = [UIImage imageNamed:[foundInProducts objectAtIndex:indexPath.item]];
    cell.cellImageView.image = cellImage;
    
    cell.cellImageView.layer.cornerRadius = 5.0;
    cell.cellImageView.layer.masksToBounds = YES;
    cell.cellImageView.layer.shouldRasterize = YES;
    
    cell.layer.cornerRadius = 5.0;
    cell.layer.masksToBounds = YES;
    
    cell.layer.shouldRasterize = YES;
    
    _cellTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCellTap:)];
    _cellTap.numberOfTapsRequired = 2;
    _cellTap.delaysTouchesEnded = NO;
    [cell addGestureRecognizer:_cellTap];
//    [cell addMotionEffect:_tiltMotionEffectHorizontal];
//    [cell addMotionEffect:_tiltMotionEffectVertical];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//
//    [self.collectionView.collectionViewLayout invalidateLayout];
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//
//
    [UIView animateWithDuration:0.10
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{ _productTitleLabel.alpha = 0,  _typeNameLabel.alpha = 0;}
                     completion:^(BOOL finished){}
     ];

    NewFlow *layout = (NewFlow *)self.collectionView.collectionViewLayout;
    layout.currentCellPath = indexPath;
    
    
    _tappedCell = [foundInProducts objectAtIndex:indexPath.item];
    _productDict = [_rootDictionary objectForKey:_tappedCell];
   
    _typeNameLabel.text = [_productDict valueForKey:@"typeLabel"];
    _productTitleLabel.text = [_productDict valueForKey:@"displayName"];
    
    

    
    
    [UIView animateWithDuration:0.65
                          delay:0.10
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _productTitleLabel.alpha = 0.95;}
                     completion:^(BOOL finished){}
     ];
    
    [UIView animateWithDuration:0.35
                          delay:0.55
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _typeNameLabel.alpha = 0.95; }
                     completion:^(BOOL finished){}
     ];


    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
  //  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //[cell.contentView removeGestureRecognizer:_cellTap];
}



#pragma mark - Gesture Handler

- (void)dismiss:(UIGestureRecognizer*)gesture {
//    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
     [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}











-(void)handleCellTap:(UITapGestureRecognizer *)gesture {
//    UIGraphicsBeginImageContextWithOptions(self.collectionView.bounds.size, NULL, 0);
//    [self.collectionView drawViewHierarchyInRect:self.collectionView.frame afterScreenUpdates:NO];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImage *lightImage = [newImage applyLightEffect];
//    UIImageView *screenShotBlur = [[UIImageView alloc]initWithImage:lightImage];
//   // [self.collectionView addSubview:screenShotBlur];
    NSLog(@"Cell Tapped");
    
  //  NewFlow *layout = (NewFlow *)self.collectionView.collectionViewLayout;
    
    NProductViewViewController *NPIvc = [[NProductViewViewController alloc]init];
    NPIvc.modalPresentationStyle = UIModalPresentationCustom;
    NPIvc.transitioningDelegate = self;
    [NPIvc setProductDict:_productDict];
//    [NPIvc setScreenImage:lightImage];

    [self presentViewController:NPIvc animated:YES completion:^{
        NSLog(@"Item View Pushed");
    }];
   }



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  //  [segue.destinationViewController setProductDict:_productDict];
   // [segue.destinationViewController setScreenImage:lightImage];
}



#pragma mark - UIViewControllerTransitioningDelegate -


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source{
    
    
    
    
    
    _transitionManager.typeTrans = PUSH;
   
   
    return _transitionManager;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _transitionManager.typeTrans = POP;
    
    return _transitionManager;
}



















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
