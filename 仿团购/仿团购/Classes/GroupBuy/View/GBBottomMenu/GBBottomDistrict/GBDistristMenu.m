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
#import "DistrictsModel.h"
@interface GBDistristMenu ()
/**
 *  记录加入ScrollView 的GBDistristItem个数
 */
@property (nonatomic, strong)NSMutableArray * disItmeCount;
@end
@implementation GBDistristMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 初始化数组
        _disItmeCount = [[NSMutableArray alloc] init];
        
        // 往ScrollView添加数据
        [self cityChange];
        
        // 监听城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:ChangeLocationName object:nil];
    }
    return self;
}

- (void)cityChange
{
    CitiesModel * citiesModel = [ShareMetaDataTool shareMetaDataTool].currentCity;
    NSArray * distrisArray = citiesModel.districts;
    
    // 添加"全部"商区按钮
    NSMutableArray * newDistrisArray = [NSMutableArray array];
    DistrictsModel * model = [[DistrictsModel alloc] init];
    model.name = @"全部";
    [newDistrisArray addObject:model];
    
    // 根据地区数据添加按钮
    [newDistrisArray addObjectsFromArray:distrisArray];

    // 判断子视图的数量
    for (int i = 0; i < newDistrisArray.count; i ++) {
        GBDistristItem * distrisItem = nil;
        if (i >= self.disItmeCount.count) {
            // 创建新的item
            distrisItem = [[GBDistristItem alloc] initWithFrame:CGRectMake(i * BottomItemW, 0, BottomItemW, BottomItemH)];
            [distrisItem addTarget:self action:@selector(processItem:) forControlEvents:UIControlEventTouchUpInside];
            [self.disItmeCount addObject:distrisItem];
            [self.scrollView addSubview:distrisItem];
        } else {
            distrisItem = self.disItmeCount[i];
        }
        distrisItem.hidden = NO;
        distrisItem.districtsModel = newDistrisArray[i];
        
        // 默认选中
        if (i == 0) {
            if (self.lastBottomItem) {
                self.lastBottomItem.selected = NO;
            }
            distrisItem.selected = YES;
            self.lastBottomItem = distrisItem;
        }
    }
    // 隐藏多余的按钮
    for (int i = newDistrisArray.count; i < self.disItmeCount.count; i ++) {
        ((GBDistristItem *)self.disItmeCount[i]).hidden = YES;
    }
    
    self.scrollView.contentSize = CGSizeMake(newDistrisArray.count * BottomItemW, BottomItemH);
    
    // 城市改变 - 隐藏subViews菜单
    [self hiddenSubViews];
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
