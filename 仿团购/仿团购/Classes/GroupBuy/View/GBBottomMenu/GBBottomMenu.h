//
//  DownMenu.h
//  仿团购
//
//  Created by catch on 15/8/10.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GBBottomItem;
typedef void(^HiddenBlock)();
// 父类
@interface GBBottomMenu : UIView
/**
 *  scrollView
 */
@property (nonatomic, weak) UIScrollView * scrollView;

/**
 *  上一次点击的ButtomItem
 */
@property (nonatomic, weak) GBBottomItem * lastBottomItem;

/**
 *  显示bottomMenu
 */
- (void)showBottomMenu;

/**
 *  隐藏hiddenSubViews
 */
- (void)hiddenSubViews;

/**
 *  隐藏bottomMenu
 */
- (void)hiddenBottomMenu;

/**
 *  隐藏
 */
@property (nonatomic, copy)HiddenBlock hiddenBlock;
@end
