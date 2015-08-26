//
//  WJDock.h
//  仿团购
//
//  Created by catch on 15/7/26.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol wjDockDelegate <NSObject>
@optional
- (void)chooseFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface WJDock : UIView

@property (nonatomic, weak)id<wjDockDelegate> delegate;

@end

