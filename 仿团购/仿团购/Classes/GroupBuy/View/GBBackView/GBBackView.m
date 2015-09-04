//
//  GBBackView.m
//  仿团购
//
//  Created by catch on 15/9/4.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBBackView.h"
#define Alpha 0.7
@implementation GBBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 背景颜色
        self.backgroundColor = [UIColor blackColor];
        
        // 自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        
        // 透明度
        self.alpha = Alpha;
        
    }
    return self;
}

/**
 *  创建蒙板
 */
+ (instancetype)backView
{
    return [[self alloc] init];
}

/**
 *  创建蒙板并添加手势
 */
+ (instancetype)backViewWithTarget:(id)targrt action:(SEL)action
{
    GBBackView * backView = [GBBackView backView];
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:targrt action:action]];
    return backView;
}

/**
 *  恢复backView的alpha值
 */
- (void)cancelAlpha
{
    self.alpha = Alpha;
}
@end
