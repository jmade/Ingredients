//
//  NPDCell.m
//  CollectionView
//
//  Created by Justin Madewell on 12/21/13.
//  Copyright (c) 2013 Justin Madewell. All rights reserved.
//

#import "NPDCell.h"
#import "NPDHeaderView.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"

@implementation NPDCell
{
    UIImageView *imageView;
    UIImage *bigImage;
    UIImage *smallImage;
}

@synthesize cellLabel, cellImageView;




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
                
        imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 5, 5)];
        [self.contentView addSubview:imageView];
        
        
        UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        selectedBackgroundView.image = _image;
        
        selectedBackgroundView.backgroundColor = [UIColor clearColor];
       // self.selectedBackgroundView = selectedBackgroundView;
                                          
                                          
//        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320.0f, frame.size.height + 205.0f)];
//        cellLabel.contentMode = UIViewContentModeBottom;
//        cellLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
//        cellLabel.text = @"test";
//        cellLabel.textAlignment = NSTextAlignmentCenter;
//        cellLabel.textColor = [UIColor whiteColor];
//        cellLabel.backgroundColor = [UIColor clearColor];
//        
//        cellImageView = [[UIImageView alloc]initWithFrame:frame];
//        
//
//        [self addSubview:cellLabel];
//        [self addSubview:cellImageView];
        //[self sendSubviewToBack:cellImageView];
        
        
        // Initialization code
    }
    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.backgroundColor = [UIColor whiteColor];
    self.image = nil; //also resets imageView's image
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    
    
    if (self.highlighted)
        {
            imageView.alpha = 0.6f;
            
            
            
           
            
            }
    else
        {
            imageView.alpha = 1.0f;
        
           
            }
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    
   
    
    imageView.image = bigImage;
}

-(void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    if (self.selected) {
        imageView.alpha = 1.0f;
        imageView.image = bigImage;
       // imageView.bounds = CGRectMake(0,0,100,100);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView sizeToFit];
        
       
        
    }
    else
    {
        imageView.alpha = 1.0f;
        imageView.image = smallImage;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView sizeToFit];
    }
    
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
