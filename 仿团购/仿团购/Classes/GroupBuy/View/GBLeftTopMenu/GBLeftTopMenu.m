//
//  leftTopMenu.m
//  仿团购
//
//  Created by catch on 15/8/8.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBLeftTopMenu.h"
#import "GBLeftTopItem.h"
#import "GBCategoryMenu.h"
#import "GBDistristMenu.h"
#import "GBSequenceMenu.h"
#import "GBBottomMenu.h"
#import "ShareMetaDataTool.h"
@interface GBLeftTopMenu ()
/**
 *  记录上次点击的topItem
 */
@property (nonatomic, weak) GBLeftTopItem * lastTopItem;
/**
 *  全部分类
 */
@property (nonatomic, strong)GBCategoryMenu * categoryMenu;
/**
 *  全部商区
 */
@property (nonatomic, strong)GBDistristMenu * distristMenu;
/**
 *  默认排序
 */
@property (nonatomic, strong)GBSequenceMenu * sequenceMenu;
@property (nonatomic, weak)GBBottomMenu * bottomMenu;

@end

@implementation GBLeftTopMenu

- (instancetype)init
{
    if (self = [super init]) {
        // 全部分类
        [self addLeftItemTitle:@"全部分类" index:0];
        // 全部商区
        [self addLeftItemTitle:@"全部商区" index:1];
        // 默认排序
        [self addLeftItemTitle:@"默认排序" index:2];
        
        // 添加监听者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processChangeTitle:) name:subViewsCategroyNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processChangeTitle:) name:subViewsDistrisNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processChangeTitle:) name:subViewsSequenceNotification object:nil];
    }
    return self;
}

#pragma mark - 添加item
- (void)addLeftItemTitle:(NSString *)title index:(int)index
{
    GBLeftTopItem * topItem = [[GBLeftTopItem alloc] initWithFrame:CGRectMake(LeftItemW * index, 0, LeftItemW, LeftItemH)];
    topItem.title = title;
    topItem.tag = index;
    [topItem addTarget:self action:@selector(processTopItem:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:topItem];
}

#pragma mark - processTopItem
- (void)processTopItem:(GBLeftTopItem *)sender
{
    if ([sender isEqual:self.lastTopItem]) {
        sender.selected = !self.lastTopItem.selected;
        self.lastTopItem = nil;
        
        // 隐藏底部菜单
        [self hidden];
    } else {
        self.lastTopItem.selected = !self.lastTopItem.selected;
        sender.selected = YES;
        self.lastTopItem = sender;
        
        // 显示底部菜单
        [self show:sender];
    }
}

#pragma mark - 显示底部菜单
- (void)show:(GBLeftTopItem *)sender
{
   
    [self.bottomMenu removeFromSuperview];
    // 显示底部菜单
    if (sender.tag == 0) {
        // 全部分类
        if (!self.categoryMenu) {
            self.categoryMenu = [[GBCategoryMenu alloc] initWithFrame:self.contentView.frame];
        }
        self.bottomMenu = self.categoryMenu;
    } else if (sender.tag == 1) {
        // 全部商区
        if (!self.distristMenu) {
            self.distristMenu = [[GBDistristMenu alloc] initWithFrame:self.contentView.frame];
        }
        self.bottomMenu = self.distristMenu;
    } else {
        // 默认排序
        if (!self.sequenceMenu) {
            self.sequenceMenu = [[GBSequenceMenu alloc] initWithFrame:self.contentView.frame];
        }
        self.bottomMenu = self.sequenceMenu;
    }
    [self.contentView addSubview:self.bottomMenu];
    
    self.bottomMenu.hiddenBlock = ^{
        self.lastTopItem.selected = !self.lastTopItem.selected;
        self.lastTopItem = nil;
    };
    // 动画
    [self.bottomMenu showBottomMenu];
}

#pragma mark - 隐藏底部菜单
- (void)hidden
{
    [self.bottomMenu hiddenBottomMenu];
    self.bottomMenu = nil;
}

- (void)setFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, LeftItemW * 3, LeftItemH);
    [super setFrame:frame];
}

#pragma mark - processChangeTitle
- (void)processChangeTitle:(NSNotification *)info
{
    // 全部分类
    if ([ShareMetaDataTool shareMetaDataTool].subViewsCategroy) {
        [((GBLeftTopItem *)self.subviews.firstObject) setTitle:[ShareMetaDataTool shareMetaDataTool].subViewsCategroy forState:UIControlStateNormal];
    }
    // 全部商区
    if ([ShareMetaDataTool shareMetaDataTool].subViewsDistrist) {
        [((GBLeftTopItem *)self.subviews[1]) setTitle:[ShareMetaDataTool shareMetaDataTool].subViewsDistrist forState:UIControlStateNormal];
    }
    // 默认排序
    if ([ShareMetaDataTool shareMetaDataTool].subViewsSequence) {
        [((GBLeftTopItem *)self.subviews.lastObject) setTitle:[ShareMetaDataTool shareMetaDataTool].subViewsSequence forState:UIControlStateNormal];
    }
    
    // 隐藏子菜单
    [self hidden];
}
@end
