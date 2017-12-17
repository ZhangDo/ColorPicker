//
//  ZDPaletteView.h
//  calendarDemo
//
//  Created by zhangdong on 2017/8/21.
//  Copyright © 2017年 zhangyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//调色盘

@interface ZDPaletteView : UIView

@property (nonatomic, copy) void (^paletterBlock) (UIColor *);

@property (nonatomic, assign) UIView *bgView;
@end
