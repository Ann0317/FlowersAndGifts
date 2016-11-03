//
//  WXDImageAndTextView.h
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/10/21.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXDIndexModel.h"

@interface WXDImageAndTextView : UIView
@property (nonatomic,strong)NSString *imageStr;//图片的url
@property (nonatomic,strong)NSString *name;//跟图片对应class的名字
@property (nonatomic,assign)CGSize ImageSize;//图片尺寸
@property (nonatomic,assign)CGSize labelSize;//label尺寸
@property (nonatomic,strong)WXDIndexModel *model;


- (void)createImageAndLabel;

@end
