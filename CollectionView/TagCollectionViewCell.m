//
//  TagCollectionViewCell.m
//  CustomCollectionViewLayout
//
//  Created by Oliver Drobnik on 30.08.13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

#import "TagCollectionViewCell.h"

@implementation TagCollectionViewCell

- (void)drawRect:(CGRect)rect
{
    //rect.size.width = 320.0f;
	// inset by half line width to avoid cropping where line touches frame edges
	CGRect insetRect = CGRectInset(rect, 0.5, 0.5);
   // alignmentRectInsets = [UIEdgeInsetsMake(5, 5, 5, 5)];
   	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:insetRect cornerRadius:rect.size.height/10.0f];
	
	// white background
	[self.cellColor setFill];
	[path fill];

	// red outline
  // [[UIColor colorWithRed:41/255.0f green:158/255.0f blue:255/255.0f alpha:0.30] setStroke];
    
    
    [self.outlineColor setStroke];
    
    
    
    
    
    
    //[[UIColor blackColor] setStroke];
	//[[UIColor colorWithRed:103/255.0f green:153/255.0f blue:170/255.0f alpha:1.0] setStroke];
	[path stroke];
}



@end
