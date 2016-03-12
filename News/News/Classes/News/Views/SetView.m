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
#import "ListViewController.h"
#import "SetViewController.h"
#import "SelfViewController.h"
#import "SearchViewController.h"
@interface SetView ()
{
    BOOL night;
}
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
    [loginBtn setTitle:@"个人" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
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
- (void)loginAction{
    [self disapearAction];
    UIStoryboard *selfSB = [UIStoryboard storyboardWithName:@"Self" bundle:nil];
    SelfViewController *selfVC = [selfSB instantiateViewControllerWithIdentifier:@"Self"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherViewController:)]) {
        [self.delegate getOtherViewController:selfVC];
        [selfVC popoverPresentationController];
    }
}

- (void)setSelectAction:(UIButton *)btn{
    switch (btn.tag) {
        case 100:
        {
            [self disapearAction];
            MainViewController *mainVC = [[MainViewController alloc] init];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherViewController:)]) {
                [self.delegate getOtherViewController:mainVC];
                [mainVC popoverPresentationController];
            }
        }
            break;
        case 101:
        {
            [self disapearAction];
            BillboardViewController *billboardVC = [[BillboardViewController alloc]init];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherViewController:)]) {
                [self.delegate getOtherViewController:billboardVC];
                [billboardVC popoverPresentationController];
            }
        }
            break;
        case 102:
        {
            [self disapearAction];
            ListViewController *listVC = [[ListViewController alloc]init];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherViewController:)]) {
                [self.delegate getOtherViewController:listVC];
                [listVC popoverPresentationController];
            }
        }
            break;
        case 103:
        {
            [self disapearAction];
            SearchViewController *searchVC = [[SearchViewController alloc]init];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherViewController:)]) {
                [self.delegate getOtherViewController:searchVC];
//                [searchVC popoverPresentationController];
            }
        }
            break;
        case 104:
        {
            [self disapearAction];
            UIStoryboard *setSB = [UIStoryboard storyboardWithName:@"Set" bundle:nil];
            SetViewController *setVC = [setSB instantiateViewControllerWithIdentifier:@"Set"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherViewController:)]) {
                [self.delegate getOtherViewController:setVC];
                [setVC popoverPresentationController];
            }
        }
            break;
        case 105:
        {
            
            if (night) {
                [btn setImage:[UIImage imageNamed:@"icon_5"] forState:UIControlStateNormal];
                [btn setTitle:@"夜间模式" forState:UIControlStateNormal];
                UIWindow *window = [[UIApplication sharedApplication].delegate window];
                window.backgroundColor = [UIColor blackColor];
                self.window.alpha = 0.3;
                night = 0;
            }else{
                [btn setImage:[UIImage imageNamed:@"icon_sidebar_sun"] forState:UIControlStateNormal];
                [btn setTitle:@"白天模式" forState:UIControlStateNormal];
                UIWindow *window = [[UIApplication sharedApplication].delegate window];
                window.backgroundColor = [UIColor whiteColor];
                self.window.alpha = 1.0;
                night = 1;
            }
           
        }
            break;
        case 106:
        {
            [self disapearAction];
        }

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
