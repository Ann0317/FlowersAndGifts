//
//  ViewController.m
//  FlowersAndGifts
//
//  Created by 网络中心 on 16/10/14.
//  Copyright © 2016年 网络中心. All rights reserved.
//

#import "ViewController.h"
#import "HYBLoopScrollView.h"
#import "WXDImageAndTextView.h"
#import "WXDIndexModel.h"

#import "WXDHotsView.h"
#import "WXDBirthCakesView.h"
#import "WXDPromptPullOrDownView.h"
#import "UIScrollView+ScrollBottom.h"
#import "WXDOrderView.h"

//#define WS(weakSelf)  __weak __typeof(&*self) weakSelf = self;

@interface ViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *bottomScroll;//位于最底的滑动视图
@property (nonatomic,strong)UIScrollView *singleScroll;//单品推荐的滑动视图
@property (nonatomic,strong)UIView *guidView;//导航条
@property (nonatomic,strong)HYBLoopScrollView *loopScroll;//上边的轮播图
@property (nonatomic,strong)WXDBirthCakesView *birthCakeView;//生日礼物列的视图
@property (nonatomic,strong)WXDHotsView *hotsView;//热卖礼品
@property (nonatomic,strong)WXDBirthCakesView *giftView;//特色礼品视图
@property (nonatomic,strong)UIView *aboutView;//关于的视图
@property (nonatomic,strong)UIButton *contactView;//联系我们视图
@property (nonatomic,strong)WXDPromptPullOrDownView *topPromptView;//上边提示上拉的小视图
@property (nonatomic,strong)WXDPromptPullOrDownView *bottomPromptView;//下边提示上拉的小视图
@property (nonatomic,strong)UIScrollView *recommendScroll;//推荐的滑动视图
@property (nonatomic,strong)WXDOrderView *recommendView;//推荐视图


@property (nonatomic,strong)NSDictionary *dataDict;//存放数据的字典
@property (nonatomic,strong)NSMutableArray *loopPics;//轮播图图片数组
@property (nonatomic,strong)NSMutableArray *classesArr;//种类数组
@property (nonatomic,strong)NSMutableArray *featuresArr;//特色数组
@property (nonatomic,strong)NSMutableArray *hotsArr;//热卖礼品数组
@property (nonatomic,strong)NSMutableArray *birthsArray;//生日礼品数组
@property (nonatomic,strong)NSMutableArray *giftsArray;//特色礼品数组
@property (nonatomic,strong)NSMutableArray *aboutArray;//关于的数组
@property (nonatomic,strong)NSMutableArray *contactArray;//联系我们数组
@property (nonatomic,strong)NSMutableArray *recommendarray;//推荐的数组

@property (nonatomic,assign)CGFloat pullHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1、先创建UI
    [self configUI];
    
    //2、初始化数据（字典，数组）
    [self initWithData];
    
    //3.下载数据
    [self downLoadData];
    
}

- (void)initWithData {
    self.dataDict = [[NSDictionary alloc] init];
    self.loopPics = [NSMutableArray array];
    self.classesArr = [NSMutableArray array];
    self.featuresArr = [NSMutableArray array];
    self.hotsArr = [NSMutableArray array];
    self.birthsArray = [NSMutableArray array];
    self.giftsArray = [NSMutableArray array];
    self.aboutArray = [NSMutableArray array];
    self.contactArray = [NSMutableArray array];
    self.recommendarray = [NSMutableArray array];
}

