//
//  GBCategoryModel.h
//  仿团购
//
//  Created by catch on 15/8/10.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCategoryModel : NSObject

/**
 *  图片
 */
@property (nonatomic, copy)NSString * icon;
/**
 *  名字
 */
@property (nonatomic, copy)NSString * name;
/**
 *  subcategories
 */
@property (nonatomic, strong)NSArray * subcategories;

@end
