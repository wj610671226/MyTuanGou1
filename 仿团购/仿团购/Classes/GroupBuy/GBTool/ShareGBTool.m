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
#import "GBNetDataModel.h"
#import "MJExtension.h"


static ShareGBTool * shareGBTool = nil;
typedef void(^ResultBlock)(id result, NSError * errorObject);
@interface ShareGBTool ()<DPRequestDelegate>

@property (nonatomic, strong)NSMutableDictionary * blocks;
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
    [self requestWithURL:@"v1/deal/find_deals" params:params block:^(id result, NSError *errorObject) {
        if (errorObject) { // 请求失败
            if (error) {
                error(errorObject);
            }
        } else if (success) { // 请求成功
            NSArray *array = result[@"deals"];
            
            NSMutableArray *deals = [NSMutableArray array];
            [GBNetDataModel setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"desc":@"desciption"};
            }];
            for (NSDictionary * dic in array) {
                
                NSError * error = nil;
                GBNetDataModel * model = [GBNetDataModel objectWithKeyValues:dic error:&error];
                if (error) {
                    MyLog(@"模型装换错误：%@",error);
                }
                NSLog(@"desc = %@",model.desc);
                [deals addObject:model];
            }
            success(deals, [result[@"total_count"] intValue]);
        }
    }];
}

- (void)requestWithURL:url params:(NSMutableDictionary *)params block:(ResultBlock)resultBlock
{
    DPAPI * api = [DPAPI sharedDPAPI];
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    
    [self.blocks setObject:resultBlock forKey:request.description];
}

#pragma mark - 大众点评的请求方法代理
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
//    NSLog(@"result = %@",result);
    ResultBlock block = _blocks[request.description];
    if (block) {
        block(result, nil);
    }
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    ResultBlock block = _blocks[request.description];
    if (block) {
        block(nil, error);
    }
}

- (NSMutableDictionary *)blocks
{
    if (!_blocks) {
        _blocks = [[NSMutableDictionary alloc] init];
    }
    return _blocks;
}
@end
