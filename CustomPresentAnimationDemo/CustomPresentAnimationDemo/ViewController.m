//
//  ViewController.m
//  CustomPresentAnimationDemo
//
//  Created by goviewtech on 2019/1/21.
//  Copyright © 2019 goviewtech. All rights reserved.
//

#import "ViewController.h"
#import "TestAController.h"
#import "UIViewController+PresentAnimation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"第一页面";
    
    CGFloat buttonW = 200;
    CGFloat buttonH = 55;
    CGFloat buttonX = (self.view.bounds.size.width-buttonW)*0.5;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, 200, buttonW, buttonH)];
    [button setTitle:@"点击跳转" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor greenColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.titleLabel.adjustsFontSizeToFitWidth = true;
    [button addTarget:self action:@selector(clickButtonToPresent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)clickButtonToPresent
{
    TestAController *testA = [[TestAController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:testA];
    [self bd_presentViewController:navc animated:YES completion:nil];
    
}


@end
