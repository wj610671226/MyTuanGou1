//
//  CitiesModel.m
//  仿团购
//
//  Created by catch on 15/8/7.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "CitiesModel.h"
#import "DistrictsModel.h"
#import "NSObject+MJKeyValue.h"
@implementation CitiesModel
- (void)setDistricts:(NSArray *)districts
{
    _districts = districts;
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dic in districts) {
        DistrictsModel * Model = [DistrictsModel mj_objectWithKeyValues:dic];
        [array addObject:Model];
    }
    _districts = (NSArray *)array;
}
@end
