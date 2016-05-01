//
//  FoundInProductViewController.m
//  CollectionView
//
//  Created by Justin Madewell on 11/25/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "FoundInProductViewController.h"
#import "NGAParallaxMotion.h"
#import <QuartzCore/QuartzCore.h>

@interface FoundInProductViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBeahvior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *itemBehavior;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property CGPoint currentLocation;

@end

@implementation FoundInProductViewController
@synthesize foundInItems, pointArray, mutablePointArray, imageViewsCreated, imageViewLabelArray, imageDictionary, productTypeArray, productDictionary, allProductDictionary, allIngredDictionary,typeArray, displayArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Yay!";
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 305, 20)];
    _typeLabel.numberOfLines = 1;
    _typeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    _typeLabel.contentMode = UIViewContentModeScaleAspectFit;
    _typeLabel.textColor = [UIColor whiteColor];
    _typeLabel.text = @"Type of Product Title";
    _typeLabel.alpha = 0;
    
    [self.view addSubview:_typeLabel];
    

    //_productLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 220, 80)];
    _productLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 305, 40)];
    _productLabel.numberOfLines = 1;
    _productLabel.font = [UIFont fontWithName:@"OriginalKatie" size:40];
    _productLabel.adjustsFontSizeToFitWidth = YES;
    _productLabel.contentMode = UIViewContentModeTop;
    _productLabel.textAlignment = NSTextAlignmentCenter;
    _productLabel.textColor = [UIColor whiteColor];
    _productLabel.text = @"Product";
    _productLabel.alpha = 0;
    
    [self.view addSubview:_productLabel];
    
//    NSString *productDataString = [[NSString alloc] init];
//    productDataString = [[NSBundle mainBundle] pathForResource:@"ProductData" ofType:@"plist"];
//    NSURL *ingredientDataUrl = [[NSURL alloc] initFileURLWithPath:productDataString isDirectory:NO];
//    allProductDictionary = [[NSDictionary alloc] initWithContentsOfURL:ingredientDataUrl];
    
    NSString *ingredDataString = [[NSString alloc] init];
    ingredDataString = [[NSBundle mainBundle] pathForResource:@"INGData" ofType:@"plist"];
    NSURL *ingredDataUrl = [[NSURL alloc] initFileURLWithPath:ingredDataString isDirectory:NO];
    allIngredDictionary = [[NSDictionary alloc] initWithContentsOfURL:ingredDataUrl];
    //NSLog(@"DIct: %@",allIngredDictionary);
    
    NSDictionary *selectedIngredientDictionary = [allIngredDictionary objectForKey:self.passedString];
    NSLog(@"DIct: %@",selectedIngredientDictionary);
    foundInItems = [selectedIngredientDictionary objectForKey:@"foundIn"];
    typeArray = [selectedIngredientDictionary objectForKey:@"typeLabel"];
    displayArray = [selectedIngredientDictionary objectForKey:@"displayName"];
    
    
    
    //[self createImageforArray:self.passedItems];
    
    [self createImageforArray:foundInItems];
    
   
    [NSValue valueWithCGPoint:CGPointMake(65,160)];
    
    pointArray = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(65,160)],[NSValue valueWithCGPoint:CGPointMake(160,160)],[NSValue valueWithCGPoint:CGPointMake(255,160)],[NSValue valueWithCGPoint:CGPointMake(65,248)],[NSValue valueWithCGPoint:CGPointMake(160,248)],[NSValue valueWithCGPoint:CGPointMake(255,248)],nil];
    
    
    
    //Simple gesture recognizer for Swipe left
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
    [self.passedString capitalizedString];
    
    

    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Blackboard Background"]];
    
   // foundInItems = [[NSMutableArray alloc]initWithArray:self.passedItems];
    NSLog(@"Passed Array: %@", self.passedItems);
    NSLog(@"Passed String: %@", self.passedString);
    NSLog(@"foundInItmes Array: %@",foundInItems);
    
    float x = arc4random() % 11 * 0.1;
    NSLog(@"Random Number: %f",x);
    
    float randomFloat = ((arc4random() % 11 * 0.1)-0.543);
    NSLog(@"Random Float: %f",randomFloat);
    
    CGFloat randCGFloat = (((CGFloat)random()/(CGFloat)RAND_MAX)-0.450);
    NSLog(@"Random CGFLoat: %f",randCGFloat);
    
    
    UITapGestureRecognizer *viewDoubleTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewDoubleTapped:)];
    viewDoubleTapped.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:viewDoubleTapped];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:imageViewsCreated];
    //gravityBeahvior.angle = 90;
    [animator addBehavior:_gravityBeahvior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:imageViewsCreated];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    [animator addBehavior:collisionBehavior];
    
    
    
    for (UIImageView *imageItem in imageViewsCreated)
    {
        //imageItem.alpha = .95f;
        CGFloat randElasticity = (CGFloat)random()/(CGFloat)RAND_MAX;
        CGFloat randDensity = (CGFloat)random()/(CGFloat)RAND_MAX;
        CGFloat randAngularVelocity = (CGFloat)random()/(CGFloat)RAND_MAX;
        CGFloat randResistance = (CGFloat)random()/(CGFloat)RAND_MAX;
        
        
        //CGFloat randFriction = (CGFloat)random()/(CGFloat)RAND_MAX;
       // CGFloat randYLinearVelocity = (CGFloat)random()/(CGFloat)RAND_MAX;
       
        
        UIDynamicItemBehavior *imageDynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:nil];
        [imageDynamicItemBehavior addItem:imageItem];
        [imageDynamicItemBehavior addAngularVelocity:(randAngularVelocity+15) forItem:imageItem];
        imageDynamicItemBehavior.elasticity = randElasticity;
        imageDynamicItemBehavior.density = randDensity;
        imageDynamicItemBehavior.resistance = randResistance;
        imageDynamicItemBehavior.allowsRotation = YES;
        [animator addBehavior:imageDynamicItemBehavior];
        //Animation Fade In
        
        [UIView animateWithDuration:0.10
                              delay:0.01
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ imageItem.alpha = 0.95; }
                         completion:^(BOOL finished){}
         ];

        
    }
    self.animator = animator;

}

