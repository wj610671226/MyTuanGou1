//
//  leftTopItem.m
//  仿团购
//
//  Created by catch on 15/8/8.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBLeftTopItem.h"
#define KScale 0.7
@implementation GBLeftTopItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        // 图片
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        // 右边线
        UIImageView * rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftItemW, 0, 2, LeftItemH * 0.7)];
        rightImageView.image = [UIImage imageNamed:@"separator_filter_item"];
        rightImageView.center = CGPointMake(LeftItemW, LeftItemH / 2);
        [self addSubview:rightImageView];
        
        // 选中时候的背景
        [self setBackgroundImage:[UIImage imageNamed:@"slider_filter_bg_normal.png"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width * KScale, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * KScale, 0, contentRect.size.width * (1 - KScale), contentRect.size.height);
}
@end
