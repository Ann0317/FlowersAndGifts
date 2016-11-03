//
//  WXDPromptPullOrDownView.m
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/10/27.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import "WXDPromptPullOrDownView.h"

@implementation WXDPromptPullOrDownView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createSubViews {
    
    UIView *leftLineView = [[UIView alloc] init];
    [self addSubview:leftLineView];
    leftLineView.backgroundColor = kColorWithRGB(219, 220, 224);
    
    UIView *rightLineView = [[UIView alloc] init];
    [self addSubview:rightLineView];
    rightLineView.backgroundColor = kColorWithRGB(219, 220, 224);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.title;
    label.font = [UIFont systemFontOfSize:11];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    [self addSubview:label];
    
    CGSize labelSize = [self labelSizeWithString:self.title withJustSize:CGSizeMake(999, self.imageHeight) withFontSize:11];
//    NSLog(@"%f,%f",labelSize.width,labelSize.height);
    
    CGFloat lineWidth = (Screenwidth - 10 * 4 - self.imageHeight - 3 - labelSize.width)/2;
    
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_offset(lineWidth);
        make.height.mas_offset(1);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftLineView.mas_centerY);
        make.width.mas_offset(lineWidth);
        make.height.mas_offset(1);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftLineView.mas_centerY);
        make.width.height.mas_offset(self.imageHeight);
        make.left.equalTo(leftLineView.mas_right).offset(10);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftLineView.mas_centerY);
        make.width.mas_offset(labelSize.width);
        make.height.mas_offset(self.imageHeight);
        make.right.equalTo(rightLineView.mas_left).offset(-10);
        make.left.equalTo(imageView.mas_right).offset(3);
    }];
    

}

- (CGSize)labelSizeWithString:(NSString *)string withJustSize:(CGSize)size withFontSize:(CGFloat)fontSize{
    CGSize labelSize;
    labelSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
    return labelSize;
}

@end
