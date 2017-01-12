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

@protocol MMDanmakuMangerDataSource;
@interface MMDanmakuManger : NSObject
@property (nonatomic, strong) MMConfiguration *configuration;
@property (nonatomic, weak) id<MMDanmakuMangerDataSource> dataSource;
@property (nonatomic, assign) BOOL isStarted;
@property (nonatomic, assign) BOOL isFinished;
@property (nonatomic, assign) BOOL isPaused;
- (void)packageData;
- (void)start;
- (void)stop;
- (void)pause;
- (instancetype)initWithConfiguration:(MMConfiguration *)configuration;
@end


@protocol MMDanmakuMangerDataSource <NSObject>

@required;
- (NSUInteger)numberOfItemsControlleredByDanmakuManger:(MMDanmakuManger *)manger;
- (MMDanMakuModel *)danmakuManger:(MMDanmakuManger *)manger informationForItem:(NSUInteger)index;
@end