- (void)downLoadData {
    //初始化manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:IndexUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //这里获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
//        NSLog(@"%@",responseObject);
        
        self.dataDict = [responseObject mutableObjectFromJSONData];
        NSLog(@"----->>>>>%@",self.dataDict);
        
        for (NSDictionary *loopImagesDict in self.dataDict[@"images"]) {
            [self.loopPics addObject:loopImagesDict[@"image"]];
        }
        //创建轮播图
        [self createLoopScroll];
        
        for (NSDictionary *classesDict in self.dataDict[@"classes"]) {
            WXDIndexModel *model = [[WXDIndexModel alloc] init];
            model.image = classesDict[@"image"];
            model.name = classesDict[@"name"];
            [self.classesArr addObject:model];
        }
        //创建分类的view
        [self createClassesView];
        
        for (NSDictionary *featuresDict in self.dataDict[@"features"]) {
            [self.featuresArr addObject:featuresDict];
        }
        //创建特色view
        [self createFeaturesView];
        
        for (NSDictionary *hotsDict in self.dataDict[@"hots"]) {
            WXDIndexModel *model = [[WXDIndexModel alloc] init];
            model.image = hotsDict[@"image"];
            model.name = hotsDict[@"name"];
            model.price = hotsDict[@"price"];
            model.cid = hotsDict[@"id"];
            [self.hotsArr addObject:model];
        }
        //创建热卖礼品view
        [self createhotsView];
        
        for (NSDictionary *birthDict in self.dataDict[@"cakes"]) {
            WXDIndexModel *model = [[WXDIndexModel alloc] init];
            model.image = birthDict[@"image"];
            model.name = birthDict[@"name"];
            model.cid = birthDict[@"id"];
            [self.birthsArray addObject:model];
        }
        //创建生日蛋糕行的view
        [self createBirthsView];
        
        for (NSDictionary *giftsDict in self.dataDict[@"gifts"]) {
            WXDIndexModel *model = [[WXDIndexModel alloc] init];
            model.image = giftsDict[@"image"];
            model.name = giftsDict[@"name"];
            model.cid = giftsDict[@"id"];
            [self.giftsArray addObject:model];
        }
        //创建特色礼品行的view
        [self createGiftsView];
        
        for (NSDictionary *giftsDict in self.dataDict[@"about"]) {
            WXDIndexModel *model = [[WXDIndexModel alloc] init];
            model.image = giftsDict[@"image"];
            model.name = giftsDict[@"name"];
            [self.aboutArray addObject:model];
        }
        [self createAboutView];
        
        NSDictionary *contactDict = self.dataDict[@"contact"];
            WXDIndexModel *model = [[WXDIndexModel alloc] init];
            model.image = contactDict[@"image"];
            model.name = contactDict[@"name"];
            [self.contactArray addObject:model];
        
        [self createContactView];
        
        
        for (NSDictionary *recommendDict in self.dataDict[@"recommend"]) {
            WXDIndexModel *model = [[WXDIndexModel alloc] init];
            model.image = recommendDict[@"image"];
            model.name = recommendDict[@"name"];
            model.price = recommendDict[@"price"];
            model.cid = recommendDict[@"id"];
            [self.recommendarray addObject:model];
        }
        
        [self createRecommendView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"%@",error);
    }];
}
//创建导航栏
- (void)createGuidView {
    //创建导航栏
    self.guidView = [[UIView alloc] init];
    [self.view addSubview:self.guidView];
    [self.guidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(64);
    }];
    self.guidView.backgroundColor = kColorWithRGB(239, 118, 58);
    
    UIImageView *leftPicView = [[UIImageView alloc] init];
    leftPicView.image = [UIImage imageNamed:@"nav"];
    [self.guidView addSubview:leftPicView];
    [leftPicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.guidView.mas_bottom).offset(0);
        make.left.equalTo(self.guidView.mas_left).offset(10);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(64);
    }];
    
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    searchTextField.backgroundColor = kColorWithRGB(253, 148, 84);
    searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入关键字" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0f]}];
    
    searchTextField.text = @"";
    searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    searchTextField.font = [UIFont systemFontOfSize:12];
    searchTextField.delegate = self;
    searchTextField.tag = 1000;
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.guidView addSubview:searchTextField];
    
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.guidView.mas_bottom).offset(-10);
        make.left.equalTo(leftPicView.mas_right).offset(10);
        make.right.equalTo(self.guidView.mas_right).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    //设置输入框左边图标
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    image1.frame = CGRectMake(0, 0, 20, 15);
    searchTextField.leftView = image1;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sounds"]];
    image2.frame = CGRectMake(0, 0, 20, 20);
    searchTextField.rightView = image2;
    searchTextField.rightViewMode = UITextFieldViewModeAlways;
    
}

