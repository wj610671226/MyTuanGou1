//
//  WJMoreItem.m
//  仿团购
//
//  Created by catch on 15/7/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJMoreItem.h"
#import "WJMoreViewController.h"
#import "WJNavigationController.h"
@implementation WJMoreItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        // 设置图片
        [self setIcon:@"ic_more.png" selectedIcon:@"ic_more_hl.png"];
        
        [self addTarget:self action:@selector(processMoreItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - processMoreItem
- (void)processMoreItem
{
    self.enabled = NO;
    WJMoreViewController * moreVC = [[WJMoreViewController alloc] init];
    WJNavigationController * navc = [[WJNavigationController alloc] initWithRootViewController:moreVC];
    moreVC.moreItem = self;
    navc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.window.rootViewController presentViewController:navc animated:YES completion:nil];
}

@end
