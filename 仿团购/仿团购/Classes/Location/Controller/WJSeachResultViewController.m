//
//  WJSeachResultViewController.m
//  仿团购
//
//  Created by catch on 15/8/12.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJSeachResultViewController.h"
#import "ShareMetaDataTool.h"
#import "CitiesModel.h"
@interface WJSeachResultViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  搜索的城市
 */
@property (nonatomic, strong)NSMutableArray * resutlCityArray;
@end

@implementation WJSeachResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    [self.resutlCityArray removeAllObjects];
    NSArray * allCityArray = [ShareMetaDataTool shareMetaDataTool].totleCity;
    for (NSString * city in allCityArray) {
        if ([city containsString:searchText]) {
            [self.resutlCityArray addObject:city];
        }
    }
    [self.tableView reloadData];
//    MyLog(@"allCityArray = %@",allCityArray);
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resutlCityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"searchCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.resutlCityArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesModel * cityModel = [[CitiesModel alloc] init];
    cityModel.name = self.resutlCityArray[indexPath.row];
    [ShareMetaDataTool shareMetaDataTool].currentCity = cityModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)resutlCityArray
{
    if (!_resutlCityArray) {
        _resutlCityArray = [[NSMutableArray alloc] init];
    }
    return _resutlCityArray;
}
@end