-(void)createImageforArray:(NSArray *)foundInArray

{
    NSUInteger foundInItemsCount = [foundInItems count];
   
    imageViewsCreated = [[NSMutableArray alloc]initWithCapacity:foundInItemsCount];
    imageViewLabelArray = [[NSMutableArray alloc]initWithCapacity:foundInItemsCount];
    productTypeArray = [[NSMutableArray alloc]initWithCapacity:foundInItemsCount];
    
    for (NSString *imageString in foundInArray)
    {
        int xx = arc4random()%280;
        int yy = arc4random()%30;
        
         NSLog(@"Random X:%i",xx);
         NSLog(@"Random Y:%i",yy);
        
        UIImage *image = [UIImage imageNamed:imageString];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectMake (130,-20, 75.0f, 75.0f);
        imageView.alpha = 0.0f;
        imageView.userInteractionEnabled = YES;
        
        imageView.layer.cornerRadius = 5.0;
        imageView.layer.masksToBounds = YES;
        
        [self.view addSubview:imageView];
        [self.view sendSubviewToBack:imageView];
        
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleImageTap:)];
        imageTap.numberOfTapsRequired = 1;
        imageTap.delaysTouchesBegan = YES;
        [imageView addGestureRecognizer:imageTap];
        
        
        
        [imageViewsCreated insertObject:imageView atIndex:0];
        [imageViewLabelArray insertObject:imageString atIndex:0];
        
        

    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Gesture Handler
