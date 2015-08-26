//
//  WJDock.m
//  仿团购
//
//  Created by catch on 15/7/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJDock.h"
#import "WJMoreItem.h"
#import "WJLocationItem.h"
#import "WJtabItem.h"
@interface WJDock()
/**
 *  上一次点击的item
 */
@property (nonatomic, weak)WJtabItem * lastSelectedItem;
@end

@implementation WJDock

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        
        // 设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar"]];
        
        // 添加logo
        [self addLoGoImageView];
        
        // 添加item
        [self addLeftItem];
        
        // 添加定位按钮
        [self addLocationItem];
        
        // 添加更多按钮
        [self addMoreItem];
    }
    return self;
}

#pragma mark - 添加logo
- (void)addLoGoImageView
{
    UIImageView * logoImagView = [[UIImageView alloc] init];
    logoImagView.image = [UIImage imageNamed:@"ic_logo"];
    CGFloat scale = 0.65;
    CGFloat W = logoImagView.image.size.width * scale;
    CGFloat H = logoImagView.image.size.height * scale;
    logoImagView.frame = CGRectMake(0, 0, W, H);
    logoImagView.center = CGPointMake(self.center.x, H * 0.5 + 40);
    [self addSubview:logoImagView];
}

#pragma mark -  添加item
- (void)addLeftItem
{
    // 团购
    [self addtabItmeIcon:@"ic_deal.png" selectedIcon:@"ic_deal_hl.png" index:1];
    // 地图
    [self addtabItmeIcon:@"ic_map.png" selectedIcon:@"ic_map_hl.png" index:2];
    // 搜藏
    [self addtabItmeIcon:@"ic_collect.png" selectedIcon:@"ic_collect_hl.png" index:3];
    // 我的
    [self addtabItmeIcon:@"ic_mine.png" selectedIcon:@"ic_mine_hl.png" index:4];
    
    // 横线
    UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.width * 5, self.frame.size.width, 2)];
    lineImageView.image = [UIImage imageNamed:@"separator_tabbar_item"];
    [self addSubview:lineImageView];
    
}

#pragma mark -  添加定位按钮
- (void)addLocationItem
{
    CGFloat locationItemH = self.bounds.size.width;
    CGFloat locationItemY = self.bounds.size.height - locationItemH * 2;
    WJLocationItem * locationItem = [[WJLocationItem alloc] initWithFrame:CGRectMake(0,locationItemY, locationItemH, locationItemH)];
    [self addSubview:locationItem];
}

#pragma mark -  添加更多按钮
- (void)addMoreItem
{
    CGFloat moreItemH = self.bounds.size.width;
    CGFloat moreItemY = self.bounds.size.height - moreItemH;
    WJMoreItem * moreItem = [[WJMoreItem alloc] initWithFrame:CGRectMake(0, moreItemY, moreItemH, moreItemH)];
    [self addSubview:moreItem];
}

#pragma mark - 添加tabitem

- (void)addtabItmeIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon index:(NSInteger)index
{
    WJtabItem * tabItem = [[WJtabItem alloc] initWithFrame:CGRectMake(0, self.bounds.size.width * index, self.bounds.size.width, self.bounds.size.width)];
    [tabItem setIcon:icon selectedIcon:selectedIcon];
    [tabItem addTarget:self action:@selector(processTabItem:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tabItem];
    tabItem.tag = index - 1;
    
    if (index == 1) {
        [self processTabItem:tabItem];
    }
}

#pragma mark - processTabItem
- (void)processTabItem:(WJtabItem *)sender
{
    if ([self.delegate respondsToSelector:@selector(chooseFrom:to:)]) {
        [self.delegate chooseFrom:self.lastSelectedItem.tag to:sender.tag];
    }
    if (self.lastSelectedItem) {
        self.lastSelectedItem.enabled = YES;
    }
    sender.enabled = NO;
    self.lastSelectedItem = sender;
}
@end
