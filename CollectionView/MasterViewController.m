//
//  MasterViewController.m
//  CollectionView
//
//  Created by Justin Madewell on 10/29/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "MasterViewController.h"
#import "CollectionViewController.h"
#import "BouncePresentAnimationController.h"
#import "ShrinkDismissAnimationController.h"
#import "SwipeInteractionController.h"
#import "Random.h"



@interface MasterViewController ()
<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
@end

@implementation MasterViewController {
    BouncePresentAnimationController *_bounceAnimationController;
    ShrinkDismissAnimationController *_shrinkDismissAnimationController;
    SwipeInteractionController *_interactionController;
    
}
@synthesize isFiltered, filteredIngredientyArray, initialIngredients, mySearchBar, myTableView, sortedIngredientsArray, alphabetsArray;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _bounceAnimationController = [BouncePresentAnimationController new];
        _shrinkDismissAnimationController = [ShrinkDismissAnimationController new];
        _interactionController = [SwipeInteractionController new];
        //[_interactionController wireToViewController:toVC];
    }
    return self;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    [_interactionController wireToViewController:toVC];
    if (operation == UINavigationControllerOperationPush) {
       
        return _bounceAnimationController;
    }
    else {
        
        // [_interactionController wireToViewController:toVC];
        
        return _shrinkDismissAnimationController;
    }
}

- (id <UIViewControllerInteractiveTransitioning>) navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return _interactionController.interactionInProgress ? _interactionController : Nil;
}



//- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController: (UIViewController *)source {
//    
//    return _bounceAnimationController;
//}

//- (id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed {
//    return _shrinkDismissAnimationController;
//}


- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    
    return _interactionController.interactionInProgress ? _interactionController : nil;

}


- (void)viewDidLoad
{
    UIColor *blueSteele = [UIColor colorWithRed:41/255.0f green:158/255.0f blue:255/255.0f alpha:0.75f];
    UIColor *redAppTintColor = [UIColor colorWithRed:255/255.0f green:103/255.0f blue:136/255.0f alpha:1.0];
    
    
    [super viewDidLoad];
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    //[[UINavigationBar appearance] setBarTintColor:lushYellow];
    [self.navigationController.navigationBar setBarTintColor:blueSteele];
    [self.navigationController.navigationBar setTintColor:redAppTintColor];

    initialIngredients = [[NSMutableArray alloc]initWithArray:self.ingredientKeys];
    
    sortedIngredientsArray = [self.ingredientKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
      
    // self.edgesForExtendedLayout = UIRectEdgeNone;

    
    
       self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.title = @"Ingredients";
    
    
    self.myTableView.tintColor = blueSteele;
    
    self.navigationController.delegate = self;
    mySearchBar.placeholder = @"Ingredient Name";
    mySearchBar.tintColor = redAppTintColor;
    //self.tableView.sectionIndexMinimumDisplayRowCount = NSIntegerMax;
    myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    myTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    myTableView.sectionIndexColor = redAppTintColor;
	// Do any additional setup after loading the view, typically from a nib.
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    

    

}

//-(void)viewWillAppear:(BOOL)animated {
//    
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//
//}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [mySearchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isFiltered == YES) {
        return filteredIngredientyArray.count;
    } else {
        return sortedIngredientsArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *MyIdentifier = @"IngreditentCellIdentifier";
    
	/*
     Retrieve a cell with the given identifier from the table view.
     The cell is defined in the main storyboard: its identifier is MyIdentifier, and  its selection style is set to None.
     */
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (isFiltered == YES) {
        cell.textLabel.text = [filteredIngredientyArray objectAtIndex:indexPath.row];
    } else {
       cell.textLabel.text = [sortedIngredientsArray objectAtIndex:indexPath.row];
    }

    
	//cell.textLabel.text = [self.ingredientKeys objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [mySearchBar resignFirstResponder];
}


#pragma mark UISearchBar Delegate Methods
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isFiltered = NO;
    searchBar.text = @"";
    mySearchBar.text = @"";
    //[searchBar textDidChange]
   // [mySearchBar resignFirstResponder];
    [searchBar resignFirstResponder];
    [myTableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        isFiltered = NO;
    }
    else {
        isFiltered = YES;
        
        filteredIngredientyArray = [[NSMutableArray alloc]init];
        
        for (NSString * ingredientName in initialIngredients)
        {
            NSRange ingredientNameRange = [ingredientName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (ingredientNameRange.location != NSNotFound)
            {
                [filteredIngredientyArray addObject:ingredientName];
            }
        }
            
    }
    
    [myTableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (isFiltered == YES) {
        return nil;
    }
    else
    [self createAlphabetArray];
    return alphabetsArray;
    
}



- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    for (int i = 0; i < [sortedIngredientsArray count]; i++) {
        NSString *letterString = [[sortedIngredientsArray objectAtIndex:i] substringToIndex:1];
        if ([letterString isEqualToString:title]) {
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }
    return index;
}

#pragma mark - Create Alphabet Array
- (void)createAlphabetArray {
    NSMutableArray *tempFirstLetterArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [sortedIngredientsArray count]; i++) {
        NSString *letterString = [[sortedIngredientsArray objectAtIndex:i] substringToIndex:1];
        if (![tempFirstLetterArray containsObject:letterString]) {
            [tempFirstLetterArray addObject:letterString];
        }
    }
    alphabetsArray = tempFirstLetterArray;
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *toVC = segue.destinationViewController;
    toVC.transitioningDelegate = self;
    // sender is the table view cell that was selected
    UITableViewCell *cell = sender;
    [segue.destinationViewController setSelectedCell:cell.text];
    [segue.destinationViewController setPassedDictionary:self.ingredientDict];
    [segue.destinationViewController setNavController:self.navigationController];
    //[segue.destinationViewController prefersStatusBarHidden];
    [_interactionController wireToViewController:toVC];
}

@end
