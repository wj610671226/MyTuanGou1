//
//  GBCategoryMenu.m
//  仿团购
//
//  Created by catch on 15/8/10.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBCategoryMenu.h"
#import "ShareMetaDataTool.h"
#import "GBCategoryModel.h"
#import "GBCategoryItem.h"
#import "ShareMetaDataTool.h"
@implementation GBCategoryMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 往scrollView里面添加数据
        NSArray * categroy = [ShareMetaDataTool shareMetaDataTool].allCategroyData;
        for (int i = 0;i < categroy.count;i ++) {
            GBCategoryItem * item = [[GBCategoryItem alloc] initWithFrame:CGRectMake(i * BottomItemW, 0, BottomItemW, BottomItemH)];
            [item addTarget:self action:@selector(processItem:) forControlEvents:UIControlEventTouchUpInside];
            item.categoryModel = categroy[i];
            [self.scrollView addSubview:item];
        }
        self.scrollView.contentSize = CGSizeMake(BottomItemW * categroy.count, BottomItemH);
    }
    return self;
}

#pragma mark - GBBottomSubViewsDelegate
- (void)bottomSubViewsWithBtnTitle:(NSString *)title
{
    [ShareMetaDataTool shareMetaDataTool].subViewsCategroy = title;
}

- (NSString *)getBottomSubViewsWithBtnTitle
{
    return [ShareMetaDataTool shareMetaDataTool].subViewsCategroy;
}

@end
