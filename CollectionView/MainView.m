//
//  MainView.m
//  CollectionView
//
//  Created by Justin Madewell on 1/26/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.photoView = [[PhotoView alloc] initWithFrame:frame];
        [self addSubview:self.photoView];
        
        self.detailView = [[DetailView alloc] initWithFrame:CGRectMake(50, frame.size.height, 668, 400)];
        self.detailView.hidden = YES;
        [self addSubview:self.detailView];

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
