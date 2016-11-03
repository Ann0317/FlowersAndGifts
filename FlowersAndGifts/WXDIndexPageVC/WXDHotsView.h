//
//  WXDHotsView.h
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/10/24.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXDHotsView : UIView
@property (nonatomic,strong)UILabel *groupNameLabel;//分组的名字label
@property (nonatomic,strong)NSString *groupName;//分组的名字
@property (nonatomic,strong)UIButton *moreBtn;//显示更多按钮
@property (nonatomic,strong)NSArray *dataArray;//所需数据的数组
@property (nonatomic,assign)NSInteger count;//一行的列数
@property (nonatomic,assign)CGFloat space;//列间距

- (void)createHotsView;

@end
