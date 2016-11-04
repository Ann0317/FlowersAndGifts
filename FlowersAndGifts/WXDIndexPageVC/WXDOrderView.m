//
//  WXDOrderView.m
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/11/3.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import "WXDOrderView.h"
#import "WXDIndexModel.h"
@implementation WXDOrderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createOrderViews {
    
    for (int i = 0; i < self.dataArray.count; i++) {
        WXDIndexModel *model = self.dataArray[i];
        
        NSInteger rowNum = i / self.count;
        NSInteger colNum = i % self.count;
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.width);
            make.height.mas_equalTo(self.height);
            make.left.equalTo(self.mas_left).offset(self.space + colNum * (self.space + self.width));
            make.top.equalTo(self.mas_top).offset( rowNum * (self.space + self.height));
            
        }];
        [self createHotsViewDetailwithSuperView:view withViewSize:CGSizeMake(self.width, self.height) withModel:model];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
        [view addGestureRecognizer:tap];
    }
}

- (void)tapClicked:(UIResponder *)responder {
    NSLog(@"??????");
}

- (void)createHotsViewDetailwithSuperView:(UIView *)view withViewSize:(CGSize)size withModel:(WXDIndexModel *)model{
    UIImageView *imageView = [[UIImageView alloc] init];
    [view addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = model.name;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = model.price;
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:priceLabel];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(10);
        make.right.equalTo(view.mas_right).offset(-10);
        make.top.equalTo(view.mas_top).offset(10);
        make.width.mas_equalTo(size.width - 20);
        make.height.mas_equalTo(size.width);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.equalTo(imageView);
        make.top.equalTo(nameLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    
}


@end
