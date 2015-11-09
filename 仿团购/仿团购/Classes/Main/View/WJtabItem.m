//
//  WJtabItem.m
//  仿团购
//
//  Created by catch on 15/7/27.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJtabItem.h"

@implementation WJtabItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item"] forState:UIControlStateDisabled];
    }
    return self;
}

@end
