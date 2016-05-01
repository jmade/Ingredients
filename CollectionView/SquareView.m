//
//  SquareView.m
//  CollectionView
//
//  Created by Justin Madewell on 2/3/14.
//  Copyright (c) 2014 Justin Madewell. All rights reserved.
//

#import "SquareView.h"

@implementation SquareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
           }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* gradientColor = [UIColor colorWithRed: 0.055 green: 0.055 blue: 0.563 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor whiteColor].CGColor,
                               (id)[UIColor colorWithRed: 0.528 green: 0.528 blue: 0.782 alpha: 1].CGColor,
                               (id)gradientColor.CGColor, nil];
    CGFloat gradientLocations[] = {0, 0.42, 0.93};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(-2.1, -2.1);
    CGFloat shadowBlurRadius = 6.5;
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(110, 110, 100, 100) cornerRadius: 5];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(160, 210), CGPointMake(160, 110), 0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    
    [[UIColor blackColor] setStroke];
    roundedRectanglePath.lineWidth = 1;
    [roundedRectanglePath stroke];
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}


//// Drawing code
//// Random Color
//CGFloat redValue = (arc4random() % 255) / 255.0f;
//CGFloat blueValue = (arc4random() % 255) / 255.0f;
//CGFloat greenValue = (arc4random() % 255) / 255.0f;
//UIColor *randomColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0f];
//// End Random Color
//
//self.backgroundColor = [UIColor clearColor];
//self.layer.cornerRadius = 5.0;
//self.layer.shadowOpacity = 0.9f;
//self.layer.shadowColor = [[UIColor blackColor] CGColor];
//self.layer.shadowOffset = CGSizeMake(1.0, 2.0);
//self.layer.masksToBounds = NO;
////self.layer.shouldRasterize = YES;
////self.layer.shadowRadius = 1.0;
//
////Make View
//self.contentView = [[UIView alloc]initWithFrame:self.frame];
//self.contentView.backgroundColor = randomColor;
//self.contentView.layer.cornerRadius = 5.0;
//self.contentView.layer.masksToBounds = YES;
//
////    [self addSubview:self.contentView];
////    [self sendSubviewToBack:self.contentView];


@end
