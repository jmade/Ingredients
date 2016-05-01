//
//  CollectionViewController.m
//  CollectionView
//
//  Created by Justin Madewell on 10/29/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//


#import "MasterViewController.h"
#import "CollectionViewController.h"
#import "FoundInProductViewController.h"
#import "NPDCollectionViewController.h"
#import "TagCollectionViewCell.h"
#import "SKHeaderView.h"
#import "FooterView.h"
#import "NGAParallaxMotion.h"
#import "ShrinkDismissAnimationController.h"
#import "SwipeInteractionController.h"
#import "SwingController.h"
#import <AVFoundation/AVFoundation.h>
#import "NewFlow.h"
#import "UIImage+AverageColor.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"
#import "UIImage+ImageEffects.h"
#import "BackgroundLayer.h"
#import "UIImage+MarshMallow.h"
#import "UIImage+Combine.h"
#import "UIColor+Modify.h"
#import "CRMotionView.h"
// ColorArt Classes
#import "SLColorArt.h"
#import "UIImage+Scale.h"
#import "UIImage+ColorArt.h"
#import "UIImage+Color.h"
#import "Random.h"


@interface CollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) SwingController *transitionManager;
@property (nonatomic, strong) SKHeaderView *header;
@property (nonatomic, strong) UIColor *ingredColor;
@property (nonatomic, strong) UIColor *xtrLightColor;
@property (nonatomic, strong) UIColor *lightColor;
@property (nonatomic, strong) UIColor *darkColor;
@property (nonatomic, strong) UIImage *ingImage;

@property (nonatomic, strong) UIColor *sampleColor;
@property (nonatomic, strong) NSArray *returnedColorsArray;



@property (nonatomic, strong) UIColor *averageColor;
@property (nonatomic, strong) UIColor *averageFloodedColor;

@property CGFloat clearAlpha;
@property CGFloat blurredAlpha;
@end

@implementation CollectionViewController

{
	TagCollectionViewCell *_sizingCell;
}
@synthesize maskedHeaderImage, mArray;

-(UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}



- (void)setup {
    //TransitionManager class implements the UIViewControllerAnimatedTransitioning protocol
    //Its instance is responsible to mange transitions in this controller.
    self.transitionManager = [[SwingController alloc]init];
}


-(void)viewWillAppear:(BOOL)animated{
    [self setup];
    [self getImageAndSetColor];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //[self.collectionView scrollRectToVisible:CGRectMake(0, 64, 1, 1) animated:NO];
    
    
   
    
    

    [_downButton setTintColor:(_secondaryColorCA == [UIColor whiteColor]) ?  _xtrLightColor : [_secondaryColorCA lightenColor:0.25] ];
    [_navController.navigationBar setBarTintColor:_darkColor];
    [_navController.navigationBar setTintColor:(_secondaryColorCA == [UIColor whiteColor]) ?  _xtrLightColor : [_secondaryColorCA lightenColor:0.25]];
       UILabel *nav_titlelbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.navigationItem.titleView.frame.size.width,40)];
    nav_titlelbl.text=self.ingredTitle;
    nav_titlelbl.adjustsFontSizeToFitWidth = YES;
    nav_titlelbl.textAlignment=NSTextAlignmentCenter;
    UIFont *lblfont=[UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
    [nav_titlelbl setFont:lblfont];
    [nav_titlelbl setTextColor: (_secondaryColorCA == [UIColor whiteColor]) ?  [UIColor whiteColor] : [_secondaryColorCA lightenColor:0.25] ];
    self.navigationItem.titleView=nav_titlelbl;
    
    
}




