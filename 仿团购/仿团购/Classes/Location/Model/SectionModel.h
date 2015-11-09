//
//  SectionModel.h
//  仿团购
//
//  Created by catch on 15/8/7.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SectionModel : NSObject
/**
 *  name
 */
@property (nonatomic, copy)NSString * name;

/**
 *  cities
 */
@property (nonatomic, strong)NSMutableArray * cities;
@end
