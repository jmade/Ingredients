//
//  UIImage+MarshMallow.h
//  CollectionView
//
//  Created by Justin Madewell on 1/2/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MM_UIIMAGE_BYTES_PER_PIXEL 4u

@interface UIImage (MarshMallow)


/////////////////////////////////////////////////////////////////////////

#pragma mark - Pixel Processing

/////////////////////////////////////////////////////////////////////////

/** @name Pixel Processing */

/**
 
 Return an NSData object with the raw RGBA pixel byte data. Assumes CE_UIIMAGE_BYTES_PER_PIXEL bytes per pixel
 
 */

- (NSData *)getRawImageData;

/**
 
 Get the UIColor for the pixel at x,y
 
 \param xCoord 0 <= x < width
 
 \param yCoord 0 <= y < height
 
 */

- (UIColor *)samplePixelColorAtX:(NSUInteger)xCoord andY:(NSUInteger)yCoord;

/**
 
 Sample an even selection of N colors along a row in the image
 
 \param N The number of samples. 2 will give the end points N <= theXRange.length
 
 \param theY 0 <= y < height
 
 \param theXRange The starting column (0 based) and width to sample from. position + length must be <= image width.
 
 \return NSArray of UIColor's
 
 */

- (NSArray *)sampleNPixelColorsHorizontally:(NSUInteger)n onRowY:(NSUInteger)theY inXRange:(NSRange)theXRange;

/**
 
 Convenience method for the above using the full image width
 
 */

- (NSArray *)sampleNPixelColorsHorizontally:(NSUInteger)n onRowY:(NSUInteger)theY;

///@}

/////////////////////////////////////////////////////////////////////////

#pragma mark - Transformations

/////////////////////////////////////////////////////////////////////////

/** @name Transformations */

/** Returns a new image which is this one rotated by the specified angle. NOT THREAD SAFE: Call form the main thread only */

- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/** Convenience method for degree rotations. See imageRotatedByRadians: */

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/// @}

@end

