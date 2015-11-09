//
//  GBSequenceItem.m
//  仿团购
//
//  Created by catch on 15/8/14.
//  Copyright (c) 2015年 catch. All rights reserved.
//

#import "GBSequenceItem.h"
#import "GBSequenceModel.h"
@implementation GBSequenceItem

- (void)setSequenceModel:(GBSequenceModel *)sequenceModel
{
    _sequenceModel = sequenceModel;
    [self setTitle:sequenceModel.name forState:UIControlStateNormal];
}
@end
