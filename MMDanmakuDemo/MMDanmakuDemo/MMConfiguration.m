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
    configuration.numberOfTrack = [configuration _calculateNumberOfTrack];
    return configuration;
}

+ (instancetype)configurationAimationDuration:(NSTimeInterval)duration
                                   targetView:(UIView *)targetView
                                  restartType:(MMDanMakuRestartType)type
                                    topMargin:(CGFloat)topMargin
                                 bottomMargin:(CGFloat)bottomMargin {
    MMConfiguration *configuration = [MMConfiguration configurationAimationDuration:duration targetView:targetView restartType:type];
    configuration.topMargin = topMargin;
    configuration.bottomMargin = bottomMargin;
    configuration.numberOfTrack = [configuration _calculateNumberOfTrack];
    return configuration;
}

- (NSUInteger)_calculateNumberOfTrack {
    return (CGRectGetHeight(self.targetView.frame) - self.topMargin - self.bottomMargin)/self.eachBulletViewHeight;
}


@end
