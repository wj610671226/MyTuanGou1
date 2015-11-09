//
//  WJCustomItem.m
//  仿团购
//
//  Created by catch on 15/7/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJCustomItem.h"

@implementation WJCustomItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 顶部的线
        UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
        lineImageView.image = [UIImage imageNamed:@"separator_tabbar_item"];
        [self addSubview:lineImageView];
        
    }
    return self;
}

- (void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon
{
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
}
@end
