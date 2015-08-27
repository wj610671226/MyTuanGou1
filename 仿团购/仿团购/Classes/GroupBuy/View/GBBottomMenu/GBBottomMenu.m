//
//  DownMenu.m
//  仿团购
//
//  Created by catch on 15/8/10.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBBottomMenu.h"
#import "GBBottomItem.h"
#import "GBBottomSubViews.h"
#import "ShareMetaDataTool.h"
#define Alpha 0.7

#import "GBDistristItem.h"
#import "GBSequenceItem.h"
#import "GBCategoryItem.h"
@interface GBBottomMenu ()<GBBottomSubViewsDelegate>
/**
 *  蒙板
 */
@property (nonatomic, weak)UIView * backView;
/**
 *  上一次点击的ButtomItem
 */
@property (nonatomic, weak) GBBottomItem * lastBottomItem;
@property (nonatomic, weak)GBBottomSubViews * bottomSubViews;

/**
 *  包裹ScorllView 和 bottomSubViews 的视图
 */
@property (nonatomic, weak)UIView * contentView;

@end

@implementation GBBottomMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        // 蒙板
        UIView * backView = [[UIView alloc] init];
        backView.frame = self.bounds;
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = Alpha;
        backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBottomMenu)]];
        self.backView = backView;
        [self addSubview:backView];
        
        // 添加contentView
        UIView * contentView = [[UIView alloc] init];
        contentView.frame = CGRectMake(0, 0, self.frame.size.width, BottomItemH);
        contentView.backgroundColor = [UIColor clearColor];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.contentView = contentView;
        [self addSubview:contentView];
        
        // 添加ScrollView
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BottomItemH)];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsHorizontalScrollIndicator = NO;
//        scrollView.bounces = NO;
        self.scrollView = scrollView;
        [self.contentView addSubview:scrollView];
    }
    return self;
}


#pragma mark - 显示bottomMenu
- (void)showBottomMenu
{
    if (self.contentView == nil) {
        self.backView.alpha = 0;
        [UIView animateWithDuration:myAnimationDuration animations:^{
            _contentView.transform = CGAffineTransformMakeTranslation(0, _contentView.frame.size.height);
            self.backView.alpha = Alpha;
        }];
    } else {
        [UIView animateWithDuration:myAnimationDuration animations:^{
            _contentView.transform = CGAffineTransformMakeTranslation(0, BottomItemH);
            self.backView.alpha = Alpha;
        }];
    }
}

#pragma mark - 隐藏bottomMenu
- (void)hiddenBottomMenu
{
    if (self.hiddenBlock) {
        self.hiddenBlock();
    }
    [UIView animateWithDuration:myAnimationDuration animations:^{
        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - processItem
- (void)processItem:(GBBottomItem *)sender
{
    sender.selected = YES;
    if (self.lastBottomItem) {
        self.lastBottomItem.selected = NO;
    }
    self.lastBottomItem = sender;
    
    // 判断有没有子菜单  有 --> 创建
    if (sender.title.count > 0) {
        // 创建子视图
        if (!self.bottomSubViews) {
            GBBottomSubViews * bottomSubViews = [[GBBottomSubViews alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
            self.bottomSubViews = bottomSubViews;
            bottomSubViews.delegate = self;
            [_contentView insertSubview:bottomSubViews belowSubview:_scrollView];
        }
        self.bottomSubViews.title = sender.title;
        _contentView.frame = CGRectMake(0, BottomItemH, self.frame.size.width, BottomItemH + self.bottomSubViews.frame.size.height);
        [self.bottomSubViews showSubViews];
        
    } else {
        // 隐藏子菜单视图
//        [UIView animateWithDuration:animationDuration animations:^{
//            self.bottomSubViews.transform = CGAffineTransformMakeTranslation(0,-self.bottomSubViews.frame.size.height);
//        } completion:^(BOOL finished) {
//            _contentView.frame = CGRectMake(0, BottomItemH, self.frame.size.width, _scrollView.frame.size.height);
//            [self.bottomSubViews removeFromSuperview];
//        }];
        
        
        // 设置数据
        if ([sender isKindOfClass:[GBSequenceItem class]]) {
            [ShareMetaDataTool shareMetaDataTool].subViewsSequence = [[ShareMetaDataTool shareMetaDataTool] getSequenceModelWithName:sender.titleLabel.text];
        } else if ([sender isKindOfClass:[GBCategoryItem class]]) {
            [ShareMetaDataTool shareMetaDataTool].subViewsCategroy = sender.titleLabel.text;
        } else {
            [ShareMetaDataTool shareMetaDataTool].subViewsDistrist = sender.titleLabel.text;
        }
        
        // 控制letTopitem
        if (self.hiddenBlock) {
            self.hiddenBlock();
        }
        [UIView animateWithDuration:myAnimationDuration animations:^{
            _contentView.transform = CGAffineTransformMakeTranslation(0,-_contentView.frame.size.height);
            self.backView.alpha = 0;
        } completion:^(BOOL finished) {
//            _contentView.frame = CGRectMake(0, BottomItemH, self.frame.size.width, _scrollView.frame.size.height);
            [self.bottomSubViews removeFromSuperview];
        }];
    }
}
@end
