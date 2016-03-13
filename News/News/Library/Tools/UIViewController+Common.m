//
//  UIViewController+Common.m
//  News
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "UIViewController+Common.h"
#import "SetView.h"

@interface UIViewController ()<PushVCDelegate>

@end
@implementation UIViewController (Common)

//导航栏标题
//- (void)showTitleBtnWithName:(NSString *)name{
//    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    titleBtn.frame = CGRectMake(60, 0, 60, 40);
//    [titleBtn setTitle:name forState:UIControlStateNormal];
//    [titleBtn setTintColor:[UIColor whiteColor]];
//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:titleBtn];
//    self.navigationItem.leftBarButtonItem = leftBarBtn;
//}
//导航栏添加返回按钮
- (void)showBackBtnWithName:(NSString *)name{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 14);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(30, 0, 150, 40);
    [titleBtn setTitle:name forState:UIControlStateNormal];
    [titleBtn setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *otherBarBtn = [[UIBarButtonItem alloc]initWithCustomView:titleBtn];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:leftBarBtn,otherBarBtn, nil]];

    
}
- (void)showLeftBtnWithName:(NSString *)name{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 10);
    
    [leftBtn setImage:[UIImage imageNamed:@"btn_chengshi"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(makeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.tintColor = [UIColor whiteColor];
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(30, 0, 80, 40);
    [titleBtn setTitle:name forState:UIControlStateNormal];
    [titleBtn setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *otherBarBtn = [[UIBarButtonItem alloc]initWithCustomView:titleBtn];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:leftBarBtn,otherBarBtn, nil]];
    

}
- (void)backBtnAction:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)makeAction:(UIButton *)btn{
    SetView *setView = [[SetView alloc]init];
    setView.delegate = self;
    [self.view addSubview:setView];
}
@end
