//
//  NPDHeaderView.h
//  CollectionView
//
//  Created by Justin Madewell on 12/26/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPDHeaderView : UICollectionReusableView

@property (nonatomic, strong) UILabel *productTitleLabel;
@property (nonatomic, strong) UILabel *typeNameLabel;

-(void)setProductTitle:(NSString *)text;
-(void)setTypeName:(NSString *)text;





@end
