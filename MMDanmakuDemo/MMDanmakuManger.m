//
//  MMDanmakuManger.m
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "MMDanmakuManger.h"
#import "MMDanmakuHeader.h"
#import "MMBulletView.h"

@interface MMDanmakuManger ()
@property (nonatomic, strong) NSMutableArray *widthArr;
@property (nonatomic, strong) NSMutableArray *sourceArr;
@property (nonatomic, strong) NSMutableArray *cacheArr;      //缓存复用
@property (nonatomic, strong) NSMutableArray *trackArray;    //记录弹道
@property (nonatomic, assign) BOOL isBeingExecuted;
@end

@implementation MMDanmakuManger
- (instancetype)init {
    self = [super init];
    if (self) {
        self.widthArr = [NSMutableArray array];
        self.sourceArr = [NSMutableArray array];
        self.cacheArr = [NSMutableArray array];
        self.trackArray = [NSMutableArray array];
        
    }
    return self;
}

- (instancetype)initWithConfiguration:(MMConfiguration *)configuration {
    self = [[[self class] alloc] init];
    if (self) {
        self.configuration = configuration;
        for (int i = 0; i < configuration.numberOfTrack; i++) {
            [self.trackArray addObject:@(i)];
        }
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
- (void)_updateStatusStart:(BOOL)isStarted isPaused:(BOOL)isPaused isFinished:(BOOL)isFinished {
    self.isFinished = isFinished;
    self.isPaused = isPaused;
    self.isStarted = isStarted;
}
- (void)start {
    [self go];

//    NSUInteger indexOfTrack = [self _getIndexOfTracks];
//    if (indexOfTrack == -1) return;
//    [self.trackArray removeObjectAtIndex:indexOfTrack];
////    [self _updateStatusStart:YES isPaused:NO isFinished:NO];
//    MMBulletView *bulletView = [[MMBulletView alloc] initWithFrame:CGRectMake(self.configuration.targetView.width, indexOfTrack*self.configuration.eachBulletViewHeight, [self.widthArr[0] floatValue], self.configuration.eachBulletViewHeight)];
//    bulletView.indexOfTracks = indexOfTrack;
//    bulletView.model = self.sourceArr[0];
//    [self.configuration.targetView addSubview:bulletView];
//     bulletView.movementStatus = ^(MMBulletViewStatus status,NSUInteger indexOfTracks) {
//        switch (status) {
//            case MMBulletViewStatusStart:{
//                NSLog(@"开始了");
//                break;}
//            case MMBulletViewStatusEnter:{
//                NSLog(@"进入到屏幕");
//                break;}
//            case MMBulletViewStatusEnd:{
//                 NSLog(@"离开了屏幕");
//                if (![self.trackArray containsObject:@(indexOfTrack)]) {
//                     [self.trackArray addObject:@(indexOfTrack)];
//                }
//                break; }
//            default:
//                break;
//        }
//    };
//    [bulletView srartWithAnimationDuration:self.configuration.duration animationScreenWidth:CGRectGetWidth(self.configuration.targetView.frame)];
}

- (MMDanMakuModel *)_getFirstModel {
    MMDanMakuModel *model = [self.sourceArr firstObject];
    return model;
}
- (void)go {
    self.isBeingExecuted = YES;
    NSUInteger indexOfTrack ;
    if ((indexOfTrack = [self _getIndexOfTracks]) == -1 || self.sourceArr.count == 0) {
        self.isBeingExecuted = NO;
        return;
    }

//    while ((indexOfTrack = [self _getIndexOfTracks])!= -1 && self.sourceArr.count != 0) {
        [self.trackArray removeObject:@(indexOfTrack)];
        MMBulletView *bulletView = [[MMBulletView alloc] initWithFrame:CGRectMake(self.configuration.targetView.width, indexOfTrack*self.configuration.eachBulletViewHeight, [self.widthArr[0] floatValue], self.configuration.eachBulletViewHeight)];
        [self.widthArr removeObjectAtIndex:0];
        bulletView.indexOfTracks = indexOfTrack;
        bulletView.model = [self _getFirstModel];
        [self.sourceArr removeObjectAtIndex:0];
        [self.configuration.targetView addSubview:bulletView];
        bulletView.movementStatus = ^(MMBulletViewStatus status,NSUInteger indexOfTracks) {
            switch (status) {
                case MMBulletViewStatusStart:{

                    break;}
                case MMBulletViewStatusEnter:{

                    if (![self.trackArray containsObject:@(indexOfTrack)]) {
                        [self.trackArray addObject:@(indexOfTrack)];
                    }
                    break;}
                case MMBulletViewStatusEnd:{
//                    NSLog(@"离开了屏幕");
                    if (self.isBeingExecuted == NO) {
                        [self go];
                    }
                    break; }
                default:
                    break;
            }
        };
    [bulletView srartWithAnimationDuration:self.configuration.duration animationScreenWidth:CGRectGetWidth(self.configuration.targetView.frame)];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self go];
    });
}

- (NSInteger)_getIndexOfTracks {
    if (self.trackArray.count == 0)  return -1;
    NSUInteger randomIndex = random()%self.trackArray.count;
    NSInteger indexOfTracks = [self.trackArray[randomIndex] integerValue];
    return indexOfTracks;
}

- (void)pause {
    NSLog(@"暂停");
}

- (void)stop {
    NSLog(@"结束");
}
@end
