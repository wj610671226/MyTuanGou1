//
//  SectionModel.m
//  仿团购
//
//  Created by catch on 15/8/7.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "SectionModel.h"
#import "CitiesModel.h"
#import "NSObject+MJKeyValue.h"
@implementation SectionModel
- (void)setCities:(NSMutableArray *)cities
{
    _cities = cities;
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dic in cities) {
        CitiesModel * cityModel = [CitiesModel objectWithKeyValues:dic];
        [array addObject:cityModel];
    }
    _cities = array;
}

@end
