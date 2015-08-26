//
//  UIImage+resizableImage.h
//  仿团购
//
//  Created by catch on 15/8/17.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (resizableImage)
/**
 *  @return 返回一张拉伸的图片
 */
+ (UIImage *)resizableImageName:(NSString *)imageName;
@end
