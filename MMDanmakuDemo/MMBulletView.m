//
//  MMBulletView.m
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "MMBulletView.h"

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
    self.imageView.image = [UIImage imageNamed:model.imageName];
    
    //layout
    
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
