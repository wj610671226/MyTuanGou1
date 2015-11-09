//
//  GBSequenceMenu.m
//  仿团购
//
//  Created by catch on 15/8/14.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBSequenceMenu.h"
#import "ShareMetaDataTool.h"
#import "GBSequenceItem.h"
@implementation GBSequenceMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 往scrollView添加数据
        NSArray * dataArray = [ShareMetaDataTool shareMetaDataTool].sequdenceData;
        for (int i = 0; i < dataArray.count; i ++) {
            GBSequenceItem * item = [[GBSequenceItem alloc] initWithFrame:CGRectMake(i * BottomItemW, 0, BottomItemW, BottomItemH)];
            [item addTarget:self action:@selector(processItem:) forControlEvents:UIControlEventTouchUpInside];
            item.sequenceModel = dataArray[i];
            [self.scrollView addSubview:item];
            
            // 默认选中
            if (i == 0) {
                item.selected = YES;
                self.lastBottomItem = item;
            }
        }
        self.scrollView.contentSize = CGSizeMake(BottomItemW * dataArray.count, BottomItemH);
    }
    return self;
}

@end
