# MMDanmaku
##前言
其实在github上已经有了很优秀的弹幕开源控件[HJDanmaku](https://github.com/panghaijiao/HJDanmakuDemo),那为什么要重复造轮子呢?主要考虑到以下方面：
1.重用机制。
2.弹幕的点击响应。

### 如何实现点击效果
我们知道一部电影的弹幕可能有千千万条，我想你肯定不想初始化那么多视图，所以重用机制是非常必要性的。至于弹幕的点击响应，你可能尝试过在视图动画的时候为UIview添加手势或者直接调用touchesBegan，但发现并没有什么用。所以我们这里是采用其他的方式实现弹幕的响应：
1.将控制器里面拿到的point点回调给管理类`MMDanmakuManger`。
```
//设置后会有点击效果
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
UITouch *touch = [touches anyObject];  //获取点击内容
CGPoint point = [touch locationInView:self.view];
if (self.manger.tapBlock) {
self.manger.tapBlock(point);
}
}
```
2.我们在弹幕控件中我们会根据显示的区域(可以根据配置类topMargin,bottomMargin调整显示区域)，和每个弹幕的高度`eachBulletViewHeight`，把显示的区域划分为一条条弹道。管理类会持有`displayingDic`，来记录每个显示区域每个弹道上的视图。这个时候你需要知道对于视图的presentationLayer 和 layer之间的关系。简单来说就是做`UIView frame`改变动画，你发现`layer`只有开始值和结束值，而`presentationLayer`会持续显示过程值。你可以点击[这里](http://www.jianshu.com/p/1efb0238c1dd)来进一步了解之间额关系。然后根据弹道的key来取`displayingDic`的视图数组,判断该点是否在该视图的presentationLayer frame里面。


### 控件
![控件结构图.png](http://upload-images.jianshu.io/upload_images/307963-3715524d96791ae9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
初始化方式：
```
MMConfiguration *configuration = [MMConfiguration configurationAimationDuration:8 targetView:self.view restartType:MMDanMakuRestartTypeFromLastState];
self.manger = [[MMDanmakuManger alloc] initWithConfiguration:configuration];
self.manger.dataSource = self;
self.manger.delegate = self;
[self.manger packageData];
```
设置点击：
```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
UITouch *touch = [touches anyObject];  //获取点击内容
CGPoint point = [touch locationInView:self.view];
if (self.manger.tapBlock) {
self.manger.tapBlock(point);
}
}
```
协议
```
包装数据
#pragma mark - MMDanmakuMangerDataSource
- (NSUInteger)numberOfItemsControlleredByDanmakuManger:(MMDanmakuManger *)manger {
return self.dataArr.count;
}

- (MMDanMakuModel *)danmakuManger:(MMDanmakuManger *)manger informationForItem:(NSUInteger)index {
return self.dataArr[index];
}
回调点击效果
#pragma mark - MMDanmakuMangerDelagate
- (void)danmakuManger:(MMDanmakuManger *)manger didSelectedItem:(MMDanMakuModel *)model {
NSLog(@"点击了:%@",model.title);
}
```
Demo中利用定时器来模仿用户输入追加数据：
```
[self.manger appendData];
```

![1.gif](http://upload-images.jianshu.io/upload_images/307963-90280ffdce13a8ff.gif?imageMogr2/auto-orient/strip)


