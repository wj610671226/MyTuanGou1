//
//  ShareMetaDataTool.h
//  仿团购
//
//  Created by catch on 15/8/10.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CitiesModel;
@class GBSequenceModel;
@interface ShareMetaDataTool : NSObject
+ (instancetype)shareMetaDataTool;
/**
 *  所有的第一级城市
 */
@property (nonatomic, strong, readonly)NSMutableArray * allCity;

/**
 *  当前城市
 */
@property (nonatomic, strong)CitiesModel * currentCity;

/**
 *  所有的分类数据
 */
@property (nonatomic, strong, readonly)NSArray * allCategroyData;

/**
 *  所有的城市
 */
@property (nonatomic, strong)NSArray * totleCity;

/**
 *  所有的排序数据
 */
@property (nonatomic, strong)NSArray * sequdenceData;


/**
 *  记录当前选中的分类数据子菜单
 */
@property (nonatomic, copy)NSString * subViewsCategroy;

/**
 *  记录当前选中的地区数据的子菜单
 */
@property (nonatomic, copy)NSString * subViewsDistrist;

/**
 *  记录当前选中的排序数据的子菜单
 */
@property (nonatomic, strong)GBSequenceModel * subViewsSequence;

/**
 *  根据排序名称返回对应的排序模型
 */
- (GBSequenceModel *)getSequenceModelWithName:(NSString *)name;
@end
