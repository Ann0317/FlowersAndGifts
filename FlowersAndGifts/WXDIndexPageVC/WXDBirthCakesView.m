//
//  WXDBirthCakesView.m
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/10/25.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import "WXDBirthCakesView.h"
#import "WXDIndexModel.h"

@interface WXDBirthCakesView ()
@property (nonatomic,strong)UIView *whiteView;
@property (nonatomic,strong)UIButton *birthCakeBtn;//生日蛋糕系列
@end

@implementation WXDBirthCakesView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)createBirthCakesView {
    self.whiteView = [[UIView alloc] init];
    [self addSubview:self.whiteView];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(50);
    }];
    self.groupNameLabel = [[UILabel alloc] init];
    self.groupNameLabel.text = self.groupName;
    self.groupNameLabel.font = [UIFont systemFontOfSize:14];
    self.groupNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.whiteView addSubview:self.groupNameLabel];
    [self.groupNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_top).offset(10);
        make.left.equalTo(self.whiteView.mas_left).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.moreBtn setTitleColor:kColorWithRGB(170, 169, 174) forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(moreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.moreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.whiteView addSubview:self.moreBtn];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_top).offset(10);
        make.right.equalTo(self.whiteView.mas_right).offset(-10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    if (self.isHasPic) {
        self.birthCakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.birthCakeBtn setFrame:CGRectMake(10, 33, 10, 18)];
        
        [self.birthCakeBtn addTarget:self action:@selector(birthCakeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        WXDIndexModel *model = self.dataArray[0];
        [self.birthCakeBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal placeholderImage:nil];
        [self addSubview:self.birthCakeBtn];
        
        [self.birthCakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.whiteView.mas_bottom).offset(0);
            make.left.right.equalTo(self.whiteView);
            make.height.mas_equalTo(80);
        }];
        
    }
    
    CGFloat number = 0;
    if (self.isHasPic) {
       number = self.dataArray.count - 1;
    } else  {
        number = self.dataArray.count;
    }
    
    for (int i = 0; i < number; i++) {
        WXDIndexModel *birthModel;
        if (self.isHasPic) {
            birthModel = self.dataArray[i + 1];
        } else {
            birthModel = self.dataArray[i];
        }
        NSInteger rowNum = i / self.count;
        NSInteger colNum = i % self.count;
//        NSLog(@"index is:%d and row:%ld,col:%ld",i,rowNum,colNum);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:btn];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:birthModel.image] forState:UIControlStateNormal placeholderImage:nil];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.viewSize.width);
            make.height.mas_equalTo(self.viewSize.height);
            make.left.equalTo(self.mas_left).offset(colNum * (self.space + self.viewSize.width));
            if (self.isHasPic) {
                make.top.equalTo(self.birthCakeBtn.mas_bottom).offset(rowNum * (self.space + self.viewSize.height));
            } else  {
                make.top.equalTo(self.whiteView.mas_bottom).offset(self.space + rowNum * (self.space + self.viewSize.height));
            }
            
        }];
        
    }
}


- (void)moreBtnClicked {
    
}

- (void)tapClicked:(UIResponder *)responder {
    NSLog(@"??????");
}


- (void)birthCakeBtnClicked {
    
}



@end
