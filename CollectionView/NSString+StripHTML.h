//
//  NSString+StripHTML.h
//  GreenPaw
//
//  Created by Nikolay Dyankov on 7/10/13.
//  Copyright (c) 2013 Nikolay Dyankov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StripHTML)

+ (NSString *)stringByStrippingHTMLFromString:(NSString *)string;
+ (NSString *)stringByDecodingHTMLEntitiesInString:(NSString *)input;
+ (NSString *)stringByStrippingHTMLAndDecodingEntitiesFromString:(NSString *)input;

@end
