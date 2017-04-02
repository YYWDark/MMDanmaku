//
//  MMDanmakuManger.h
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMDanMakuModel.h"
#import "MMConfiguration.h"

typedef void(^TapLocationPointBlock)(CGPoint point);
@protocol MMDanmakuMangerDataSource;
@protocol MMDanmakuMangerDelegate;

@interface MMDanmakuManger : NSObject
@property (nonatomic, strong) MMConfiguration *configuration;
@property (nonatomic, weak) id<MMDanmakuMangerDataSource> dataSource;
@property (nonatomic, weak) id<MMDanmakuMangerDelegate> delegate;
@property (nonatomic, copy) TapLocationPointBlock tapBlock;
@property (nonatomic, assign) BOOL isStarted;
@property (nonatomic, assign) BOOL isFinished;

- (void)packageData;
- (void)start;
- (void)stop;
- (void)appendData;
- (instancetype)initWithConfiguration:(MMConfiguration *)configuration;
@end


@protocol MMDanmakuMangerDataSource <NSObject>
@required;
- (NSUInteger)numberOfItemsControlleredByDanmakuManger:(MMDanmakuManger *)manger;
- (MMDanMakuModel *)danmakuManger:(MMDanmakuManger *)manger informationForItem:(NSUInteger)index;
@end

@protocol MMDanmakuMangerDelegate <NSObject>
- (void)danmakuManger:(MMDanmakuManger *)manger didSelectedItem:(MMDanMakuModel *)model;
@end
