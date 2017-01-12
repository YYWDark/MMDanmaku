//
//  MMDanmakuManger.m
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

//转换后
#import "MMDanmakuManger.h"
#import "MMDanmakuHeader.h"
#import "MMBulletView.h"

@interface MMDanmakuManger ()
@property (nonatomic, strong) NSMutableArray *widthArr;
@property (nonatomic, strong) NSMutableArray *sourceArr;
@property (nonatomic, strong) NSMutableArray *cacheArr;      //缓存复用
@property (nonatomic, strong) NSMutableArray *trackArray;    //记录弹道
@property (nonatomic, strong) NSMutableDictionary *displayingDic; //
@property (nonatomic, assign) BOOL isBeingExecuted;
@property (nonatomic, assign) NSUInteger index;              //出现弹幕的序列号
@end

@implementation MMDanmakuManger
- (instancetype)init {
    self = [super init];
    if (self) {
        self.widthArr = [NSMutableArray array];
        self.sourceArr = [NSMutableArray array];
        self.cacheArr = [NSMutableArray array];
        self.trackArray = [NSMutableArray array];
        self.displayingDic = [NSMutableDictionary dictionary];
        
        __weak typeof(self) weakself = self;
        self.tapBlock = ^(CGPoint point) {
            NSUInteger index =  point.y/weakself.configuration.eachBulletViewHeight;
            NSString *key = [NSString stringWithFormat:@"%lu",index];
            NSMutableArray *arr = weakself.displayingDic[key];
                for (MMBulletView *view in arr) {
                    CGRect rect = view.layer.presentationLayer.frame;
                    if (rect.origin.x <= point.x && (rect.origin.x + rect.size.width) >= point.x ) {
                       NSLog(@"点击了第%ld个视图",view.tag);
                    }
                }
        };
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

#pragma mark - Public Method
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

- (void)start {
    if (self.isStarted) return;
    [self _updateStatusStart:YES isPaused:NO isFinished:NO];
    [self go];
}

- (void)pause {
    NSLog(@"暂停");
    
}

- (void)stop {
    NSLog(@"结束");
    for (UIView *view in self.configuration.targetView.subviews) {
        if ([view isMemberOfClass:[MMBulletView class]]) {
          [view removeFromSuperview];  
        }
    }
    [self _updateStatusStart:NO isPaused:NO isFinished:YES];
    
}

#pragma mark - Private Method
- (void)_updateStatusStart:(BOOL)isStarted isPaused:(BOOL)isPaused isFinished:(BOOL)isFinished {
    self.isFinished = isFinished;
    self.isPaused = isPaused;
    self.isStarted = isStarted;
}

- (BOOL)_isContainedKey:(NSString *)key {
    if ([self.displayingDic.allKeys containsObject:key]) {
        return YES;
    }
    return NO;
}

- (NSInteger)_getIndexOfTracks {
    if (self.trackArray.count == 0)  return -1;
    NSUInteger randomIndex = random()%self.trackArray.count;
    NSInteger indexOfTracks = [self.trackArray[randomIndex] integerValue];
    return indexOfTracks;
}


- (void)go {
    
    NSUInteger indexOfTrack;
    
    if (((indexOfTrack = [self _getIndexOfTracks]) == -1 || self.index >= self.sourceArr.count)||self.isPaused == YES || self.isFinished == YES) {
        self.isBeingExecuted = NO;
        return;
    }
    self.isBeingExecuted = YES;
        //从弹道数组里面移除该该弹道，待该视图完全进入到显示屏幕再加回来该弹道
        [self.trackArray removeObject:@(indexOfTrack)];
        //生成弹幕视图
        MMBulletView *bulletView;
    if (self.cacheArr.count != 0 && self.configuration.isNeedReuse == YES) {
        bulletView  = [self.cacheArr firstObject];
        [self.cacheArr removeObjectAtIndex:0];
    }
    if (bulletView == nil) {
        bulletView = [[MMBulletView alloc] init];
    }
   
        bulletView.frame = CGRectMake(self.configuration.targetView.width, indexOfTrack*self.configuration.eachBulletViewHeight, [self.widthArr[self.index] floatValue], self.configuration.eachBulletViewHeight);
        MMDanMakuModel *model = self.sourceArr[self.index];
    
    if (model.appearanceType == MMDanMakuAppearanceHorizonCenter) {
        bulletView.centerX = self.configuration.targetView.centerX;
    }
    
        bulletView.indexOfTracks = indexOfTrack;
        bulletView.model = model;
        bulletView.tag = self.index;
        [self.configuration.targetView addSubview:bulletView];
        bulletView.movementStatus = ^(MMBulletViewStatus status,NSUInteger indexOfTracks,MMBulletView *view) {
            switch (status) {
                case MMBulletViewStatusStart:{
                    //将出现的视图根据轨道编号添加字典中，当点击时候直接取出相应轨道的数组来遍历。
                    NSString *key = [NSString stringWithFormat:@"%lu",indexOfTrack];
                    if ([self _isContainedKey:key]) {
                        NSMutableArray *arr =  self.displayingDic[key];
                        [arr addObject:view];
                    }else {
                        NSMutableArray *arr = [NSMutableArray array];
                        [arr addObject:view];
                        [self.displayingDic setObject:arr forKey:key];
                    }
                    break;}
                case MMBulletViewStatusEnter:{
                    if (![self.trackArray containsObject:@(indexOfTrack)]) {
                        [self.trackArray addObject:@(indexOfTrack)];
                    }
                    break;}
                case MMBulletViewStatusEnd:{
                    //将消失的视图从字典中移除掉。
                    NSString *key = [NSString stringWithFormat:@"%lu",indexOfTrack];
                    if ([self _isContainedKey:key]) {
                        [self.displayingDic[key] removeObject:view];
                    }
                    //将消息的视图添加到缓存数组中，这样直接先从缓存来拿，拿不到再创建
                    [self.cacheArr addObject:view];
                    if (self.isBeingExecuted == NO) { //如果因为轨道满了停止了则继续递归
                        [self go];
                    }
                    break; }
                default:
                    break;
            }
        };
    [bulletView srartWithAnimationDuration:self.configuration.duration animationScreenWidth:CGRectGetWidth(self.configuration.targetView.frame)];
    self.index ++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.configuration.durationOfProduction * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self go];
    });
}







@end
