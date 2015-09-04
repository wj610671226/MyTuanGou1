//
//  GBBottomSubViews.m
//  仿团购
//
//  Created by catch on 15/8/16.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBBottomSubViews.h"
#import "ShareMetaDataTool.h"
#import "UIImage+resizableImage.h"
#define BtnW 130
#define BtnH 50

@interface GBBottomSubViews()
/**
 *  记录上次subViews的高度
 */
@property (nonatomic, assign)CGFloat lastHight;
/**
 *  当前subViews的高度
 */
@property (nonatomic, assign)CGFloat currentHight;
/**
 *  记录上一次点击的按钮
 */
@property (nonatomic, weak)UIButton * lastButton;

/**
 *  子标题数组
 */
@property (nonatomic, strong)NSMutableArray * titleArray;
@end

@implementation GBBottomSubViews

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.image = [UIImage resizableImageName:@"bg_subfilter_other.png"];
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        
        self.titleArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setTitle:(NSArray *)title
{
    _title = title;
    
    // 添加全部
    [self.titleArray removeAllObjects];
    [self.titleArray addObject:@"全部"];
    [self.titleArray addObjectsFromArray:title];
    
    // 创建子按钮
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIButton * btn = nil;
        if (i < self.subviews.count) {
            // 把按钮添加进视图
            btn = self.subviews[i];
        } else {
            // 创建按钮
            btn = [[UIButton alloc] init];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(processSubViewsBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage resizableImageName:@"slider_filter_bg_active.png"] forState:UIControlStateSelected];
            [self addSubview:btn];
        }
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        btn.hidden = NO;
        
        if ([self.delegate respondsToSelector:@selector(bottomSubViewsWithBtnTitle:)]) {
            if ([btn.titleLabel.text isEqualToString:[self.delegate getBottomSubViewsWithBtnTitle]]) {
                btn.selected = YES;
                self.lastButton.selected = NO;
                self.lastButton = btn;
            } else {
                if ([btn.titleLabel.text isEqualToString:@"全部"] && i == 0) {
                    btn.selected = YES;
                    self.lastButton = btn;
                } else {
                    btn.selected = NO;
                }
            }
        }
    }
    
    // 隐藏多余的按钮
    for (int i =  self.titleArray.count; i < self.subviews.count; i ++) {
        ((UIButton *)self.subviews[i]).hidden = YES;
    }
    
    // 重新调整子视图的位置
    [self adjustmentSubViewsLocation];
}

- (void)layoutSubviews
{
//    MyLog(@"layoutSubviews------------");
    [super layoutSubviews];
    // 重新调整子视图的位置
    [self adjustmentSubViewsLocation];
}

#pragma mark - 调整子视图的位置
- (void)adjustmentSubViewsLocation
{
    int row = self.frame.size.width / BtnW;
    // 调整按钮在视图中的位置
    for (int i = 0; i < self.subviews.count; i ++) {
        int x = i % row * BtnW;
        int y = i / row * BtnH;
        ((UIButton *)self.subviews[i]).frame = CGRectMake(x, y, BtnW, BtnH);
    }
    CGFloat subViewH = 0;
    if (self.titleArray.count % row == 0) {
        subViewH = self.titleArray.count / row * BtnH;
    } else {
        subViewH = (self.titleArray.count / row + 1) * BtnH;
    }
    self.frame = CGRectMake(0, BottomItemH, self.frame.size.width, subViewH);
    self.currentHight = subViewH;
}

#pragma mark - 显示subViews动画
- (void)showSubViews
{
    if (self.lastHight != 0) {
        self.frame = CGRectMake(0, BottomItemH, self.frame.size.width, self.lastHight);
    } else {
        self.frame = CGRectMake(0, BottomItemH, self.frame.size.width, 0);
    }
    [UIView animateWithDuration:myAnimationDuration animations:^{
        self.frame = CGRectMake(0, BottomItemH, self.frame.size.width, self.currentHight);
    } completion:^(BOOL finished) {
        self.lastHight = self.currentHight;
    }];
}

#pragma mark - processSubViewsBtn
- (void)processSubViewsBtn:(UIButton *)sender
{
    sender.selected = YES;
    if (self.lastButton) {
        self.lastButton.selected = NO;
    }
    self.lastButton = sender;
//    MyLog(@"title = %@",sender.titleLabel.text);
    
    // 记录当前点击的按钮
    if ([self.delegate respondsToSelector:@selector(bottomSubViewsWithBtnTitle:)]) {
        [self.delegate bottomSubViewsWithBtnTitle:sender.titleLabel.text];
    }
    
    // 点击按钮后topItem改变标题 隐藏视图
}
@end
