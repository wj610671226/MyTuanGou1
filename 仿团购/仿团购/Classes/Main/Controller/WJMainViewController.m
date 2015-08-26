//
//  WJMainViewController.m
//  仿团购
//
//  Created by catch on 15/7/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJMainViewController.h"
#import "WJDock.h"
#import "WJGroupViewController.h"
#import "WJMapViewController.h"
#import "WJCollectViewController.h"
#import "WJMineViewController.h"
#import "WJNavigationController.h"
@interface WJMainViewController ()<wjDockDelegate>
@property (nonatomic, strong)UIView * backView;
@end

@implementation WJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化dock
    WJDock * dock = [[WJDock alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.height)];
    dock.delegate = self;
    [self.view addSubview:dock];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dock.frame), CGRectGetMinY(dock.frame), self.view.frame.size.width - CGRectGetWidth(dock.frame), self.view.frame.size.height)];
    self.backView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backView];
    
    // 添加子控制器
    [self addAllChildController];
}

#pragma mark - 初始化子控制器
- (void)addAllChildController
{
    // 团购
    WJGroupViewController * groupVC = [[WJGroupViewController alloc] init];
    WJNavigationController * groupNavc = [[WJNavigationController alloc] initWithRootViewController:groupVC];
    [self addChildViewController:groupNavc];
    
    // 地图
    WJMapViewController * mapVC = [[WJMapViewController alloc] init];
    mapVC.view.backgroundColor = [UIColor blackColor];
    WJNavigationController * mapNavc = [[WJNavigationController alloc] initWithRootViewController:mapVC];
    [self addChildViewController:mapNavc];

    // 收藏
    WJCollectViewController * collectVC = [[WJCollectViewController alloc] init];
    collectVC.view.backgroundColor = [UIColor greenColor];
    WJNavigationController * collectNavc = [[WJNavigationController alloc] initWithRootViewController:collectVC];
    [self addChildViewController:collectNavc];
    
    // 我的
    WJMineViewController * mineVC = [[WJMineViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor purpleColor];
    WJNavigationController * mineNavc = [[WJNavigationController alloc] initWithRootViewController:mineVC];
    [self addChildViewController:mineNavc];
    
    // 设置默认点击
    [self chooseFrom:0 to:0];
}

#pragma mark - wjDockDelegate
- (void)chooseFrom:(NSInteger)from to:(NSInteger)to
{
    MyLog(@"%ld - %ld",(long)from,(long)to);
    // 移除旧的视图
    UIViewController * oldVC = self.childViewControllers[from];
    [oldVC.view removeFromSuperview];
    
    // 加入新的视图
    UIViewController * newVC = self.childViewControllers[to];
    newVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    newVC.view.frame = self.backView.bounds;
    [self.backView addSubview:newVC.view];
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
