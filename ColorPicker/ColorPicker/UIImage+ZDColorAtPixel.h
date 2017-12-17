//
//  UIImage+ZDColorAtPixel.h
//  calendarDemo
//
//  Created by zhangdong on 2017/8/22.
//  Copyright © 2017年 zhangyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZDColorAtPixel)

- (UIColor *)colorAtPixel:(CGPoint)point;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;



+ (instancetype)imageWithCaptureView:(UIView *)view;
@end
