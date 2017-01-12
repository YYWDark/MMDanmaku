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
@property (nonatomic, strong) MMDanmakuManger *manger;

@end

@implementation ViewController
/*
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
 {
 UITouch *touch = [touches anyObject];
 CGPoint touchLocation = [touch locationInView:self.view];
 for (UIButton *button in self.buttonsOutletCollection)
 {
 if ([button.layer.presentationLayer hitTest:touchLocation])
 {
 // This button was hit whilst moving - do something with it here
 break;
 }
 }
 }
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    for (int i = 0; i < 1000; i++) {
        MMDanMakuModel *model = [MMDanMakuModel modelWithTitle:[NSString stringWithFormat:@"我是第%d条数据",i] imageName:@"" isMyself:i%2 dataType:MMDanMakuDataTypeNormal appearanceType:MMDanMakuAppearanceLeft];
        [self.dataArr addObject:model];
    }
    
    MMConfiguration *configuration = [MMConfiguration configurationAimationDuration:20 targetView:self.view restartType:MMDanMakuRestartTypeFromTheBeginning];
    self.manger = [[MMDanmakuManger alloc] initWithConfiguration:configuration];
    self.manger.dataSource= self;
    [self.manger packageData];
}

- (IBAction)start:(UIButton *)sender {
    [self.manger start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - MMDanmakuMangerDataSource
- (NSUInteger)numberOfItemsControlleredByDanmakuManger:(MMDanmakuManger *)manger {
   return self.dataArr.count;
}
- (MMDanMakuModel *)danmakuManger:(MMDanmakuManger *)manger informationForItem:(NSUInteger)index {
    return self.dataArr[index];
}
@end
