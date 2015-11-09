//
//  WJNavigationController.m
//  仿团购
//
//  Created by catch on 15/7/28.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJNavigationController.h"

@interface WJNavigationController ()

@end

@implementation WJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * navcItem = [UIBarButtonItem appearance];
    [navcItem setBackgroundImage:[UIImage imageNamed:@"bg_navigation_right"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [navcItem setBackgroundImage:[UIImage imageNamed:@"bg_navigation_right_hl"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [navcItem setTintColor:[UIColor darkGrayColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
