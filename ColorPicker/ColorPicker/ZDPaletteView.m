//
//  ZDPaletteView.m
//  calendarDemo
//
//  Created by zhangdong on 2017/8/21.
//  Copyright © 2017年 zhangyipeng. All rights reserved.
//

#import "ZDPaletteView.h"
#import "ZDCircleColorView.h"
#import "ZDTriangleView.h"
#define ZDCircleSpacing    35

#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width

#define RGB(A, B, C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]

@interface ZDPaletteView ()

//形环形调色盘 （渐变色）
@property (nonatomic, strong) UIImageView *cicreImageView;

/** 上次的颜色 */
//@property (nonatomic, weak) UIButton *lastColorBtn;
/** 当前使用的颜色 */
@property (nonatomic, weak) UIButton *currnetColorBtn;
@property (nonatomic, strong) ZDTriangleView *triangView;
@property (nonatomic, strong) UIImageView *touchImage;
@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UILabel *colorLabel;

@end
@implementation ZDPaletteView



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        [self addSubview:_testView];
    }

    return self;

}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    

}

- (void)getTriangleViewColor:(NSNotification *)noti {
//    self.lastColorBtn.backgroundColor = [noti.userInfo objectForKey:@"triangleColor"];


}

- (UIImageView *)touchImage
{
    if (!_touchImage) {
        
        _touchImage = [[UIImageView alloc] init];
        _touchImage.frame = CGRectMake(2.5, 2.5, 25, 25);
    }
    return _touchImage;
}


- (UIImageView *)cicreImageView {
    
    if (!_cicreImageView) {
        _cicreImageView = [[UIImageView alloc] init];
        _cicreImageView.contentMode = UIViewContentModeScaleToFill;
        _cicreImageView.backgroundColor = [UIColor whiteColor];
        _cicreImageView.image = [UIImage imageNamed:@"调色盘"];
        _cicreImageView.userInteractionEnabled = YES;
    }

    return _cicreImageView;
}

- (UIView *)testView {
    if (!_testView) {
        _testView = [[UIView alloc] init];
        _testView.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height - 100, 100, 100);
        _testView.layer.cornerRadius = 50;
        _testView.layer.masksToBounds = YES;
    }
    return _testView;

}


- (void)drawRect:(CGRect)rect {
    
    [self drawUpView];
    //圆
    [self drawCircleWithRect:rect];

}


- (void)drawUpView
{
    CGFloat btnW = 65;
    CGFloat btnH = 30;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake((self.frame.size.width - btnW * 2 - 5) / 2, 15, 135, 35));
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, RGB(242, 243, 244).CGColor);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextStrokePath(context);
    
    
    self.currnetColorBtn = [self addButtonWithImage:@"" tag:1];
    self.currnetColorBtn.frame = CGRectMake((self.frame.size.width - btnW * 2) / 2, 17.5, 40, btnH);
    self.currnetColorBtn.backgroundColor = RGB(170, 6, 16);
    
    self.colorLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - btnW * 2) / 2 + 40, 17.5, 135 - 40 - 5, btnH)];
    self.colorLabel.backgroundColor = [UIColor whiteColor];
    self.colorLabel.font = [UIFont systemFontOfSize:15];
    self.colorLabel.textAlignment = NSTextAlignmentCenter;
    self.colorLabel.textColor = [UIColor grayColor];
    [self addSubview:self.colorLabel];
    
    
//    self.closeBtn = [self addButtonWithImage:@"pan_close" tag:2];
//    self.closeBtn.frame = CGRectMake(self.frame.size.width - 45, 10, 40, 40);
}


- (ZDTriangleView *)triangView
{
    if (!_triangView) {
        CGFloat circeWH = self.frame.size.width - ZDCircleSpacing * 2;
        CGFloat circeX = (self.frame.size.width - circeWH - 10) / 2;
        CGFloat circeY = (self.frame.size.height- circeWH - 10) / 2;
        CGFloat circeSpacing = 35;
        _triangView = [[ZDTriangleView alloc] initWithFrame:CGRectMake(circeX + circeSpacing + 5, circeY + circeSpacing, circeWH - circeSpacing * 2, circeWH - circeSpacing * 2)];
        _triangView.layer.cornerRadius = (circeWH - circeSpacing * 2) / 2;
        _triangView.layer.masksToBounds = YES;
        _triangView.backgroundColor = [UIColor whiteColor];
        __weak typeof (self) weakSelf = self;
        _triangView.triangleColorBlock = ^ (UIColor *color) {
            weakSelf.currnetColorBtn.backgroundColor = color;
            weakSelf.colorLabel.text = [weakSelf changeUIColorToRGB:color];
        };
    }
    return _triangView;
}



//画圆

- (void)drawCircleWithRect:(CGRect)rect{

    CGFloat circleH = rect.size.width - ZDCircleSpacing *2;
    
    if (SCREEN_WIDTH == 320) {
        circleH = rect.size.width - 40 *2;
    }
    
    if (SCREEN_WIDTH == 480) {
        circleH = rect.size.width - 50 *2;
    }
    
    CGFloat circleX = (rect.size.width - circleH) / 2;
    CGFloat circleY = (rect.size.height- circleH - 10) / 2;
    
    self.cicreImageView.frame = CGRectMake(circleX, circleY, circleH, circleH);
    [self addSubview:self.cicreImageView];
    
    //滑动轨迹
    ZDCircleColorView *circleView = [[ZDCircleColorView alloc] init];
    circleView.frame = self.cicreImageView.frame;
//    circleView.backgroundColor = [UIColor clearColor];
    circleView.center = kCenter;
    circleView.layer.cornerRadius = circleH / 2;
    circleView.layer.masksToBounds = YES;
    [self addSubview:circleView];
    
    __weak __typeof(self) weakSelf = self;
    
    
    circleView.colorBlock = ^(UIColor *color,CGFloat angle) {
        weakSelf.currnetColorBtn.backgroundColor = color;
        weakSelf.colorLabel.text = [weakSelf changeUIColorToRGB:color];
        weakSelf.triangView.rightColor = color;
        NSLog(@"angle ==== %zd",angle);
//        NSLog(@"weakSelf.colorBlock ===== %@",weakSelf.paletterBlock);
        CGAffineTransform transform = CGAffineTransformMakeRotation(angle * M_PI/180.0);
        [self.triangView setTransform:transform];
//        if (weakSelf.paletterBlock) {
//            weakSelf.paletterBlock(color);
//            weakSelf.triangView.rightColor = color;
//            NSLog(@"========%@-=======",color);
//        }
//    
    };
    [self addSubview:self.triangView];
}


/**
 * 创建Button
 */
- (UIButton *)addButtonWithImage:(NSString *)image  tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(colorButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}


- (void)colorButtonClcik:(UIButton *)sender {

    

}

//RGB
- (NSString *) hexFromUIColor: (UIColor*) color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
return [NSString stringWithFormat:@"#%d%d%d", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

//颜色转字符串
-(NSString *) changeUIColorToRGB:(UIColor *)color{
    
    
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    
    
    NSString *r = [NSString stringWithFormat:@"%@",[self  ToHex:cs[0]*255]];
    NSString *g = [NSString stringWithFormat:@"%@",[self  ToHex:cs[1]*255]];
    NSString *b = [NSString stringWithFormat:@"%@",[self  ToHex:cs[2]*255]];
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
    
    
}


//十进制转十六进制
-(NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}


@end
