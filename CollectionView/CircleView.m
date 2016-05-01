//
//  CircleView.m
//  CollectionView
//
//  Created by Justin Madewell on 2/3/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // Random Color
        CGFloat redValue = (arc4random() % 255) / 255.0f;
        CGFloat blueValue = (arc4random() % 255) / 255.0f;
        CGFloat greenValue = (arc4random() % 255) / 255.0f;
        UIColor *randomColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0f];
        // End Random Color
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 50.0;
        self.layer.shadowOpacity = 0.9f;
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(1.0, 2.0);
        //self.layer.shouldRasterize = YES;
        //self.layer.shadowRadius = 1.0;
        
        //Make View
        self.contentView = [[UIView alloc]initWithFrame:self.frame];
        self.contentView.backgroundColor = randomColor;
        self.contentView.layer.cornerRadius = 50.0;
        self.contentView.layer.masksToBounds = YES;
        
        [self addSubview:self.contentView];
        

    }
    return self;
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
