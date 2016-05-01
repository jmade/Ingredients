//
//  UIImage+Combine.m
//  CollectionView
//
//  Created by Justin Madewell on 1/2/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import "UIImage+Combine.h"

@implementation UIImage (Combine)

- (UIImage*)overlayWith:(UIImage*)overlayImage {
    
	// size is taken from the background image
	UIGraphicsBeginImageContext(self.size);
    
	[self drawAtPoint:CGPointZero];
	[overlayImage drawAtPoint:CGPointZero];
    
	/*
     // If Image Artifacts appear, replace the "overlayImage drawAtPoint" , method with the following
     // Yes, it's a workaround, yes I filed a bug report
     CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
     [overlayImage drawInRect:imageRect blendMode:kCGBlendModeOverlay alpha:0.999999999];
     */
    
	UIImage *combinedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return combinedImage;
}

@end