- (void)configUI {
    //创建导航栏
    [self createGuidView];
    
    //WS(weakSelf)
    //创建最低部的滑动视图
    self.bottomScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screenwidth, ScreenHeight - 64)];
    
    self.bottomScroll.showsVerticalScrollIndicator = NO;
    self.bottomScroll.showsHorizontalScrollIndicator = NO;
    self.bottomScroll.scrollEnabled = YES;
    self.bottomScroll.userInteractionEnabled = YES;
    self.bottomScroll.backgroundColor = kColorWithRGB(238, 237, 243);
    [self.view addSubview:self.bottomScroll];
    self.bottomScroll.delegate = self;
    
    self.recommendScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ScreenHeight, Screenwidth, ScreenHeight - 64)];
    self.recommendScroll.showsVerticalScrollIndicator = NO;
    self.recommendScroll.showsHorizontalScrollIndicator = NO;
    self.recommendScroll.scrollEnabled = YES;
    self.recommendScroll.userInteractionEnabled = YES;
    self.recommendScroll.backgroundColor = kColorWithRGB(238, 237, 243);
    self.recommendScroll.contentSize = CGSizeMake(Screenwidth, 2000);
    [self.view addSubview:self.recommendScroll];
    self.recommendScroll.delegate = self;
    
    [self.bottomPromptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recommendScroll.mas_top).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(40);
    }];
}

- (WXDPromptPullOrDownView *)bottomPromptView {
    if (!_bottomPromptView) {
        _bottomPromptView = [[WXDPromptPullOrDownView alloc] init];
        [self.recommendScroll addSubview:_bottomPromptView];
    }
    
    _bottomPromptView.image = [UIImage imageNamed:@"pull"];
    _bottomPromptView.title = @"下拉返回";
    _bottomPromptView.imageHeight = 15;
    [_bottomPromptView createSubViews];
    
    return _bottomPromptView;
}

