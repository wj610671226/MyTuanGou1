//
//  WJMineViewController.m
//  仿团购
//
//  Created by catch on 15/7/27.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJMineViewController.h"

@interface WJMineViewController ()

@end

@implementation WJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    UIBarButtonItem * quitItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = quitItem;
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
