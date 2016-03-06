//
//  SetView.m
//  News
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "SetView.h"

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
    self.setView = [[UIView alloc]initWithFrame:CGRectMake(-150, 0, kScreenWidth-100, kScreenHeight)];
    self.setView.backgroundColor = [UIColor whiteColor];
    [window addSubview:self.setView];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(100-kScreenWidth, 0, 100, kScreenHeight)];
    self.backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
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
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%d",i]] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,-110 ,0 , 0)];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 100+i;

        [self.setView addSubview:btn];
    }
    UITapGestureRecognizer *disappear = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapearAction)];
    [self.backView addGestureRecognizer:disappear];
    [UIView animateWithDuration:1.0 animations:^{
        self.setView.frame = CGRectMake(0, 0, kScreenWidth-100, kScreenHeight);
        self.backView.frame = CGRectMake(kScreenWidth-100, 0, 100, kScreenHeight);
    }];

    
}
- (void)disapearAction{
    [UIView animateWithDuration:1.0 animations:^{
        self.setView.frame = CGRectMake(100-kScreenWidth, 0, kScreenWidth-100, kScreenHeight);
        self.backView.frame = CGRectMake(100-kScreenWidth, 0, 100, kScreenHeight);
        
    }];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