//创建轮播图
- (void)createLoopScroll {
//    NSLog(@">>>>>>>>%d",self.loopPics.count);
    //先创建一个轮播图
    self.loopScroll = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, Screenwidth, 120) imageUrls:self.loopPics timeInterval:2 didSelect:^(NSInteger atIndex) {
        
    } didScroll:^(NSInteger toIndex) {
        
    }];
    
    [self.bottomScroll addSubview:self.loopScroll];
    
    [self.loopScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomScroll.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(120);
    }];
}
//创建classesView
- (void)createClassesView {
    UIView *whiteView = [[UIView alloc] init];
    whiteView.tag = 1001;
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.bottomScroll addSubview:whiteView];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loopScroll.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(80);
    }];
    UIView *otherView;
    for (int i = 0; i < self.classesArr.count; i++) {
        WXDImageAndTextView *imageAndTextView = [[WXDImageAndTextView alloc] init];
        [whiteView addSubview:imageAndTextView];
        imageAndTextView.model = self.classesArr[i];
        imageAndTextView.ImageSize = CGSizeMake(40, 40);
        imageAndTextView.labelSize = CGSizeMake(Screenwidth/self.classesArr.count, 20);
        
        
        [imageAndTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(whiteView.mas_top);
            if (otherView == nil) {
                make.left.equalTo(whiteView.mas_left);
            }else {
                make.left.equalTo(otherView.mas_right);
            }
            make.height.mas_equalTo(80);
            make.width.mas_equalTo(Screenwidth/self.classesArr.count);
        }];
        
        [imageAndTextView createImageAndLabel];
        otherView = imageAndTextView;
    }
}
//创建特色栏
- (void)createFeaturesView {
    UIView *whiteView = (UIView *)[self.view viewWithTag:1001];
    CGFloat space = 1;
    CGFloat width = (Screenwidth - space *self.featuresArr.count)/self.featuresArr.count;
    CGFloat height = 5 * width / 4;
    UIButton *otherBtn;
    for (int i = 0; i < self.featuresArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn sd_setImageWithURL:[NSURL URLWithString:self.featuresArr[i][@"image"]] forState:UIControlStateNormal placeholderImage:nil];
        [btn addTarget:self action:@selector(featuresClicked) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2000 + i;
        
        [self.bottomScroll addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (otherBtn == nil) {
                make.left.equalTo(self.bottomScroll.mas_left);
            } else {
                make.left.equalTo(otherBtn.mas_right).offset(space);
            }
            make.top.equalTo(whiteView.mas_bottom).offset(10);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        otherBtn = btn;
    }
}

- (void)featuresClicked {
    
}

- (void)createhotsView {
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:2000];
    
    self.hotsView = [[WXDHotsView alloc] init];
    
    [self.bottomScroll addSubview:self.hotsView];
    
    self.hotsView.groupName = @"热卖鲜花";
    self.hotsView.dataArray = self.hotsArr;
    self.hotsView.count = 2;
    self.hotsView.space = 10;
    
    CGFloat width = (Screenwidth - self.hotsView.space * 3)/self.hotsView.count;
    CGFloat height = 4 * width / 3;
    
    [self.hotsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(5 + 5 + 30 + (self.hotsView.space + height) * (self.hotsArr.count / 2));
    }];
    [self.hotsView createHotsView];
}
//创建生日蛋糕系列的view
- (void)createBirthsView {
    
    self.birthCakeView = [[WXDBirthCakesView alloc] init];
    [self.bottomScroll addSubview:self.birthCakeView];
    
    self.birthCakeView.groupName = @"生日蛋糕";
    self.birthCakeView.dataArray = self.birthsArray;
    self.birthCakeView.count = 3;
    self.birthCakeView.space = 1;

    CGFloat width = (Screenwidth - self.birthCakeView.space * (self.birthCakeView.count - 1))/self.birthCakeView.count;
    CGFloat height = 1 * width / 2;
    
    self.birthCakeView.viewSize = CGSizeMake(width, height);
    self.birthCakeView.isHasPic = YES;
    
    
    [self.birthCakeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotsView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50 + 80 + (self.birthCakeView.space + height) * ((self.birthsArray.count - 1) / self.birthCakeView.count) - self.birthCakeView.space);
    }];
    
    [self.birthCakeView createBirthCakesView];
}

- (void)createGiftsView {
    
    self.giftView = [[WXDBirthCakesView alloc] init];
    [self.bottomScroll addSubview:self.giftView];
    
    self.giftView.groupName = @"特色礼品";
    self.giftView.dataArray = self.giftsArray;
    self.giftView.count = 3;
    self.giftView.space = 1;
    
    CGFloat width = (Screenwidth - self.giftView.space * (self.giftsArray.count - 1))/self.giftsArray.count;
    CGFloat height = 5 * width / 4;
    
    self.giftView.viewSize = CGSizeMake(width, height);
    self.giftView.isHasPic = NO;
    
    
    [self.giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birthCakeView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50 + (self.giftView.space + height) * (self.giftsArray.count / self.giftsArray.count) - self.giftView.space);
    }];
    
    [self.giftView createBirthCakesView];
}

//创建classesView
- (void)createAboutView {
    self.aboutView = [[UIView alloc] init];
    
    self.aboutView.backgroundColor = [UIColor whiteColor];
    
    [self.bottomScroll addSubview:self.aboutView];
    
    [self.aboutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(80);
    }];
    UIView *otherView;
    for (int i = 0; i < self.aboutArray.count; i++) {
        WXDImageAndTextView *imageAndTextView = [[WXDImageAndTextView alloc] init];
        [self.aboutView addSubview:imageAndTextView];
        imageAndTextView.model = self.aboutArray[i];
        imageAndTextView.ImageSize = CGSizeMake(40, 40);
        imageAndTextView.labelSize = CGSizeMake(Screenwidth/self.aboutArray.count, 20);
        
        
        [imageAndTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.aboutView.mas_top);
            if (otherView == nil) {
                make.left.equalTo(self.aboutView.mas_left);
            }else {
                make.left.equalTo(otherView.mas_right);
            }
            make.height.mas_equalTo(80);
            make.width.mas_equalTo(Screenwidth/self.aboutArray.count);
        }];
        
        [imageAndTextView createImageAndLabel];
        otherView = imageAndTextView;
    }
}

