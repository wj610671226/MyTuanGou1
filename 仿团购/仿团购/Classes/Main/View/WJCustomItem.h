//
//  WJCustomItem.h
//  仿团购
//
//  Created by catch on 15/7/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJCustomItem : UIButton
/**
 *  设置normal状态下的图片  和selected的图片
 */
- (void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon;
@end