- (void)viewDidLoad
{
      [super viewDidLoad];
    self.collectionView.contentInset = UIEdgeInsetsMake(-32, 0, 75, 0);
    
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    //Load the Data for the Collection View
    
    self.selectedDictionary = [self.passedDictionary objectForKey:self.selectedCell];
    self.ingredTitle = [self.selectedDictionary objectForKey:@"IngredientName"];
    self.cellValues = [self.selectedDictionary objectForKey:@"InfoCells"];
    self.foundInItems = [self.selectedDictionary objectForKey:@"FoundIn"];
    // CollectionView Delegates
    self.collectionView.backgroundColor =[UIColor colorWithWhite:0 alpha:.10];  //[UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.allowsSelection = 1;
    
    
    
    // Register the Cell Nib with the CollectionView
	UINib *cellNib = [UINib nibWithNibName:@"TagCollectionViewCell" bundle:nil];
	[self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"TagCell"];
    // get a cell as template for sizing
	_sizingCell = [[cellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    // Register the Header View with the Collection View
    [self.collectionView registerClass:[SKHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    // Register the Footer View with Collection View
    [self.collectionView registerClass:[FooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
   // [FooterView class];
    
    UIView *backingHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320.0f, 200.0f)];
    backingHeaderView.backgroundColor = [UIColor blueColor];
    backingHeaderView.alpha = 0.5;
  //  [self.collectionView addSubview:backingHeaderView];
    
    UIView *backingBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320.0f, 200.0f)];
    backingBackView.backgroundColor = [UIColor orangeColor];
    backingBackView.alpha = 0.75;
//    [self.view addSubview:backingBackView];
//    [self.view sendSubviewToBack:backingBackView];
    
    
    
}

#pragma mark - Private

- (void)colorizeForImage:(UIImage *)image
{
    // Grab the Image and Scan it to get the Color scheme From it
    
    //image = [image scaledToSize:CGSizeMake(64,64)];
    SLColorArt *colorArt = [image colorArt];
    
    _backgroundColorCA = colorArt.backgroundColor;
    _primaryColorCA = colorArt.primaryColor;
    _secondaryColorCA = colorArt.secondaryColor;
    _detailColorCA = colorArt.detailColor;
}

-(void)getImageAndSetColor
{
    // Get "floodfill" string to fecth image
    NSString *baseString = self.selectedCell;
    baseString = [baseString stringByAppendingString:@"_floodfill"];
    // Flooded Image
    UIImage *floodFillImage = [UIImage imageNamed:baseString];
    // Original Image
    UIImage *image = [UIImage imageNamed:self.selectedCell];
    
    // Rectangles to Crop
    CGRectMake(59, 72, 200, 51); // Rect
    CGRectMake(73, 25, 175, 150); // Square
    CGRectMake(72, 62, 175, 20); // for Rounded Rect
    CGRectMake(0, 60, 200, 200); // Exact Square
    // Current Rect
    CGRectMake(72, 110, 100, 10); // Currently Using
    // Crop the Image to specified Rect
    UIImage *croppedIngredientImage = [image croppedImage:CGRectMake(72, 110, 100, 10)];
    _ingImage = croppedIngredientImage; // For testing to link to be Displayed in the Header View
   
    // Color Section
    [self colorizeForImage:floodFillImage];
    _averageFloodedColor = [croppedIngredientImage averageColor];
    _averageColor = [floodFillImage averageColor];
    
    // Blurred Colors
    _xtrLightColor = [[_ingImage applyExtraLightEffect]averageColor];
    _darkColor = [[_ingImage applyDarkEffect]averageColor];
    _lightColor = [[_ingImage applyLightEffect]averageColor];
   
    // Lighten the Colors for Gradient
    UIColor *lighterLightColor = [_lightColor lightenColor:.25];
    UIColor *darkerDarkColor = [_averageColor darkenColor:.25];
    
    // Create ColorRefs for use in the Gradient Layer

    
    CGColorRef light = CGColorRetain(lighterLightColor.CGColor);
    CGColorRef middle = CGColorRetain(darkerDarkColor.CGColor);
    // Create the Gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(__bridge id)(light),middle,nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
   
}

#pragma mark - UIScrollview


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat scroll = (-scrollView.contentOffset.y);

    if (scroll < 0) {
        return;
    }

    
   // NSLog(@"Scroll Points: %f",scroll);

    
    
   if (scroll < 64)
   {
    _header.headerLabel.alpha = 1;
    _header.clearImageView.alpha = 0;
    _header.clearMotionView.alpha = 0;
    _header.blurredImageView.alpha = 1;
       
    return;
       
   }
    

    if (scroll > 64)
    {

    CGFloat delta = scroll-64;
    //NSLog(@"Delta: %f",delta);
        
    
    CGFloat fadeOut = 1.0-(delta/50);
   // NSLog(@"Fade Out: %f",fadeOut);
    _header.blurredImageView.alpha = fadeOut;
    
    CGFloat fadeIn = delta/50;
    _header.clearImageView.alpha = fadeIn ;
    _header.clearMotionView.alpha = fadeIn;
  //  NSLog(@"Fade In: %f",fadeIn);
    
    CGFloat lableOut = 0.99-(delta/21);
   // NSLog(@"Label Out: %f",lableOut);
    _header.headerLabel.alpha = lableOut;
        if (delta < 10) {
            if ( _header.clearMotionView.motionEnabled == YES) {
                NSLog(@"Motion OFF");
                [_header.clearMotionView setMotionEnabled:NO];
            }

        }
        
        
        
        
        if (delta > 10) {
            if ( _header.clearMotionView.motionEnabled == NO) {
                NSLog(@"Motion On");
                 [_header.clearMotionView setMotionEnabled:YES];
            }
            
        }
       
    }
}


#pragma mark - UICollectionView Delegate

- (void)preferredContentSizeChanged:(NSNotification *) notification {
    [self.collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.cellValues count];
}

- (void)_configureCell:(TagCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    cell.label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    NSString *text = [self.cellValues objectAtIndex:indexPath.row];
    
    cell.label.text = text;
    cell.label.textColor = _darkColor;
    cell.outlineColor = _darkColor;
    cell.cellColor = _xtrLightColor;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	TagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCell" forIndexPath:indexPath];
	[self _configureCell:cell forIndexPath:indexPath];
	return cell;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        
        _header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        _header.userInteractionEnabled = YES;
        
//        _header.clearImageView.image = [UIImage imageNamed:self.selectedCell];
//        _header.clearImageView.alpha = 0;
        
        _header.clearMotionView.image = [UIImage imageNamed:self.selectedCell];
        _header.clearMotionView.alpha = 0;
             
        
        _header.blurredImageView.image = [[UIImage imageNamed:self.selectedCell] applyBlurWithRadius:6 tintColor:[UIColor colorWithWhite:0 alpha:0.4] saturationDeltaFactor:1.8 maskImage:nil];
        _header.blurredImageView.alpha = 1.0;
        
        _header.headerLabel.text = [self.selectedDictionary objectForKey:@"ScientificName"];
        _header.headerLabel.adjustsFontSizeToFitWidth = YES;
        _header.headerLabel.numberOfLines = 1;
        _header.headerLabel.textColor = [_secondaryColorCA lightenColor:0.19];
        
        _header.headerLabel.parallaxIntensity = 12;
        _header.headerLabel.userInteractionEnabled = YES;

        UILongPressGestureRecognizer *tapAndHold = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAndHold:)];
        
        [_header.headerLabel addGestureRecognizer:tapAndHold];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.delaysTouchesBegan = YES;
        
        
        
        return _header;
    }
    else
    {
        FooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor clearColor];
        UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 310.0f, 50.0f)];
        //UILabel *toNewCollectionViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 310.0f, 50.0f)];
        
        UILabel *toNewCollectionViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 310.0f, 80)];
        //toNewCollectionViewLabel.parallaxIntensity = 2;
        
        toNewCollectionViewLabel.text = @"Products";
        toNewCollectionViewLabel.textColor = (_secondaryColorCA == [UIColor whiteColor]) ?  _xtrLightColor : [_secondaryColorCA lightenColor:0.25];
        toNewCollectionViewLabel.textAlignment = NSTextAlignmentCenter;
        //toNewCollectionViewLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        toNewCollectionViewLabel.font = [UIFont fontWithName:@"OriginalKatie" size:35];
        toNewCollectionViewLabel.userInteractionEnabled = YES;
        
