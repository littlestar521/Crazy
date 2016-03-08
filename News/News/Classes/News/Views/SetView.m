//
//  SetView.m
//  News
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "SetView.h"
#import "MainViewController.h"
#import "BillboardViewController.h"
@interface SetView ()
@property(nonatomic,strong)UIView *setView;
@property(nonatomic,strong)UIView *backView;

@end
@implementation SetView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}
- (void)configView{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.setView = [[UIView alloc]initWithFrame:CGRectMake(100-kScreenWidth, 0, kScreenWidth-100, kScreenHeight)];
    self.setView.backgroundColor = [UIColor whiteColor];
    [window addSubview:self.setView];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.0;
    [window addSubview:self.backView];
    
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(0, 0, kScreenWidth-100, 150);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleEdgeInsets = UIEdgeInsetsMake(100, -220, 0, 0);
    
    [loginBtn setBackgroundColor:MineColor];
    [loginBtn setImage:[UIImage imageNamed:@"avatar_m"] forState:UIControlStateNormal];
    [loginBtn setImageEdgeInsets:UIEdgeInsetsMake(30, 30, 30, kScreenWidth-180)];
    [self.setView addSubview:loginBtn];
    
    NSArray *titleArray = @[@"      首页",@"    排行榜",@"      栏目",@"       搜索",@"     设置",@"夜间模式",@"      离线"];
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 150+44*i , kScreenWidth/3*2, 44);
        btn.tag = 100+i;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%d",i]] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,-110 ,0 , 0)];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(setSelectAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.setView addSubview:btn];
    }
    UITapGestureRecognizer *disappear = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapearAction)];
    [self.backView addGestureRecognizer:disappear];
    [UIView animateWithDuration:0.5 animations:^{
        //移入屏幕后的frame
        self.setView.frame = CGRectMake(0, 0, kScreenWidth-100, kScreenHeight);
        self.backView.frame = CGRectMake(kScreenWidth-100, 0, 100, kScreenHeight);
        self.backView.alpha = 0.6;
        
    }];
}
- (void)disapearAction{
    [UIView animateWithDuration:0.5 animations:^{
        //移出屏幕的frame
        self.setView.frame = CGRectMake(100-kScreenWidth, 0, kScreenWidth-100, kScreenHeight);
        self.backView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backView.alpha = 0.0;
    }];
}
- (void)setSelectAction:(UIButton *)btn{
    [self disapearAction];
    switch (btn.tag) {
        case 100:
        {
            MainViewController *mainVC = [[MainViewController alloc] init];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherViewController:)]) {
                [self.delegate getOtherViewController:mainVC];
                [mainVC popoverPresentationController];
            }
        }
            break;
        case 101:
        {
            BillboardViewController *billboardVC = [[BillboardViewController alloc]init];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherViewController:)]) {
                [self.delegate getOtherViewController:billboardVC];
                [billboardVC popoverPresentationController];
            }
        }
            
            break;
        case 102:

            break;
        case 103:

            break;
        case 104:

            break;
        case 105:

            break;
        case 106:

            break;
            
        default:
            break;
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
