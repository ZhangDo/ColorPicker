//
//  ZDCircleColorView.h
//  calendarDemo
//
//  Created by zhangdong on 2017/8/21.
//  Copyright © 2017年 zhangyipeng. All rights reserved.
//



//取色标识圆圈

#import <UIKit/UIKit.h>
#define kCenter CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5 - 3)
#define kRadius (self.bounds.size.width * 0.5 - 10)
@interface ZDCircleColorView : UIView

@property (nonatomic, copy) void (^colorBlock)(UIColor *, CGFloat);
@end
