//
//  SelfViewController.m
//  News
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "SelfViewController.h"
#import "SetView.h"
#import "RegisterViewController.h"
#import <BmobSDK/BmobUser.h>
#import "MainViewController.h"
#import "MediaTableViewCell.h"
@interface SelfViewController ()<PushVCDelegate,UITextFieldDelegate,MediaDelegate>


@property (weak, nonatomic) IBOutlet UITextField *ueerNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *imageV;

- (IBAction)loginAction:(id)sender;

@end

@implementation SelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ueerNameTextFiled.delegate = self;
    self.passwordTextFiled.delegate = self;
    
    [self showBackBtn];
}

- (void)getOtherViewController:(UIViewController *)otherVC{
    [self.navigationController pushViewController:otherVC animated:YES];
    }
- (void)getOneVC:(UIViewController *)oneVC{
    [self.navigationController pushViewController:oneVC animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

- (IBAction)loginAction:(id)sender {
    [BmobUser loginInbackgroundWithAccount:self.ueerNameTextFiled.text andPassword:self.passwordTextFiled.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示：" message:@"登陆成功^^*^^" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
//            [self.imageV setBackgroundImage:[UIImage imageNamed:@"977CD03A746064A69C4B3AAC64035223"] forState:UIControlStateNormal];
            
        }else{
            MJJLog(@"%@",error);
        }
    }];
}
@end
