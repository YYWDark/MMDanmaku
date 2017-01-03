//
//  ViewController.m
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "MMDanmakuManger.h"

@interface ViewController () <MMDanmakuMangerDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        MMDanMakuModel *model = [MMDanMakuModel modelWithTitle:[NSString stringWithFormat:@"我是第%d条数据",i] imageName:@"" isMyself:i%2 dataType:MMDanMakuDataTypeNormal appearanceType:MMDanMakuAppearanceLeft];
        [self.dataArr addObject:model];
    }
    
    
    MMConfiguration *configuration = [MMConfiguration configurationAimationDuration:2.5 targetView:self.view restartType:MMDanMakuRestartTypeFromTheBeginning];
    MMDanmakuManger *manger = [[MMDanmakuManger alloc] initWithConfiguration:configuration];
    manger.dataSource= self;
    [manger packageData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - MMDanmakuMangerDataSource
- (NSUInteger)numberOfItemsControlleredByDanmakuManger:(MMDanmakuManger *)manger {
   return self.dataArr.count;
}
- (MMDanMakuModel *)danmakuManger:(MMDanmakuManger *)manger informationForItem:(NSUInteger)index {
    return self.dataArr[index];
}
@end
