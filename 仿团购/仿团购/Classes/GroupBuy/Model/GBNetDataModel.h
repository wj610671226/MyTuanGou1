//
//  GBNetDataModel.h
//  仿团购
//
//  Created by catch on 15/8/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBNetDataModel : NSObject
/**
 *  图片
 */
@property (nonatomic, copy)NSString * image_url;

/**
 *  描述
 */
@property (nonatomic, copy)NSString * desc;

/**
 *  团购人数
 */
@property (nonatomic, assign)int purchase_count;

/**
 *  当前价格
 */
@property (nonatomic, assign)double current_price;

///**
// *  businesses
// */
//@property (nonatomic, strong)NSArray * businesses;
//
///**
// *  categories
// */
//@property (nonatomic, strong)NSArray * categories;
//
///**
// *  regions
// */
//@property (nonatomic, strong)NSArray * regions;
@end
