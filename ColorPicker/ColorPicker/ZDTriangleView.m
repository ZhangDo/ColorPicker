//
//  ZDTriangleView.m
//  calendarDemo
//
//  Created by zhangdong on 2017/8/22.
//  Copyright © 2017年 zhangyipeng. All rights reserved.
//

#import "ZDTriangleView.h"
#import "UIImage+ZDColorAtPixel.h"

#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define MYCENTER CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)


@interface ZDTriangleView ()
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, weak) UIImage *colorImage;
@property (nonatomic, assign) CGMutablePathRef path;
@end

@implementation ZDTriangleView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    
    return self;
    
}

- (UIImageView *)centerImageView {
    
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 20) / 2, (SCREEN_WIDTH - 20) / 2, 20, 20)];
        _centerImageView.backgroundColor = [UIColor whiteColor];
    }
    
    return _centerImageView;

}



-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //创建CGContextRef
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    self.path = path;
    
    NSLog(@"===%@===",NSStringFromCGRect(rect));
    
    //绘制Path
    CGPathMoveToPoint(path, NULL, rect.size.width, rect.size.height / 2);
    CGFloat triangleMagin = 0;
    if (SCREEN_HEIGHT == 568) {
        triangleMagin = 10;
    } else if (SCREEN_HEIGHT == 667){
        triangleMagin = 11;
    } else if (SCREEN_HEIGHT == 736){
        triangleMagin = 13;
    } else if (SCREEN_HEIGHT == 480){
        triangleMagin = 8;
    }
    
    CGPathAddLineToPoint(path, NULL, rect.size.width / 4 * 1, triangleMagin);
    CGPathAddLineToPoint(path, NULL, rect.size.width / 4 * 1, rect.size.height - triangleMagin);
    CGPathCloseSubpath(path);
    
    //绘制渐变 (leftTop\leftop\rightCenter)
    [self drawLinearGradient:gc path:path leftTop:[UIColor whiteColor].CGColor leftBottom:[UIColor blackColor].CGColor rightCenter:self.rightColor.CGColor];
    
    //注意释放CGMutablePathRef
    //    CGPathRelease(path);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    self.colorImage = img;
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self addSubview:imgView];
    
}


#pragma mark - 绘制渐变
-(void)drawLinearGradient:(CGContextRef)context
                     path:(CGPathRef) path
                  leftTop:(CGColorRef)leftTopColor
               leftBottom:(CGColorRef)leftBottomColor
              rightCenter:(CGColorRef)rightCenterColor
{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 1.0,0.5};
    
    if (!rightCenterColor) {
        rightCenterColor = [UIColor redColor].CGColor;
    }
    
    NSArray *colors = @[(__bridge id) leftTopColor, (__bridge id) leftBottomColor,(__bridge id) rightCenterColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    
//    具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    self.userInteractionEnabled = YES;
    [self addSubview:self.centerImageView];

    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    if (!CGPathContainsPoint(self.path, NULL, currentPoint, NO)) {
        self.userInteractionEnabled = NO;
    } else {
        self.centerImageView.center = currentPoint;
        UIColor *color = [self.colorImage colorAtPixel:currentPoint];
        if (self.triangleColorBlock) {
            self.triangleColorBlock(color);
        }
    }
    self.userInteractionEnabled = YES;

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    if (!CGPathContainsPoint(self.path, NULL, currentPoint, NO)) {
        self.userInteractionEnabled = NO;
    } else {
        self.centerImageView.center =  currentPoint;
        UIColor *color = [self.colorImage colorAtPixel:currentPoint]; //[self getPixelColorAtLocation:currentPoint];
        if (self.triangleColorBlock) {
            self.triangleColorBlock(color);
        }
    }
    self.userInteractionEnabled = YES;
}


-(void)setRightColor:(UIColor *)rightColor
{
    _rightColor = rightColor;
    [self setNeedsDisplay];
}

-(UIColor *)rightColor
{
    return _rightColor;
}


-(void)dealloc
{
    CGPathRelease(self.path);
}



@end
