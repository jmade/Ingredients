//
//  TagCollectionViewCell.h
//  CustomCollectionViewLayout
//
//  Created by Oliver Drobnik on 30.08.13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *label;

@property (nonatomic, strong) UIColor *outlineColor;
@property (nonatomic, strong) UIColor *cellColor;

@end
