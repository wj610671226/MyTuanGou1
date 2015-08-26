//
//  ShareGBTool.m
//  仿团购
//
//  Created by catch on 15/8/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "ShareGBTool.h"
#import "DPAPI.h"
#import "ShareMetaDataTool.h"
#import "CitiesModel.h"
#import "GBSequenceModel.h"

static ShareGBTool * shareGBTool = nil;

@interface ShareGBTool ()<DPRequestDelegate>

@end
@implementation ShareGBTool
+ (instancetype)shareGBTool
{
    if (!shareGBTool) {
        shareGBTool = [[ShareGBTool alloc] init];
    }
    return shareGBTool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareGBTool = [super allocWithZone:zone];
    });
    return shareGBTool;
}

- (void)getRequestDataWithPage:(NSInteger)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    // 参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    // 1.1.添加城市参数
    NSString *city = [ShareMetaDataTool shareMetaDataTool].currentCity.name;
    [params setObject:city forKey:@"city"];
    
    // 1.2.添加区域参数
    NSString *district = [ShareMetaDataTool shareMetaDataTool].subViewsDistrist;
    if (district) {
        [params setObject:district forKey:@"region"];
    }
    
    // 1.3.添加分类参数
    NSString *category = [ShareMetaDataTool shareMetaDataTool].subViewsCategroy;
    if (category) {
        [params setObject:category forKey:@"category"];
    }
    
    // 1.4.添加排序参数
    GBSequenceModel *sequence = [ShareMetaDataTool shareMetaDataTool].subViewsSequence;
    if (sequence) {
        [params setObject:@(sequence.index) forKey:@"sort"];
    }
    
    // 1.5.添加页码参数
    [params setObject:@(page) forKey:@"page"];
    
    // 获取数据
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:@{
       @"city" : [ShareMetaDataTool shareMetaDataTool].currentCity.name
   } delegate:self];
}

#pragma mark - 大众点评的请求方法代理
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"result = %@",result);
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{

}

@end
