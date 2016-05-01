//
//  MasterViewController.h
//  CollectionView
//
//  Created by Justin Madewell on 10/29/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic) NSArray *ingredientKeys;
@property (nonatomic) NSDictionary *ingredientDict;



//@property IBOutlet UISearchBar *ingSearchBar;

@property BOOL isFiltered;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;

@property (nonatomic, strong) NSMutableArray * initialIngredients;
@property (nonatomic, strong) NSMutableArray *filteredIngredientyArray;
@property (nonatomic, strong) NSArray *sortedIngredientsArray;
@property (nonatomic, strong) NSMutableArray *alphabetsArray;
@property (nonatomic, strong) UINavigationController *navController;


@end