//        testLabel.text = @"Found In Products >>>";
//        testLabel.textColor = _primaryColorCA;
//        testLabel.textAlignment = NSTextAlignmentCenter;
//        testLabel.userInteractionEnabled = YES;
        
        //[footer addSubview:testLabel];
        [footer addSubview:toNewCollectionViewLabel];
        
        UITapGestureRecognizer *newFoundInTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleNewFoundInTap:)];
        newFoundInTap.numberOfTapsRequired = 1;
        newFoundInTap.delaysTouchesBegan = YES;

//        UITapGestureRecognizer *foundInTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleFoundInTap:)];
//        foundInTap.numberOfTapsRequired = 1;
//        foundInTap.delaysTouchesBegan = YES;
//        
//        [testLabel addGestureRecognizer:foundInTap];
        
        [toNewCollectionViewLabel addGestureRecognizer:newFoundInTap];

        return footer;
    }
}


#pragma Mark gestureRecognizer



-(void)handleTapAndHold:(UILongPressGestureRecognizer *)longTap {
    NSLog(@"Tap and Hold");
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:[self.selectedDictionary objectForKey:@"ScientificName"]];
    
    utterance.rate = AVSpeechUtteranceMaximumSpeechRate/4;
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-AU"];
    [utterance setVoice:voice];
    if (UIGestureRecognizerStateBegan == longTap.state) {
        [self.synthesizer speakUtterance:utterance];
    }
    
}
- (void)handleNewFoundInTap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"New Found In Tap");

    // Load Flow
    NewFlow *newLayout = [NewFlow new];
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    NPDCollectionViewController *NPDcv = [[NPDCollectionViewController alloc]initWithCollectionViewLayout:newLayout];
    NPDcv.transitioningDelegate = self;
    
    [NPDcv setPassedItems:[self.selectedDictionary objectForKey:@"FoundIn"]];
    [NPDcv setPassedString:self.selectedCell];
   
    
    [self presentViewController:NPDcv animated:YES completion:^{
        NSLog(@"Presenting NPD CollectionView");
    }];

}


- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // Double Tap
    NSLog(@"Double Tap");
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma Mark Layout & Sizing

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(320.0f, 200.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(320.0f, 80.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	[self _configureCell:_sizingCell forIndexPath:indexPath];
    
    CGFloat cellHeight = [_sizingCell systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
	
    return CGSizeMake(320.0f, cellHeight+14.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 1, 0);
}


#pragma Mark IBActions

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dragDown:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)pronounceIngredient:(id)sender {
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.selectedCell];
    
    utterance.rate = AVSpeechUtteranceMaximumSpeechRate/4;
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-AU"];
    [utterance setVoice:voice];
    [self.synthesizer speakUtterance:utterance];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [segue.destinationViewController setPassedItems:[self.selectedDictionary objectForKey:@"FoundIn"]];
    [segue.destinationViewController setPassedString:self.selectedCell];
   
    
}

#pragma mark - UIVieControllerTransitioningDelegate -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source{
    self.transitionManager.transitionTo = INITIAL;
    return self.transitionManager;
    
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transitionManager.transitionTo = MODAL;
    return self.transitionManager;
}

-(void)dealloc{
    self.collectionView.delegate = nil;
}



@end
