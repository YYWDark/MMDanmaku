//
//  ViewController.m
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "MMDanmakuManger.h"
#import "MMDanmakuHeader.h"

@interface ViewController () <MMDanmakuMangerDataSource,MMDanmakuMangerDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) MMDanmakuManger *manger;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, assign) NSInteger mark;  //从来标记第多少个,配合假数据显示
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height )];
    imageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.view insertSubview:imageView atIndex:0];
   
    self.dataArr = [NSMutableArray array];
    self.mark = 0;
    for (int i = 0; i < 10; i++) {
        MMDanMakuModel *model = [MMDanMakuModel modelWithTitle:[NSString stringWithFormat:@"%@--%ld",self.array[random()%self.array.count],self.mark] imageName:@"" isMyself:i%2 dataType:(i%5)?MMDanMakuDataTypeNormal:MMPopupViewDisplayTypeMember appearanceType:(i%18)?MMDanMakuAppearanceLeft:MMDanMakuAppearanceHorizonCenter];
        [self.dataArr addObject:model];
        self.mark++;
    }
    
    MMConfiguration *configuration = [MMConfiguration configurationAimationDuration:8 targetView:self.view restartType:MMDanMakuRestartTypeFromLastState];
    self.manger = [[MMDanmakuManger alloc] initWithConfiguration:configuration];
    self.manger.dataSource = self;
    self.manger.delegate = self;
    [self.manger packageData];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                              target:self
                                            selector:@selector(timerFire:)
                                            userInfo:nil
                                             repeats:YES];
    [timer fire];
}

#pragma mark - Action
- (void)timerFire:(NSTimer *)timer {
    for (int i = 0; i < (MAX(5, random() % 50)); i++) {
        MMDanMakuModel *model = [MMDanMakuModel modelWithTitle:[NSString stringWithFormat:@"%@--%ld",self.array[random()%self.array.count],self.mark] imageName:@"" isMyself:i%2 dataType:(i%5)?MMDanMakuDataTypeNormal:MMPopupViewDisplayTypeMember appearanceType:(i%18)?MMDanMakuAppearanceLeft:MMDanMakuAppearanceHorizonCenter];
        [self.dataArr addObject:model];
        self.mark++;
    }
    [self.manger appendData];
}

- (IBAction)valueChange:(id)sender {
    UISwitch *switchView = (UISwitch *)sender;
    if (switchView.on == YES) {
        [self.manger  start];
    }else {
        [self.manger  stop];
    }
}

//设置后会有点击效果
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];  //获取点击内容
    CGPoint point = [touch locationInView:self.view];
    if (self.manger.tapBlock) {
        self.manger.tapBlock(point);
    }
}

#pragma mark - MMDanmakuMangerDataSource
- (NSUInteger)numberOfItemsControlleredByDanmakuManger:(MMDanmakuManger *)manger {
   return self.dataArr.count;
}

- (MMDanMakuModel *)danmakuManger:(MMDanmakuManger *)manger informationForItem:(NSUInteger)index {
    return self.dataArr[index];
}

#pragma mark - MMDanmakuMangerDelagate
- (void)danmakuManger:(MMDanmakuManger *)manger didSelectedItem:(MMDanMakuModel *)model {
    NSLog(@"点击了:%@",model.title);
}

#pragma mark - Get
- (NSArray *)array {
    if (_array == nil) {
        _array = @[@"红尘初妆，山河无疆。最初的面庞，碾碎梦魇无常，命格无双",
                   @"233333",
                   @"念往昔，繁华竞逐",@"人天自两空，何相忘，何笑何惊人",
                   @"人生真的撕心裂肺并非是分离，也并非是你身体承受多大的痛楚，而是你内心那种无声的哭泣",
                   @"残阳退没",
                   @"那被岁月覆盖的花开，一切白驹过隙成为空白",
                   @"彼年豆蔻",
                   @"66666666666",
                   @"如花美眷，似水流年",
                   @"蝴蝶飞不过沧海",
                   @"我要去接陈*诚的锅",
                   @"人生若只如初见",
                   @"这个冬天没有给我惊喜",
                   @"年少轻狂",
                   @"不疯魔，不成活",
                   @"嘘……",
                   @"王炸",
                   @"我在过马路",
                   ];
    }
    return _array;
}
@end
