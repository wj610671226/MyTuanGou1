//
//  GBBackView.h
//  仿团购
//
//  Created by catch on 15/9/4.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBBackView : UIView
/**
 *  创建蒙板
 */
+ (instancetype)backView;

/**
 *  创建蒙板并添加手势
 */
+ (instancetype)backViewWithTarget:(id)targrt action:(SEL)action;

/**
 *  恢复backView的alpha值
 */
- (void)cancelAlpha;
@end
