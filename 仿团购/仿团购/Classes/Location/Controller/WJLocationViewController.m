//
//  WJLocationViewController.m
//  仿团购
//
//  Created by catch on 15/8/5.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJLocationViewController.h"
#import "ShareMetaDataTool.h"
#import "SectionModel.h"
#import "CitiesModel.h"
#import "WJSeachResultViewController.h"
#import "GBBackView.h"
#define SEARCHBAR_HIGHT 44

@interface WJLocationViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
/**
 *  搜索框
 */
@property (nonatomic, weak) UISearchBar * searchBar;
/**
 *  tableview数据源
 */
@property (nonatomic, strong)NSArray * dataSources;
/**
 *  蒙板
 */
@property (nonatomic, weak)GBBackView * backView;
/**
 *  tableView
 */
@property (nonatomic, weak)UITableView * locationTableView;

@property (nonatomic, strong) WJSeachResultViewController * resultVC;
@end

@implementation WJLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 添加搜索框
    [self addSearchBar];
    
    // 添加tableView
    [self addTableView];
    
    // 读取数据
    [self readCityData];
    
}

#pragma mark - 添加搜索框
- (void)addSearchBar
{
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SEARCHBAR_HIGHT)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:searchBar];
    searchBar.placeholder = @"请输入城市名";
    searchBar.delegate = self;
    self.searchBar = searchBar;
}

#pragma mark - 添加tableView
- (void)addTableView
{
    UITableView * locationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SEARCHBAR_HIGHT, self.view.frame.size.width, self.view.frame.size.height - SEARCHBAR_HIGHT) style:UITableViewStyleGrouped];
    locationTableView.dataSource = self;
    locationTableView.delegate = self;
    locationTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    locationTableView.sectionHeaderHeight = 0;
    locationTableView.sectionFooterHeight = 0;
    self.locationTableView = locationTableView;
    [self.view addSubview:locationTableView];
}

#pragma mark - 去读plist数据
- (void)readCityData
{
    NSArray * cityArray = [ShareMetaDataTool shareMetaDataTool].allCity;
    self.dataSources = cityArray;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    // 创建添加蒙板
    if (self.backView == nil) {
        GBBackView * backView = [GBBackView backViewWithTarget:self action:@selector(processTopBackView)];
        backView.frame = self.locationTableView.frame;
        backView.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            [backView cancelAlpha];
        }];
        [self.view addSubview:backView];
        self.backView = backView;
    }
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // 获取searchBar文本框的条件搜索
    if (searchText.length == 0) {
        [self.resultVC.view removeFromSuperview];
    } else {
        if (!self.resultVC) {
            self.resultVC = [[WJSeachResultViewController alloc] init];
            self.resultVC.view.frame = self.locationTableView.frame;
        }
        self.resultVC.searchText = searchText;
        [self.view addSubview:self.resultVC.view];
    }
}

// 取消
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self processTopBackView];
}

#pragma mark - processTopBackView
- (void)processTopBackView
{
    // 取消按钮消失
    [self.searchBar setShowsCancelButton:NO animated:YES];
    // 蒙板消失
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
    }];
    // 键盘隐藏
    [self.searchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionModel * sectionModel = self.dataSources[section];
    return sectionModel.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"locationCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
    }
    SectionModel * sectionModel = self.dataSources[indexPath.section];
    CitiesModel * cityModel = sectionModel.cities[indexPath.row];
    cell.textLabel.text = cityModel.name;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SectionModel * SectionModel = self.dataSources[section];
    return SectionModel.name;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.dataSources valueForKeyPath:@"name"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionModel * sectionModel = self.dataSources[indexPath.section];
    CitiesModel * cityModel = sectionModel.cities[indexPath.row];
    [ShareMetaDataTool shareMetaDataTool].currentCity = cityModel;
    MyLog(@"当前选中城市 = %@",cityModel.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
