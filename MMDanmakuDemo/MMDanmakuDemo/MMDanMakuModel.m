//
//  MMDanMakuModel.m
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "MMDanMakuModel.h"

@implementation MMDanMakuModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataType = MMDanMakuDataTypeNormal;
        self.appearanceType = MMDanMakuAppearanceLeft;
    }
    return self;
}

+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                      isMyself:(BOOL)isMyself
                      dataType:(MMDanMakuDataType)dataType
                appearanceType:(MMDanMakuAppearanceType)appearanceType {
    MMDanMakuModel *model = [[MMDanMakuModel alloc] init];
    model.title = title;
    model.imageName = imageName;
    model.isMyself = isMyself;
    model.dataType = dataType;
    model.appearanceType = appearanceType;
    return model;
}
@end
