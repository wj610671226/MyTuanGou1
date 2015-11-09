//
//  GBCollectionViewCell.h
//  仿团购
//
//  Created by catch on 15/8/19.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GBNetDataModel;
@interface GBCollectionViewCell : UICollectionViewCell
/**
 *  团购数据模型
 */
@property (nonatomic, strong)GBNetDataModel * netDataModel;
@end
