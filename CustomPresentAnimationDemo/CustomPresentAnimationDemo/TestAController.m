//
//  TestAController.m
//  CustomPresentAnimationDemo
//
//  Created by goviewtech on 2019/1/21.
//  Copyright © 2019 goviewtech. All rights reserved.
//

#import "TestAController.h"
#import "UIViewController+PresentAnimation.h"

@interface TestAController ()

@end

@implementation TestAController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"第二个页面";
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickDismissAction)];
    
    
}

- (void)clickDismissAction
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)dealloc
{
    [self removePresentAnimator];
    
}
    
@end
