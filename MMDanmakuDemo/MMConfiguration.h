//
//  MMConfiguration.h
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MMDanMakuRestartType) {
    MMDanMakuRestartTypeFromTheBeginning = 0,  //从头开始
    MMDanMakuRestartTypeFromLastState  = 1,  //重上次的数据开始
};


@interface MMConfiguration : NSObject
{
    NSString *t;
}
@property (nonatomic, assign) MMDanMakuRestartType restartType;
@property (nonatomic, assign) BOOL isNeedReuse;                   //是否需要重用机制
@property (nonatomic, assign) NSTimeInterval duration;            //弹幕视图从开始到结束的动画时间
@property (nonatomic, assign) NSTimeInterval durationOfProduction;//弹幕视图生产的间隔
@property (nonatomic, assign) CGFloat topMargin;                  //跑道到视图上的边距
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic, assign) CGFloat eachBulletViewHeight;       //每个视图的高度
@property (nonatomic, assign) CGFloat titleSize;
@property (nonatomic, assign) NSUInteger numberOfTrack;           //弹道数
@property (nonatomic, strong) UIView *targetView;

@property (nonatomic, copy) NSString *memberColorHex;  //会员字体颜色
@property (nonatomic, copy) NSString *normalColorHex;  //正常的颜色

+ (instancetype)configurationAimationDuration:(NSTimeInterval)duration
                                   targetView:(UIView *)targetView
                                  restartType:(MMDanMakuRestartType)type;

+ (instancetype)configurationAimationDuration:(NSTimeInterval)duration
                                   targetView:(UIView *)targetView
                                  restartType:(MMDanMakuRestartType)type
                                    topMargin:(CGFloat)topMargin
                                 bottomMargin:(CGFloat)bottomMargin;
@end
