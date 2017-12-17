//
//  ViewController.m
//  ColorPicker
//
//  Created by Walker on 2017/12/16.
//  Copyright © 2017年 Walker. All rights reserved.
//

#import "ViewController.h"
#import "ZDPaletteView.h"
#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"取色";
    
    
    CGRect rect;
    rect = CGRectMake(0, 64, SCREEN_WIDTH , SCREEN_HEIGHT - 64);
    
    
    ZDPaletteView *circleView = [[ZDPaletteView alloc] init];
    
    circleView.frame = rect;
    
    circleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:circleView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
