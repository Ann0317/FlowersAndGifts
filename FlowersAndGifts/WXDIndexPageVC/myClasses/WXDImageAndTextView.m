//
//  WXDImageAndTextView.m
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/10/21.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import "WXDImageAndTextView.h"

@implementation WXDImageAndTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)createImageAndLabel {
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:nil];
    UILabel *label = [[UILabel alloc] init];
    label.text = self.model.name;
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(self.ImageSize.width);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.labelSize.width);
        make.height.mas_equalTo(self.labelSize.height);
    }];
}

@end
