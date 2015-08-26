//
//  UIImage+resizableImage.m
//  仿团购
//
//  Created by catch on 15/8/17.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "UIImage+resizableImage.h"

@implementation UIImage (resizableImage)
+ (UIImage *)resizableImageName:(NSString *)imageName
{
    UIImage * normal = [UIImage imageNamed:imageName];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    UIImage * newImage = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    return newImage;
}

@end
