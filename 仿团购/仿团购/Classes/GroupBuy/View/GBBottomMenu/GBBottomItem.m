//
//  GBBottomItem.m
//  仿团购
//
//  Created by catch on 15/8/12.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBBottomItem.h"

@implementation GBBottomItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 右边的竖线
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(BottomItemW - 2, 0, 2, BottomItemH)];
        imageView.image = [UIImage imageNamed:@"separator_filter_item"];
        [self addSubview:imageView];
        
        // 选中时候的图片
        [self setBackgroundImage:[UIImage imageNamed:@"bg_filter_toggle_hl.png"] forState:UIControlStateSelected];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(BottomItemW, BottomItemH);
    [super setFrame:frame];
}

- (NSArray *)title
{
    return nil;
}
@end
