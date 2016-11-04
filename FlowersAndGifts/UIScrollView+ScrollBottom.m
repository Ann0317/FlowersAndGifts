//
//  UIScrollView+ScrollBottom.m
//  ZYY_ScrollViewDemo
//
//  Created by Tech-zhangyangyang on 2016/10/28.
//  Copyright © 2016年 Tech-zhangyangyang. All rights reserved.
//

#import "UIScrollView+ScrollBottom.h"
#import <objc/runtime.h>
@implementation UIScrollView (ScrollBottom)

static char *ScrollBottomKey = "ScrollBottomKey";
- (void)setScrollBottomBlock:(void (^)())scrollBottomBlock {
    objc_setAssociatedObject(self, ScrollBottomKey, scrollBottomBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)())scrollBottomBlock {
    return objc_getAssociatedObject(self, ScrollBottomKey);
}

- (void)scrollviewScrollBottom:(void (^)(void))block {
    CGFloat height             = self.frame.size.height;
    CGFloat contentYoffset     = self.contentOffset.y;
    CGFloat distanceFromBottom = self.contentSize.height - contentYoffset;
    //NSLog(@"height:%f contentYoffset:%f frame.y:%f",height,contentYoffset,self.frame.origin.y);
    self.scrollBottomBlock = block;
    if (distanceFromBottom == height) {
        self.scrollBottomBlock();
    }
}

@end
