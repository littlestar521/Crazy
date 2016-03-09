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
@interface SelfViewController ()<PushVCDelegate>


@property (weak, nonatomic) IBOutlet UITextField *ueerNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;

- (IBAction)loginAction:(id)sender;

@end

@implementation SelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self showBackBtn];
    
}

- (void)getOtherViewController:(UIViewController *)otherVC{
    [self.navigationController pushViewController:otherVC animated:YES];
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
            MJJLog(@"%@",user);
        }else{
            MJJLog(@"%@",error);
        }
    }];
}
@end
