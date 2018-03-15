//
//  UIImage+CH.h
//  CHTableView
//
//  Created by PFZC on 2018/3/8.
//  Copyright © 2018年 PFZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CH)
/**
 将颜色转化成图片
 
 @param color 需要转化成图片的颜色
 
 @return UIImage
 */
+(UIImage*)imageWithColor:(UIColor*) color;
@end
