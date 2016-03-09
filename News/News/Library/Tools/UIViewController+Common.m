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

//导航栏添加返回按钮
- (void)showBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 20, 14);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 20);
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
}
- (void)showLeftBtn{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 10);
    
    [leftBtn setImage:[UIImage imageNamed:@"btn_chengshi"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(makeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarBtn;

}
- (void)backBtnAction:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)makeAction:(UIButton *)btn{
    SetView *setView = [[SetView alloc]init];
    setView.delegate = self;
    [self.view addSubview:setView];
}
@end
