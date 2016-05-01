//
//  NPDHeaderView.m
//  CollectionView
//
//  Created by Justin Madewell on 12/26/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "NPDHeaderView.h"

@implementation NPDHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _productTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 305, 40)];
        _productTitleLabel.numberOfLines = 1;
        _productTitleLabel.font = [UIFont fontWithName:@"OriginalKatie" size:40];
        _productTitleLabel.adjustsFontSizeToFitWidth = YES;
        _productTitleLabel.contentMode = UIViewContentModeTop;
        _productTitleLabel.textAlignment = NSTextAlignmentCenter;
        _productTitleLabel.textColor = [UIColor whiteColor];
        _productTitleLabel.text = @"";
        _productTitleLabel.alpha = 0;
        
        [self addSubview:_productTitleLabel];
        
    
        
        _typeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 305, 20)];
        _typeNameLabel.numberOfLines = 1;
        _typeNameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        _typeNameLabel.textAlignment = NSTextAlignmentCenter;
        _typeNameLabel.contentMode = UIViewContentModeScaleAspectFit;
        _typeNameLabel.textColor = [UIColor whiteColor];
        _typeNameLabel.text = @"";
        _typeNameLabel.alpha = 0;
        
        [self addSubview:_typeNameLabel];

    }
    return self;
}


-(void)setProductTitle:(NSString *)text
{
    self.productTitleLabel.alpha = 0;
    
    _productTitleLabel.text = text;
    NSLog(@"Product Label Set");
    
    [UIView animateWithDuration:0.65
                          delay:0.00
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{[self.productTitleLabel setAlpha:0.95];}
                     completion:^(BOOL finished){NSLog(@"Product Animation Ended");}
     ];

//    [UIView animateWithDuration:.65 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseIn animations:^{[self.productTitleLabel setAlpha:0.95];} completion:^(BOOL finished){NSLog(@"Product Animation Ended");}];
//
    
}

-(void)setTypeName:(NSString *)text
{
    self.typeNameLabel.alpha = 0;
    _typeNameLabel.text = text;
    NSLog(@"Type Label Set");
    
//    [UIView animateWithDuration:0.40
//                          delay:0.65
//                        options:UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{[self.typeNameLabel setAlpha:0.95];}
//                     completion:^(BOOL finished){NSLog(@"TypeName Animation Ended");}
//     ];
//    
   
    //options:UIViewAnimationOptionCurveEaseIn
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
