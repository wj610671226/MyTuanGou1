//
//  ShareGBTool.h
//  仿团购
//
//  Created by catch on 15/8/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DealsSuccessBlock)(NSArray *deals, int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);


@interface ShareGBTool : NSObject
+ (instancetype)shareGBTool;

/**
 *  返回请求的数据
 */
- (void)getRequestDataWithPage:(NSInteger)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;
@end
