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
    }
    return self;
}

- (void)setModel:(MMDanMakuModel *)model {
    _model = model;
    self.title.text = model.title;
    self.title.textColor = _model.dataType?[UIColor colorWithHexString:memberColorHex]:[UIColor colorWithHexString:normalColorHex];
//    self.imageView.image = [UIImage imageNamed:model.imageName];
    //layout
    self.title.frame = self.bounds;
    if (self.model.appearanceType == MMDanMakuAppearanceHorizonCenter) {
        self.title.textColor = [UIColor randomColor];
    }
}
- (void)setInitFrameWithIndexOfTracks:(NSUInteger)index animationScreenWidth:(CGFloat)Width{

}

- (void)srartWithAnimationDuration:(NSTimeInterval)duration animationScreenWidth:(CGFloat)Width {
    
    self.animationDuration  = duration;
    CGFloat totalWidth = self.width + Width;
    CGFloat speed = totalWidth/self.animationDuration;
    CGFloat timeToenterScreenCompletely = self.width/speed;
    
    if (self.movementStatus) {
        self.movementStatus(MMBulletViewStatusStart,self.indexOfTracks,self);
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeToenterScreenCompletely * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.movementStatus) {
            self.movementStatus(MMBulletViewStatusEnter,self.indexOfTracks,self);
        }
    });
    
    __block CGRect frame  = self.frame;
    
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
        if ( _model.appearanceType == MMDanMakuAppearanceLeft) {
            frame.origin.x = -CGRectGetWidth(frame);
            self.frame = frame;
        }else {
//            self.alpha = .99;
            frame.size.width += 2;
            self.frame = frame;
         }
    } completion:^(BOOL finished) {
        if (self.movementStatus) {
            self.movementStatus(MMBulletViewStatusEnd,self.indexOfTracks,self);
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
        _title.font = [UIFont systemFontOfSize:14];
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
