//
//  GBBottomSubViews.h
//  仿团购
//
//  Created by catch on 15/8/16.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GBBottomSubViewsDelegate <NSObject>

@optional
/**
 *  传递点击btn的标题
 */
- (void)bottomSubViewsWithBtnTitle:(NSString *)title;

/**
 *  返回按钮的标题
 */
- (NSString *)getBottomSubViewsWithBtnTitle;
@end

@interface GBBottomSubViews : UIImageView
/**
 *  需要显示的子标题数组
 */
@property (nonatomic, strong)NSArray * title;

/**
 *  subViews代理
 */
@property (nonatomic, assign)id<GBBottomSubViewsDelegate> delegate;
- (void)showSubViews;
@end
