//
//  WXDOrderView.h
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/11/3.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXDOrderView : UIView
@property (nonatomic,strong)NSArray *dataArray;//所需数据的数组
@property (nonatomic,assign)NSInteger count;//一行的列数
@property (nonatomic,assign)CGFloat space;//列间距
@property (nonatomic,assign)CGFloat width;//宽
@property (nonatomic,assign)CGFloat height;//高

- (void)createOrderViews;

@end
