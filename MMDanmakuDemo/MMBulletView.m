//
//  MMBulletView.m
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "MMBulletView.h"
#import "MMDanmakuHeader.h"

@interface MMBulletView ()
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation MMBulletView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleFingerEvent)];
         singleFingerOne.numberOfTouchesRequired = 1; //手指数
         singleFingerOne.numberOfTapsRequired = 1; //tap次数
        [self addGestureRecognizer:singleFingerOne];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了");
}
- (void)handleSingleFingerEvent {
     NSLog(@"点击了");
}
- (void)setModel:(MMDanMakuModel *)model {
    _model = model;
    self.title.text = model.title;
    self.imageView.image = [UIImage imageNamed:model.imageName];
    //layout
    self.title.frame = self.bounds;
}

- (void)setInitFrameWithIndexOfTracks:(NSUInteger)index animationScreenWidth:(CGFloat)Width{

}

- (void)srartWithAnimationDuration:(NSTimeInterval)duration animationScreenWidth:(CGFloat)Width {
    self.animationDuration  = duration;
    CGFloat totalWidth = self.width + Width;
    CGFloat speed = totalWidth/self.animationDuration;
    CGFloat timeToenterScreenCompletely = self.width/speed;
    
    if (self.movementStatus) {
        self.movementStatus(MMBulletViewStatusStart,self.indexOfTracks);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeToenterScreenCompletely * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        if (self.movementStatus) {
            self.movementStatus(MMBulletViewStatusEnter,self.indexOfTracks);
        }
    });
    
    __block CGRect frame  = self.frame;
    
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
      frame.origin.x = -CGRectGetWidth(frame);
      self.frame = frame;
    } completion:^(BOOL finished) {
        if (self.movementStatus) {
            self.movementStatus(MMBulletViewStatusEnd,self.indexOfTracks);
        }
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
    
    
  
}

- (void)stopAnimation {
    
}
#pragma mark - get
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentRight;
        [self addSubview:_title];
    }
    return _title;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}
@end