- (void)createContactView {
    WXDIndexModel *model = self.contactArray[0];
    self.contactView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.contactView setBackgroundColor:[UIColor whiteColor]];
    [self.contactView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contactView setTitle:model.name forState:UIControlStateNormal];
    [self.contactView sd_setImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal placeholderImage:nil];
    [self.contactView addTarget:self action:@selector(contactBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomScroll addSubview:self.contactView];
    
    [self.contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.aboutView.mas_bottom).offset(2);
        make.height.mas_equalTo(40);
    }];
    
    [self.topPromptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contactView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(40);
    }];
    
    [self.bottomScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
        // 让scrollview的contentSize随着内容的增多而变化
        make.bottom.mas_equalTo(self.topPromptView.mas_bottom);
    }];
    NSLog(@"/////////%f",self.bottomScroll.contentSize.height);
}

- (void)contactBtnClicked {
    
}
//创建recommendView
- (void)createRecommendView {
    
    self.recommendView = [[WXDOrderView alloc] init];
    [self.recommendScroll addSubview:self.recommendView];
    
    self.recommendView.count = 2;//横排的个数
    self.recommendView.space = 10;//间距
    self.recommendView.dataArray = self.recommendarray;
    
    CGFloat width = (Screenwidth - self.recommendView.space * 3)/self.recommendView.count;
    CGFloat height = 4 * width / 3;
    self.recommendView.width = width;
    self.recommendView.height = height;
    
    [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomPromptView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(5 + 5 + (self.recommendView.space + height) * (self.recommendarray.count / 2));
    }];
    [self.recommendView createOrderViews];
    
    [self.recommendScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(ScreenHeight, 0, 0, 0));
        // 让scrollview的contentSize随着内容的增多而变化
        make.bottom.mas_equalTo(self.recommendView.mas_bottom);
    }];
    NSLog(@"/////////%f",self.recommendScroll.contentSize.height);
}

- (WXDPromptPullOrDownView *)topPromptView {
    if (!_topPromptView) {
        _topPromptView = [[WXDPromptPullOrDownView alloc] init];
        [self.bottomScroll addSubview:_topPromptView];
    }
    
    _topPromptView.image = [UIImage imageNamed:@"down"];
    _topPromptView.title = @"单品推荐";
    _topPromptView.imageHeight = 15;
    [_topPromptView createSubViews];
    
    return _topPromptView;
}



#pragma mark -- ScrollView Delegate --

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.bottomScroll.contentOffset.y - self.pullHeight >= 64) {
        // 告诉self.view约束需要更新
        [self.view setNeedsUpdateConstraints];
        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        [self.view updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.bottomScroll mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view.mas_top).offset(64);
            }];

            [self.recommendScroll mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(64);
            }];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.bottomScroll scrollviewScrollBottom:^{
        NSLog(@"小丹丹，我滑动到最低端了！");
        self.pullHeight = self.bottomScroll.contentOffset.y;
        //NSLog(@"%f",scrollView.contentOffset.y);
    }];
    
    if (self.recommendScroll.contentOffset.y <= 0) {
        
        NSLog(@"ddddddddddd%f",self.recommendScroll.contentOffset.y);
        NSLog(@"??????????????????????????????????????????????????????????");
        // 告诉self.view约束需要更新
        [self.view setNeedsUpdateConstraints];
        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        [self.view updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomScroll.frame = CGRectMake(0, 64, Screenwidth, ScreenHeight - 64);
            self.recommendScroll.frame = CGRectMake(0, ScreenHeight, Screenwidth, ScreenHeight - 64);
//            [self.bottomScroll mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.view.mas_top).offset(64);
//            }];
//            
//            [self.recommendScroll mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.view.mas_bottom);
//            }];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}

#pragma mark -- textField delegate --

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITextField *searchTextField = (UITextField *)[self.view viewWithTag:1000];
    [searchTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
