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
@property (nonatomic, assign) MMDanMakuRestartType restartType;
@property (nonatomic, copy) NSString *memberColorHex;
@property (nonatomic, copy) NSString *normalColorHex;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) CGFloat topMargin;
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;
@property (nonatomic, assign) CGFloat eachBulletViewHeight;
@property (nonatomic, assign) CGFloat titleSize;
@property (nonatomic, assign) CGFloat horizontalMargin;           //left medium right
@property (nonatomic, assign) CGFloat imageSide;
@property (nonatomic, strong) UIView *targetView;

+ (instancetype)configurationAimationDuration:(NSTimeInterval)duration
                                   targetView:(UIView *)targetView
                                  restartType:(MMDanMakuRestartType)type;
@end
