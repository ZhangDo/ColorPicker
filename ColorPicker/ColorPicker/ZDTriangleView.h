//
//  ZDTriangleView.h
//  calendarDemo
//
//  Created by zhangdong on 2017/8/22.
//  Copyright © 2017年 zhangyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDTriangleView : UIView
{
    UIColor *_rightColor;
    
}
@property (nonatomic, strong) UIColor *rightColor;

@property (nonatomic, copy) void (^triangleColorBlock)(UIColor *color);
@end
