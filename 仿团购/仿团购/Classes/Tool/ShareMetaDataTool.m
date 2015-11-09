//
//  ShareMetaDataTool.m
//  仿团购
//
//  Created by catch on 15/8/10.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "ShareMetaDataTool.h"
#import "GBCategoryModel.h"
#import "NSObject+MJKeyValue.h"
#import "SectionModel.h"
#import "CitiesModel.h"
#import "GBSequenceModel.h"

#define KFilePath [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"recetCity.data"]
@interface ShareMetaDataTool ()
/**
 *  最近访问过的城市
 */
@property (nonatomic, strong) NSMutableArray * recentArray;
/**
 *  最近访问城市组
 */
@property (nonatomic, strong)SectionModel * recentSectionModel;
@end
static ShareMetaDataTool * shareData;
@implementation ShareMetaDataTool
+ (instancetype)shareMetaDataTool
{
    if (shareData == nil) {
        shareData  = [[ShareMetaDataTool alloc] init];
    }
    return shareData;
}

- (instancetype)init
{
    if (self = [super init]) {
        // 初始化所有的城市
        [self initAllCitySection];
        
        // 初始化所有的分类数据
        [self initAllCategroyData];
        
        // 初始化所有的排序数据
        [self initAllSequenceData];
        
    }
    return self;
}
#pragma mark - 初始化所有的城市
- (void)initAllCitySection
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil];
    NSMutableArray * array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSMutableArray * dataArray = [NSMutableArray array];
    
    // 存储所有的城市
    NSMutableArray * totleCity = [NSMutableArray array];
    // 所有的城市组
    for (NSDictionary * dic in array) {
        SectionModel * model = [SectionModel objectWithKeyValues:dic];
        [dataArray addObject:model];
    }
    
    _allCity = [NSMutableArray array];
    
    // 最近访问城市
    // 从沙盒读取
    MyLog(@"%@",KFilePath);
    // 之前访问过的城市
    self.recentArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KFilePath];
    if (!self.recentArray) {
        self.recentArray = [[NSMutableArray alloc] init];
    }
    
    SectionModel * recentCity = [[SectionModel alloc] init];
    recentCity.name = @"最近访问城市";
    recentCity.cities = [NSMutableArray array];
    self.recentSectionModel = recentCity;
    
    for (NSString * cityName in self.recentArray) {
        CitiesModel * cityModel = [[CitiesModel alloc] init];
        cityModel.name = cityName;
        [recentCity.cities addObject:cityModel];
    }
    
    if (self.recentArray.count) {
        [_allCity addObject:self.recentSectionModel];
    }
    
    // 热门城市
    SectionModel * sec = [[SectionModel alloc] init];
    sec.name = @"热门城市";
    sec.cities = [NSMutableArray array];
    [_allCity addObject:sec];
    for (SectionModel * secModel in dataArray) {
        for (CitiesModel * cityModel in secModel.cities) {
            if (cityModel.hot == YES) {
                [sec.cities addObject:cityModel];
            }
            [totleCity addObject:cityModel.name];
        }
    }
    _totleCity = totleCity;
    [_allCity addObjectsFromArray:dataArray];
}

#pragma mark - 初始化所有的分类数据
- (void)initAllCategroyData
{
    NSArray * array = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories.plist" ofType:nil]];
    NSMutableArray * modelArray = [NSMutableArray array];
    
    // 添加全部分类
    GBCategoryModel * model = [[GBCategoryModel alloc] init];
    model.name = @"全部";
    model.icon = @"ic_filter_category_-1.png";
    [modelArray addObject:model];
    
    // 添加其他类型的分类
    for (NSDictionary * dic in array) {
        GBCategoryModel * model = [GBCategoryModel objectWithKeyValues:dic];
        [modelArray addObject:model];
    }
    _allCategroyData = [[NSArray alloc] init];
    _allCategroyData = modelArray;
}

#pragma mark - 初始化所有的排序数据
- (void)initAllSequenceData
{
    NSArray * array = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Sequence.plist" ofType:nil]];
    NSMutableArray * dataArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        GBSequenceModel * sequenceModel = [[GBSequenceModel alloc] init];
        sequenceModel.name = array[i];
        sequenceModel.index = i + 1;
        [dataArray addObject:sequenceModel];
    }
    self.sequdenceData = dataArray;
}

#pragma mark - 当前城市
- (void)setCurrentCity:(CitiesModel *)currentCity
{
    _currentCity = currentCity;
    
    // 移除之前存在当前的城市
    [self.recentArray removeObject:currentCity.name];
    // 把当前选中的城市加入对应数组
    [self.recentArray insertObject:currentCity.name atIndex:0];
    
    [self.recentSectionModel.cities removeObject:currentCity];
    [self.recentSectionModel.cities insertObject:currentCity atIndex:0];
    
    // 控制数组里面的数据只有5条
    while (self.recentArray.count > 5) {
        [self.recentArray removeLastObject];
    }
    while (self.recentSectionModel.cities.count > 5) {
        [self.recentSectionModel.cities removeLastObject];
    }
    // 将最新的城市写入沙盒
    [NSKeyedArchiver archiveRootObject:self.recentArray toFile:KFilePath];
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeLocationName object:currentCity.name];
    
    // 第一次没有最近选中城市组
    if (![_allCity containsObject:self.recentSectionModel]) {
        [_allCity insertObject:self.recentSectionModel atIndex:0];
    }
}

- (void)setSubViewsCategroy:(NSString *)subViewsCategroy
{
    _subViewsCategroy = subViewsCategroy;
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:subViewsCategroyNotification object:nil];
}

- (void)setSubViewsDistrist:(NSString *)subViewsDistrist
{
    _subViewsDistrist = subViewsDistrist;
    [[NSNotificationCenter defaultCenter] postNotificationName:subViewsDistrisNotification object:nil];
}

- (void)setSubViewsSequence:(GBSequenceModel *)subViewsSequence
{
    _subViewsSequence = subViewsSequence;
    [[NSNotificationCenter defaultCenter] postNotificationName:subViewsSequenceNotification object:nil];
}


#pragma mark - 根据排序名称返回对应的排序模型
- (GBSequenceModel *)getSequenceModelWithName:(NSString *)name
{
    for (GBSequenceModel * model in self.sequdenceData) {
        if ([name isEqualToString:model.name]) {
            return model;
        }
    }
    return nil;
}
@end
    
