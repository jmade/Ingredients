//
//  UIImage+Color.h
//  CollectionView
//
//  Created by Justin Madewell on 1/4/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage*)setBackgroundImageByColor:(UIColor *)backgroundColor withFrame:(CGRect )rect;


+ (UIImage*) replaceColor:(UIColor*)color inImage:(UIImage*)image withTolerance:(float)tolerance;

+(UIImage *)changeWhiteColorTransparent: (UIImage *)image;

+(UIImage *)changeColorTo:(NSMutableArray*) array Transparent: (UIImage *)image;

//resizing Stuff...
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;



@end
