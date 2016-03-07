//
//  UIViewController+Common.m
//  News
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)

//导航栏添加返回按钮
- (void)showBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 20);
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
}
- (void)backBtnAction:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
