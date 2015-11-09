//
//  DistrictsModel.h
//  仿团购
//
//  Created by catch on 15/8/7.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NeighborhoodModel;
@interface DistrictsModel : NSObject
/**
 *  县的名字
 */
@property (nonatomic, copy)NSString * name;

/**
 *  neighborhoods
 */
@property (nonatomic, strong)NSArray * neighborhoods;
@end
