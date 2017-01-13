//
//  MMConfiguration.m
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "MMConfiguration.h"

@interface MMConfiguration ()

@end
@implementation MMConfiguration
- (instancetype)init {
    self = [super init];
    if (self) {
        self.restartType = MMDanMakuRestartTypeFromTheBeginning;
        self.memberColorHex = @"FD23RF";
        self.normalColorHex = @"SD3214";
        self.topMargin = 0.0f;
        self.bottomMargin = 0.0f;
        self.duration = 2.5f;
        self.eachBulletViewHeight = 20.0f;
        self.titleSize = 14.0f;
        self.isNeedReuse = YES;
        self.durationOfProduction = .3f;
    }
    return self;
}

+ (instancetype)configurationAimationDuration:(NSTimeInterval)duration
                                   targetView:(UIView *)targetView
                                  restartType:(MMDanMakuRestartType)type {
    MMConfiguration *configuration = [[MMConfiguration alloc] init];
    configuration.duration = duration;
    configuration.targetView = targetView;
    configuration.restartType = type;
    configuration.numberOfTrack = (CGRectGetHeight(configuration.targetView.frame) - configuration.topMargin - configuration.bottomMargin)/configuration.eachBulletViewHeight;
    return configuration;
}


@end
