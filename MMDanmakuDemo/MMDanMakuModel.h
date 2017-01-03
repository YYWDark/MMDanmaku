//
//  MMDanMakuModel.h
//  MMDanmakuDemo
//
//  Created by wyy on 16/12/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, MMDanMakuDataType) {
    MMDanMakuDataTypeNormal      = 0,      //非会员
    MMPopupViewDisplayTypeMember = 1,  //会员
};

typedef NS_ENUM(NSUInteger, MMDanMakuAppearanceType) {
    MMDanMakuAppearanceLeft  = 0,           //左边
    MMDanMakuAppearanceHorizonCenter  = 1,  //中间
};

@interface MMDanMakuModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) BOOL isMyself;
@property (nonatomic, assign) MMDanMakuDataType dataType;
@property (nonatomic, assign) MMDanMakuAppearanceType appearanceType;

+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                      isMyself:(BOOL)isMyself
                      dataType:(MMDanMakuDataType)dataType
                appearanceType:(MMDanMakuAppearanceType)appearanceType;
@end