-(void)handleImageTap:(UITapGestureRecognizer *)gesture {
    [UIView animateWithDuration:0.10
                          delay:0.01
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _productLabel.alpha = 0,_typeLabel.alpha = 0;}
                     completion:^(BOOL finished){}
     ];

    
    NSLog(@"Image Tapped");
    CGPoint tapPoint = [gesture locationInView:self.view];

    for (UIImageView *imageView in self.view.subviews)
    {
        if (CGRectContainsPoint(imageView.frame, tapPoint))
        {
            NSUInteger imageIndex = [self.view.subviews indexOfObject:imageView];
            NSLog(@"Image Number:%lu",(unsigned long)imageIndex);
            
            NSValue *val = [pointArray objectAtIndex:imageIndex];
            CGPoint snapPoint = [val CGPointValue];
            
//            UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
//        
//            UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:nil];
//            collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//            collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
//            [animator addBehavior:collisionBehavior];
        
//            UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:imageView snapToPoint:snapPoint];
//            snapBehavior.damping = 0.5;
            //[_animator addBehavior:snapBehavior];
            
            
            if (_snapBehavior != Nil) {
                [self.animator removeBehavior:_snapBehavior];
                
            }
            _snapBehavior = [[UISnapBehavior alloc] initWithItem:imageView snapToPoint:snapPoint];
            _snapBehavior.damping = 0.7;
            [self.animator addBehavior:_snapBehavior];
            
            [_gravityBeahvior removeItem:imageView];
            
           // NSString *tappedProductString = [imageViewLabelArray objectAtIndex:imageIndex];
            
            NSArray* reversedTypeArray = [[typeArray reverseObjectEnumerator] allObjects];
            NSArray* reversedDisplayArray = [[displayArray reverseObjectEnumerator] allObjects];
            
            
            _typeLabel.text = [reversedTypeArray objectAtIndex:imageIndex];
            _productLabel.text = [reversedDisplayArray objectAtIndex:imageIndex];
           
            
//            productDictionary = [allProductDictionary objectForKey:tappedProductString];
//            NSString *productTypeString = [productDictionary objectForKey:@"typeTitle"];
//        
//            _typeLabel.text = [productTypeString uppercaseString];
//            _productLabel.text = [productDictionary objectForKey:@"displayName"];
            
            
           
            
        
            
            [UIView animateWithDuration:0.65
                                  delay:0.01
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{ _productLabel.alpha = 0.95; }
                             completion:^(BOOL finished){}
             ];
            
            [UIView animateWithDuration:0.40
                                  delay:0.65
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{ _typeLabel.alpha = 0.95; }
                             completion:^(BOOL finished){}
             ];

            
            
            
            
            
            
            
            
            //self.animator = animator;
            
        }
        
    }
   
    
}

-(void)imagedDoubleTapped:(UITapGestureRecognizer *)gesture {
    NSLog(@"Double Tap");
}
-(void)handleViewDoubleTapped:(UITapGestureRecognizer *)gesture {
    NSLog(@" View Double Tapped");
    [UIView animateWithDuration:0.80
                          delay:0.01
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _productLabel.alpha = 0, _typeLabel.alpha = 0; }
                     completion:^(BOOL finished){}
     ];
    if (_gravityBeahvior != Nil) {
        [self.animator removeBehavior:_gravityBeahvior];
        
    }


    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:imageViewsCreated];
    [animator addBehavior:_gravityBeahvior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:imageViewsCreated];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    [animator addBehavior:collisionBehavior];
    
    for (UIImageView *imageItem in imageViewsCreated)
    {
        CGFloat randElasticity = (CGFloat)random()/(CGFloat)RAND_MAX;
        CGFloat randDensity = (CGFloat)random()/(CGFloat)RAND_MAX;
        CGFloat randResistance = (CGFloat)random()/(CGFloat)RAND_MAX;
        
        CGFloat randYLinearVelocity = (CGFloat)random()/(CGFloat)RAND_MAX;
        CGPoint randLinearVelocityPoint = CGPointMake(0, randYLinearVelocity);
    
        CGFloat randAngularVelocity = (((CGFloat)random()/(CGFloat)RAND_MAX)-0.550);
        NSLog(@"Random CGFLoat: %f",randAngularVelocity);
        
        
        UIDynamicItemBehavior *imageDynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:nil];
        [imageDynamicItemBehavior addItem:imageItem];
        [imageDynamicItemBehavior addAngularVelocity:randAngularVelocity forItem:imageItem];
        [imageDynamicItemBehavior addLinearVelocity:randLinearVelocityPoint forItem:imageItem];
        imageDynamicItemBehavior.elasticity = randElasticity;
        imageDynamicItemBehavior.density = randDensity;
        imageDynamicItemBehavior.resistance = randResistance;
        imageDynamicItemBehavior.allowsRotation = YES;
        [animator addBehavior:imageDynamicItemBehavior];
    }
    
    self.animator = animator;
    
   
}

- (void)dismiss:(UIGestureRecognizer*)gesture {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *theTouch = [touches anyObject];
    
    for (UIImageView *imageView in imageViewsCreated)
    {
        _currentLocation = [theTouch locationInView:self.view];
        _attachment = [[UIAttachmentBehavior alloc] initWithItem:imageView attachedToAnchor:(_currentLocation)];
      
    }
      [_animator addBehavior:_attachment];
}


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
     UITouch *theTouch = [touches anyObject];
    _currentLocation = [theTouch locationInView:self.view];
    _attachment.anchorPoint = _currentLocation;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_animator removeBehavior:_attachment];
}










@end
