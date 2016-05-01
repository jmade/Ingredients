//
//  NewFoundInViewController.m
//  CollectionView
//
//  Created by Justin Madewell on 12/20/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "NewFoundInViewController.h"
#import "FoundInCell.h"
#import "NewFlow.h"


@interface NewFoundInViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation NewFoundInViewController

@synthesize foundInProducts, collectionView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewWillAppear {
    // Flow Layout
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    layout.itemSize = CGSizeMake(20, 50);
//    layout.minimumInteritemSpacing = 40;
//    layout.minimumLineSpacing = 40;
//    
//    //
//    [collectionView setCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    CGFloat h = 480; // 568
    
    [self.collectionView setContentSize:CGSizeMake(320, h)];
    
    
    
    // Configure Collection View
    [self.collectionView registerClass:[FoundInCell class] forCellWithReuseIdentifier:@"myCell"];
    
    
    self.view.backgroundColor  = [UIColor greenColor];

    // Fill the foundInProducts Array with PassedItems
    foundInProducts = [[NSMutableArray alloc]initWithArray:self.passedItems];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return foundInProducts.count ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];

    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(320.0f, 225.0f);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(320.0f, 120.0f);
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
