//
//  ZDCircleColorView.m
//  calendarDemo
//
//  Created by zhangdong on 2017/8/21.
//  Copyright © 2017年 zhangyipeng. All rights reserved.
//

#import "ZDCircleColorView.h"


#define MYCENTER CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)

#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface ZDCircleColorView ()

@property (nonatomic, assign, getter=isOn) BOOL On;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic ,assign) CGFloat angle;
@property (nonatomic, strong) UIView *circleView;
@end

@implementation ZDCircleColorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.circleView = []
    }
    return self;
}

//触摸

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [super touchesBegan:touches withEvent:event];
    
    CGPoint currentPoint = [touches.anyObject locationInView:self];
    CGRect rect = CGRectMake(self.centerPoint.x - 10, self.centerPoint.y - 10, 20, 20);
    
    self.On = CGRectContainsPoint(rect, currentPoint);
    
}

//滑动手势 （触摸结束）
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
   
    self.point = [touches.anyObject locationInView:self];
    
    [self setNeedsDisplay]; //异步自动调用drawRect方法
    
}

- (void)drawRect:(CGRect)rect {
    
    self.centerPoint = relative(kCenter, kRadius, 0);
    if (!CGPointEqualToPoint(self.point, CGPointZero)) {
//        atan 和 atan2 区别：
//        1、参数的填写方式不同；
//        2、atan2 的优点在于 如果 参数等于0 依然可以计算，但是atan函数就会导致程序出错
        self.angle = atan2(self.point.y - kCenter.y, self.point.x - kCenter.x);
        
        self.centerPoint = relative(kCenter, kRadius * cos(_angle), kRadius * sin(_angle));
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:10 startAngle:DEGREES_TO_RADIANS(360) endAngle:2 *M_PI clockwise:YES];

    [[UIColor whiteColor] setFill];
    [bezierPath fill];
    [bezierPath stroke];
    
    if (self.colorBlock) {
        //根据给定的 色调hue 饱和度saturation 亮度brightness来生成颜色。
        self.colorBlock([UIColor colorWithHue:(-self.angle / M_PI * 0.5 + 0.5) saturation:1 brightness:1 alpha:1],self.angle *180/M_PI);
        NSLog(@"angle ===%f", _angle * 180 / M_PI);
//        NSLog(@"%@====",NSStringFromCGPoint(self.centerPoint));
    }
    
}


CGPoint relative(CGPoint point, CGFloat x, CGFloat y){
    return CGPointMake(point.x + x, point.y + y);
}


@end
