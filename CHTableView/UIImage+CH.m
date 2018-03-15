//
//  UIImage+CH.m
//  CHTableView
//
//  Created by PFZC on 2018/3/8.
//  Copyright © 2018年 PFZC. All rights reserved.
//

#import "UIImage+CH.h"

@implementation UIImage (CH)
+(UIImage*)imageWithColor:(UIColor*) color{
    UIImage *image = [UIImage createImageWithColor:color];
    return image;
}
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
