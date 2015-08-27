//
//  GBCollectionViewCell.m
//  仿团购
//
//  Created by catch on 15/8/19.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBCollectionViewCell.h"
#import "GBNetDataModel.h"
#import "UIImageView+WebCache.h"
@interface GBCollectionViewCell()
/**
 *  菜单图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *picture;
/**
 *  菜品描述
 */
@property (weak, nonatomic) IBOutlet UILabel *desc;
/**
 *  团购人数
 */
@property (weak, nonatomic) IBOutlet UIButton *number;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation GBCollectionViewCell


- (void)setNetDataModel:(GBNetDataModel *)netDataModel
{
    _netDataModel = netDataModel;
    
    // 设置数据
    
    // 图片
    [self.picture sd_setImageWithURL:[NSURL URLWithString:netDataModel.image_url]];
    // 描述
    self.desc.text = netDataModel.desc;
    // 团购人数
    [self.number setTitle:[NSString stringWithFormat:@"%d",netDataModel.purchase_count] forState:UIControlStateNormal];
    // 价格
    self.price.text = [NSString stringWithFormat:@"%.2f",netDataModel.current_price];
}
- (void)awakeFromNib {
    // Initialization code
}

@end
