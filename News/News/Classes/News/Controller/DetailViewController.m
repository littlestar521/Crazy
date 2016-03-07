//
//  DetailViewController.m
//  News
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()

@property(nonatomic,strong)UIButton *leftBtn;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self showBackBtn];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.data]];
    [self.view addSubview:webView];
    [webView loadRequest:request];
    
    [self detaildata];
}
- (void)detaildata{
    
    
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
