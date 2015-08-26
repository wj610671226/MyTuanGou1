//
//  CitiesModel.h
//  仿团购
//
//  Created by catch on 15/8/7.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitiesModel : NSObject
/**
 *  citys-->name
 */
@property (nonatomic, copy)NSString * name;

/**
 *  districts 
 */
@property (nonatomic, strong)NSArray * districts;

/**
 *  hot city
 */
@property (nonatomic, assign)BOOL hot;
@end
