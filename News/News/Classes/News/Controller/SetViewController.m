//
//  SetViewController.m
//  News
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "SetViewController.h"
#import "SetView.h"
#import <SDWebImage/SDImageCache.h>
#import "ProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import "ShareView.h"

@interface SetViewController ()<PushVCDelegate,MFMailComposeViewControllerDelegate>

- (IBAction)articlesSizeAction:(id)sender;
- (IBAction)clearAction:(id)sender;

- (IBAction)shareAction:(id)sender;
- (IBAction)appversionAction:(id)sender;

- (IBAction)helpAction:(id)sender;

@property(nonatomic,strong)ShareView *shareView;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self showLeftBtn];
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
//文章字号
- (IBAction)articlesSizeAction:(id)sender {
}

//清除缓存
- (IBAction)clearAction:(id)sender {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:sender]) {
        NSArray *files = [fileManager subpathsAtPath:sender];
        for (NSString *fileName in files) {
            NSString *path = [sender stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:path error:nil];
        }
        [[SDImageCache sharedImageCache] cleanDisk];
    }
}
//分享
- (IBAction)shareAction:(id)sender {
    self.shareView = [[ShareView alloc]init];
    [self.view addSubview:self.shareView];
}
//版本信息
- (IBAction)appversionAction:(id)sender {
    [ProgressHUD show:@"正在为您检测中···"];
    [self performSelector:@selector(checkAppversion) withObject:nil afterDelay:2.0];
    
}
//反馈与帮助
- (IBAction)helpAction:(id)sender {
    [self performSelector:@selector(alertAction) withObject:nil afterDelay:2.0];
    [ProgressHUD showSuccess:@"反馈成功~"];
    Class mailClass = NSClassFromString(@"");
    if (mailClass != nil) {
        if ([MFMailComposeViewController canSendMail]) {
    
            //初始化
            MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
            mailVC.mailComposeDelegate = self;
            //设置主题
            [mailVC setSubject:@"用户反馈"];
            
            //设置收件人
            NSArray *receive = [NSArray arrayWithObjects:@"2891529590@qq.com",nil];
            [mailVC setToRecipients:receive];
            //设置发送内容
            NSString *emailBody = @"请留下您宝贵意见";
            [mailVC setMessageBody:emailBody isHTML:NO];
            [self presentViewController:mailVC animated:YES completion:nil];
        }else{
            MJJLog(@"未配置邮箱");
        }
    }else{
        MJJLog(@"当前设备不支持");
    }
}
//邮件发送完成调用的方法
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (result)
    {
        case MFMailComposeResultCancelled: //取消
            NSLog(@"MFMailComposeResultCancelled-取消");
            break;
        case MFMailComposeResultSaved: // 保存
            NSLog(@"MFMailComposeResultSaved-保存邮件");
            break;
        case MFMailComposeResultSent: // 发送
            NSLog(@"MFMailComposeResultSent-发送邮件");
            break;
        case MFMailComposeResultFailed: // 尝试保存或发送邮件失败
            NSLog(@"MFMailComposeResultFailed: %@...",[error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示：" message:@"感谢您的宝贵建议！！！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
//计算缓存大小
//检测版本
- (void)checkAppversion{
    [ProgressHUD showSuccess:@"当前版本已是最新版"];
}


@end
