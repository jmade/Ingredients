//
//  NSString+StripHTML.m
//  GreenPaw
//
//  Created by Nikolay Dyankov on 7/10/13.
//  Copyright (c) 2013 Nikolay Dyankov. All rights reserved.
//

#import "NSString+StripHTML.h"

@implementation NSString (StripHTML)

+ (NSString *)stringByStrippingHTMLFromString:(NSString *)string {
    NSRange range;

    while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        string = [string stringByReplacingCharactersInRange:range withString:@""];
    }
    
    return string;
}

+ (NSString *)stringByDecodingHTMLEntitiesInString:(NSString *)input {
    NSMutableString *results = [NSMutableString string];
    NSScanner *scanner = [NSScanner scannerWithString:input];
    [scanner setCharactersToBeSkipped:nil];
    while (![scanner isAtEnd]) {
        NSString *temp;
        if ([scanner scanUpToString:@"&" intoString:&temp]) {
            [results appendString:temp];
        }
        if ([scanner scanString:@"&" intoString:NULL]) {
            BOOL valid = YES;
            unsigned c = 0;
            NSUInteger savedLocation = [scanner scanLocation];
            if ([scanner scanString:@"#" intoString:NULL]) {
                // it's a numeric entity
                if ([scanner scanString:@"x" intoString:NULL]) {
                    // hexadecimal
                    unsigned int value;
                    if ([scanner scanHexInt:&value]) {
                        c = value;
                    } else {
                        valid = NO;
                    }
                } else {
                    // decimal
                    int value;
                    if ([scanner scanInt:&value] && value >= 0) {
                        c = value;
                    } else {
                        valid = NO;
                    }
                }
                if (![scanner scanString:@";" intoString:NULL]) {
                    // not ;-terminated, bail out and emit the whole entity
                    valid = NO;
                }
            } else {
                if (![scanner scanUpToString:@";" intoString:&temp]) {
                    // &; is not a valid entity
                    valid = NO;
                } else if (![scanner scanString:@";" intoString:NULL]) {
                    // there was no trailing ;
                    valid = NO;
                } else if ([temp isEqualToString:@"amp"]) {
                    c = '&';
                } else if ([temp isEqualToString:@"quot"]) {
                    c = '"';
                } else if ([temp isEqualToString:@"lt"]) {
                    c = '<';
                } else if ([temp isEqualToString:@"gt"]) {
                    c = '>';
                } else {
                    // unknown entity
                    valid = NO;
                }
            }
            if (!valid) {
                // we errored, just emit the whole thing raw
                [results appendString:[input substringWithRange:NSMakeRange(savedLocation, [scanner scanLocation]-savedLocation)]];
            } else {
                [results appendFormat:@"%C", (unichar)c];
            }
        }
    }
    
    results = [[ results stringByReplacingOccurrencesOfString:@"&#37;" withString: @"&"  ] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#124;" withString: @"|"  ] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#160;" withString: @" "  ] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8211;" withString:@"-"] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8212;" withString:@"——"] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8216;" withString:@"'"  ] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"  ] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8218;" withString:@","  ] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8220;" withString:@"\""  ] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8221;" withString:@"\""  ] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8230;" withString:@"..."] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#38;" withString:@"<"] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#39;" withString:@">"] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8364;" withString:@"€"] copy];
    results = [[ results stringByReplacingOccurrencesOfString:@"&#8594;" withString:@"→"] copy];
    
    return results;
}

+ (NSString *)stringByStrippingHTMLAndDecodingEntitiesFromString:(NSString *)input {
    NSString *result = [self stringByStrippingHTMLFromString:input];
    result = [self stringByDecodingHTMLEntitiesInString:result];
    
    return result;
}

@end