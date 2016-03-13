//
//  RegisterViewController.m
//  News
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#import "ProgressHUD.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmationTF;
- (IBAction)registerAction:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *passwordSwitch;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackBtnWithName:nil];
    //密码密文显示
    self.passwordTF.secureTextEntry = YES;
    self.confirmationTF.secureTextEntry = YES;
    //默认switch关闭，密码不显示
    self.passwordSwitch.on = NO;
    //设置代理
    self.userNameTF.delegate = self;
    self.passwordTF.delegate = self;
    self.confirmationTF.delegate = self;
    
}
//点击键盘上return回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//点击空白处回收键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)registerAction:(id)sender {
    if (![self checkOut]) {
        return;
    }
    //注册
//    BmobObject *user = [BmobObject objectWithClassName:@"users"];
//    [user setObject:@"userName" forKey:@"user_Name"];
//    [user setObject:@18 forKey:@"user_Age"];
//    [user setObject:@"女" forKey:@"user_gender"];
//    [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        //进行操作
//        MJJLog(@"恭喜注册成功!");
//    }];

    [ProgressHUD show:@"别催，注册着呢~"];
    //注册
    BmobUser *user = [[BmobUser alloc]init];
    [user setUsername:self.userNameTF.text];
    [user setPassword:self.passwordTF.text];
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [ProgressHUD showSuccess:@"注册成功啦~"];
        }
        else{
            [ProgressHUD showError:@"注册失败"];
        }
    }];
}

- (IBAction)pressSwitchAction:(id)sender {
    UISwitch *passwordSwitch = sender;
    if (passwordSwitch.on) {
        self.passwordTF.secureTextEntry = NO;
        self.confirmationTF.secureTextEntry = NO;
    }else{
        self.passwordTF.secureTextEntry = YES;
        self.confirmationTF.secureTextEntry = YES;
    
    }
}
//注册之前需要判断
- (BOOL)checkOut{
    //用户名不能为空且不能为空格
    if (self.userNameTF.text.length <= 0 && [self.userNameTF.text stringByReplacingOccurrencesOfString:@"" withString:@"  "].length <= 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示：" message:@"用户名不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
        if (![self.passwordTF.text isEqualToString:self.confirmationTF.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示：" message:@"两次密码输入不一致" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    if (self.passwordTF.text.length <= 0 && [self.passwordTF.text stringByReplacingOccurrencesOfString:@"" withString:@"  "].length <= 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示：" message:@"密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }

    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
