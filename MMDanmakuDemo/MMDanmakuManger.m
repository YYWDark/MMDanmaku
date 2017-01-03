//
//  MMDanmakuManger.m
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "MMDanmakuManger.h"
#import "MMDanmakuHeader.h"
@interface MMDanmakuManger ()
@property (nonatomic, strong) NSMutableArray *widthArr;
@property (nonatomic, strong) NSMutableArray *sourceArr;
@property (nonatomic, strong) NSMutableArray *cacheArr;      //缓存复用
@end

@implementation MMDanmakuManger
- (instancetype)init {
    self = [super init];
    if (self) {
        self.widthArr = [NSMutableArray array];
        self.sourceArr = [NSMutableArray array];
        self.cacheArr = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithConfiguration:(MMConfiguration *)configuration {
    self = [[[self class] alloc] init];
    if (self) {
        self.configuration = configuration;
        
    }
    return self;
}

- (void)packageData {
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsControlleredByDanmakuManger:)] && [self.dataSource respondsToSelector:@selector(danmakuManger:informationForItem:)]) {
        for (int i = 0; i < [self.dataSource numberOfItemsControlleredByDanmakuManger:self]; i++) {
            MMDanMakuModel *model = [self.dataSource danmakuManger:self informationForItem:i];
            CGFloat eachWidth = [NSObject widthFromString:model.title withFont:[UIFont systemFontOfSize:self.configuration.titleSize] constraintToHeight:self.configuration.eachBulletViewHeight];
            [self.sourceArr addObject:model];
            [self.widthArr addObject:@(eachWidth)];
            
        }
    }
    
}

- (void)srart {
    
}

- (void)pause {
    
}

- (void)stop {
    
}
@end
