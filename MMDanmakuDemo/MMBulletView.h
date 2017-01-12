//
//  MMBulletView.h
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDanMakuModel.h"
typedef NS_ENUM(NSUInteger, MMBulletViewStatus) {
    MMBulletViewStatusStart = 0,  //开始
    MMBulletViewStatusEnter = 1,  //完全进入到屏幕
    MMBulletViewStatusEnd   = 2   //完全离开屏幕
};
typedef void(^MovementStatus)(MMBulletViewStatus status,NSUInteger indexOfTracks);

@interface MMBulletView : UIView
@property (nonatomic, strong) MMDanMakuModel *model;
@property (nonatomic, assign) MMBulletViewStatus status;
@property (nonatomic, copy) MovementStatus movementStatus;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) NSUInteger indexOfTracks;

- (void)srartWithAnimationDuration:(NSTimeInterval)duration animationScreenWidth:(CGFloat)Width;

- (void)stopAnimation;
@end
