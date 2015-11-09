//
//  WJGroupViewController.m
//  仿团购
//
//  Created by catch on 15/7/27.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "WJGroupViewController.h"
#import "GBLeftTopMenu.h"
#import "ShareMetaDataTool.h"
#import "GBCollectionViewCell.h"
#import "ShareGBTool.h"
#import "MJRefresh.h"
#import "GBBackView.h"
#define GBCollectionViewID @"collectionViewId"
#define collectionW 250
@interface WJGroupViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 *  collectionView
 */
@property (nonatomic, weak)UICollectionView * collectionView;

/**
 *  dataSources
 */
@property (nonatomic, strong)NSMutableArray * dataSources;

/**
 *  页码
 */
@property (nonatomic, assign)NSInteger page;

/**
 *  蒙板
 */
@property (nonatomic, weak) GBBackView * backView;
@end

@implementation WJGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听城市改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processChange) name:ChangeLocationName object:nil];
    // 监听 分类 区域 排序
    addNotification(processChange)
    self.view.backgroundColor = [UIColor clearColor];
    
    // 搜索框
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    searchBar.placeholder = @"请输入商品名、地址等";
    UIBarButtonItem * searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    // leftmenu
    GBLeftTopMenu * leftMenu = [[GBLeftTopMenu alloc] init];
    leftMenu.contentView.frame = self.view.bounds;
    leftMenu.contentView = self.view;
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftMenu];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    //  注册collectionView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    UINib * nib = [UINib nibWithNibName:@"GBCollectionViewCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:GBCollectionViewID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    // 添加刷新控件
    // 1、上拉刷新
    collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshColletiocView:)];
    
    // 2、下拉刷新
    collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshColletiocView:)];
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GBCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:GBCollectionViewID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    // 设置数据
    cell.netDataModel = self.dataSources[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

// 设置元素间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat left;
//    MyLog(@"%@",self.view);
    if (self.view.frame.size.width > 768) {
        // 横屏
        left = (self.view.frame.size.width - collectionW * 3) / 4;
    } else {
        // 竖屏
        left = (self.view.frame.size.width - collectionW * 2) / 3;
    }
    UIEdgeInsets top = {20,left,20,left};
    return top;
}

//设置元素大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionW,collectionW);
}

// 选中collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加蒙板
    if (self.backView == nil) {
        GBBackView * backView = [GBBackView backViewWithTarget:self action:@selector(processTapGestureRecognizer)];
        self.backView = backView;
        backView.alpha = 0;
        backView.frame = self.navigationController.view.bounds;
        [self.view addSubview:backView];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView cancelAlpha];
    }];
}

#pragma mark - processTapGestureRecognizer
- (void)processTapGestureRecognizer
{
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
    }];
}

// 屏幕旋转刷新collectionView
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.collectionView reloadData];
}

#pragma mark - processChange
- (void)processChange
{
    // 设置页码
    self.page = 1;
    [self getRequestNetData];
}

#pragma mark - 上下拉刷新
- (void)refreshColletiocView:(UIView *)sender
{
    if ([sender isKindOfClass:[MJRefreshHeader class]]) {
        [self.collectionView.header beginRefreshing];
        self.page = 1;
    } else if ([sender isKindOfClass:[MJRefreshFooter class]]) {
        [self.collectionView.footer beginRefreshing];
        self.page ++;
    }
    // 请求数据
    [self getRequestNetData];
}

#pragma mark - 获取网络数据
- (void)getRequestNetData
{
    [[ShareGBTool shareGBTool] getRequestDataWithPage:self.page success:^(NSArray *deals, int totalCount)
     {
         if (self.page == 1) {
             // 清除数据
             [self.dataSources removeAllObjects];
         }
         // 加入数据
         [self.dataSources addObjectsFromArray:deals];
         // 刷新界面
         [self.collectionView reloadData];
     } error:^(NSError *error) {
         self.page = 1;
     }];
    // 停止刷新
    [self.collectionView.footer endRefreshing];
    [self.collectionView.header endRefreshing];
}

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [[NSMutableArray alloc] init];
    }
    return _dataSources;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
