//
//  SKHeaderView.m
//  Skeleton
//
//  Created by Justin Madewell on 10/15/13.
//  Copyright (c) 2013 Backslash Dev. All rights reserved.
//

#import "SKHeaderView.h"
#import "NGAParallaxMotion.h"
#import "CRMotionView.h"

@implementation SKHeaderView
@synthesize bottomLabel,clearImageView,blurredImageView,clearMotionView;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    if (self)
    {
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-50, 320.0f, 20)];
        _headerLabel.contentMode = UIViewContentModeBottom;
        _headerLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        _headerLabel.text = @"test";
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.textColor = [UIColor clearColor];
        _headerLabel.backgroundColor = [UIColor clearColor];
        
        
//        clearImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 200.0f)];
//        [clearImageView setContentMode:UIViewContentModeScaleAspectFill];
//        [clearImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//        [clearImageView setClipsToBounds:YES];
        
        clearMotionView = [[CRMotionView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 200.0f)];
        [clearMotionView setMotionEnabled:NO];
        
        blurredImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 200.0f)];
        [blurredImageView setContentMode:UIViewContentModeScaleAspectFill];
        [blurredImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [blurredImageView setClipsToBounds:YES];
        
        
        [self addSubview:blurredImageView];
        //[self addSubview:clearImageView];
        [self addSubview:clearMotionView];
        
        [self addSubview:_headerLabel];
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
