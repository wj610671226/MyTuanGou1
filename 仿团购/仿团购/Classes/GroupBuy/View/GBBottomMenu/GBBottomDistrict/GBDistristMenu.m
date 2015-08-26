//
//  GBDistristMenu.m
//  仿团购
//
//  Created by catch on 15/8/14.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBDistristMenu.h"
#import "ShareMetaDataTool.h"
#import "CitiesModel.h"
#import "GBDistristItem.h"
@implementation GBDistristMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 往ScrollView添加数据
        CitiesModel * citiesModel = [ShareMetaDataTool shareMetaDataTool].currentCity;
        NSArray * distrisArray = citiesModel.districts;
        for (int i = 0; i < distrisArray.count; i ++) {
            GBDistristItem * distrisItem = [[GBDistristItem alloc] initWithFrame:CGRectMake(i * BottomItemW, 0, BottomItemW, BottomItemH)];
            [distrisItem addTarget:self action:@selector(processItem:) forControlEvents:UIControlEventTouchUpInside];
            distrisItem.districtsModel = distrisArray[i];
            [self.scrollView addSubview:distrisItem];
        }
        self.scrollView.contentSize = CGSizeMake(distrisArray.count * BottomItemW, BottomItemH);
    }
    return self;
}

#pragma mark - GBBottomSubViewsDelegate
- (void)bottomSubViewsWithBtnTitle:(NSString *)title
{
    MyLog(@"%@",title);
    [ShareMetaDataTool shareMetaDataTool].subViewsDistrist = title;
}

- (NSString *)getBottomSubViewsWithBtnTitle
{
    return [ShareMetaDataTool shareMetaDataTool].subViewsDistrist;
}
@end
