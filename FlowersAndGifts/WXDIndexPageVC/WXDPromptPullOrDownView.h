//
//  WXDPromptPullOrDownView.h
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/10/27.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXDPromptPullOrDownView : UIView
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,assign)CGFloat imageHeight;

- (void)createSubViews;
@end
