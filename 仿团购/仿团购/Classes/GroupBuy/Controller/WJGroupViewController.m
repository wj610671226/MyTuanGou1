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
#define GBCollectionViewID @"collectionViewId"
#define collectionW 250
@interface WJGroupViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 *  collectionView
 */
@property (nonatomic, weak)UICollectionView * collectionView;
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
    collectionView.backgroundColor = [UIColor greenColor];
    UINib * nib = [UINib nibWithNibName:@"GBCollectionViewCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:GBCollectionViewID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GBCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:GBCollectionViewID forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
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

// 屏幕旋转刷新collectionView
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.collectionView reloadData];
}

#pragma mark - processChange
- (void)processChange
{
    [[ShareGBTool shareGBTool] getRequestDataWithPage:1 success:^(NSArray *deals, int totalCount) {
        
    } error:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
