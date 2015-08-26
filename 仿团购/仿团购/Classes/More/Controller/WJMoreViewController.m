//
//  WJMoreViewController.m
//  仿团购
//
//  Created by catch on 15/7/28.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJMoreViewController.h"

@interface WJMoreViewController ()

@end

@implementation WJMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(processLeftItme)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"意见反馈" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - processLeftItme
- (void)processLeftItme
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        self.moreItem.enabled = YES;
    }];
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
