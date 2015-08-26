//
//  GBCAtegoryItem.m
//  仿团购
//
//  Created by catch on 15/8/12.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBCategoryItem.h"
#import "GBCategoryModel.h"
#define KScale 0.5
@implementation GBCategoryItem

- (void)setCategoryModel:(GBCategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    // 设置文字
    [self setTitle:categoryModel.name forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:[UIImage imageNamed:categoryModel.icon] forState:UIControlStateNormal];
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * KScale, contentRect.size.width, contentRect.size.height * KScale);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 5, contentRect.size.width, contentRect.size.height * KScale);
}

- (NSArray *)title
{
    return _categoryModel.subcategories;
}
@end
