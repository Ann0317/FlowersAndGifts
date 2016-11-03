//
//  WXDIndexModel.h
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/10/24.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXDIndexModel : NSObject
@property (nonatomic,strong)NSString *href;//html5
@property (nonatomic,strong)NSString *image;//礼品图片
@property (nonatomic,strong)NSString *name;//礼品的名字
@property (nonatomic,strong)NSString *type;//礼品类型
@property (nonatomic,strong)NSString *cid;//礼品的id
@property (nonatomic,strong)NSString *price;//礼品价格
@end
