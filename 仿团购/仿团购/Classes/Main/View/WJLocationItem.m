//
//  WJLocationItem.m
//  仿团购
//
//  Created by catch on 15/7/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJLocationItem.h"
#import "WJLocationViewController.h"
@interface WJLocationItem ()<UIPopoverControllerDelegate>
@property (nonatomic, strong)UIPopoverController * popVC;
@end

@implementation WJLocationItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setIcon:@"ic_district.png" selectedIcon:@"ic_district_hl.png"];
        
        [self setTitle:@"定位中" forState:UIControlStateNormal];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        // 添加点击事件
        [self addTarget:self action:@selector(processLocation) forControlEvents:UIControlEventTouchUpInside];
        
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLocation:) name:ChangeLocationName object:nil];
    }
    return self;
}

// 设置图片的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.7);
}

// 设置标题的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.bounds.size.height * 0.7, self.bounds.size.width, self.bounds.size.height * 0.3);
}

#pragma mark - processLocation
- (void)processLocation
{
    self.enabled = NO;
    WJLocationViewController * locationVC = [[WJLocationViewController alloc] init];
    self.popVC = [[UIPopoverController alloc] initWithContentViewController:locationVC];
    self.popVC.popoverContentSize = CGSizeMake(320, 580);
    self.popVC.delegate = self;
    [self.popVC presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

#pragma mark - 通知
- (void)changeLocation:(NSNotificationCenter *)info
{
    MyLog(@"info = %@",[info valueForKey:@"object"]);
    [self setTitle:[info valueForKey:@"object"] forState:UIControlStateNormal];
    [self.popVC dismissPopoverAnimated:YES];
    self.enabled = YES;
}

#pragma mark - UIPopoverControllerDelegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.enabled = YES;
    MyLog(@"移除通知");
}
@end
