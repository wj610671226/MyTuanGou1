//
//  GBDistristItem.m
//  仿团购
//
//  Created by catch on 15/8/14.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBDistristItem.h"
#import "DistrictsModel.h"
@implementation GBDistristItem

- (void)setDistrictsModel:(DistrictsModel *)districtsModel
{
    _districtsModel = districtsModel;
    [self setTitle:districtsModel.name forState:UIControlStateNormal];
}

- (NSArray *)title
{
    return _districtsModel.neighborhoods;
}
@end
