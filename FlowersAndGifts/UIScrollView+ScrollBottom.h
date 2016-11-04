//
//  UIScrollView+ScrollBottom.h
//  ZYY_ScrollViewDemo
//
//  Created by Tech-zhangyangyang on 2016/10/28.
//  Copyright © 2016年 Tech-zhangyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ScrollBottom)

@property (nonatomic, copy) void(^scrollBottomBlock)();

- (void)scrollviewScrollBottom:(void (^)(void))block;

@end
