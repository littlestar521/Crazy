//
//  MainViewController.m
//  News
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "MainViewController.h"
#import "VOSegmentedControl.h"
#import "MainTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPSessionManager.h>


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIScrollView *carouseView;
@property(nonatomic,strong)UIPageControl *pageControll;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIView *tableViewHeaderView;


@property(nonatomic,strong)VOSegmentedControl *segmentControl;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"暴走日报";
    self.navigationController.navigationBar.backgroundColor = MineColor;
//    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.tableView];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self configTableViewHeaderView];
    [self requestModel];
}

#pragma mark ---------- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

#pragma mark ---------- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 26;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark ---------- CustomMethod
- (void)configTableViewHeaderView{
    self.tableViewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    self.tableViewHeaderView.backgroundColor = [UIColor whiteColor];
    //添加图片
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i , 0, kScreenWidth, 186)];
        NSURL *url = [[NSURL alloc]init];
        [imageView sd_setImageWithURL:url placeholderImage:nil];
        imageView.userInteractionEnabled = YES;
        [self.carouseView addSubview:imageView];
    }
}
//网络请求
- (void)requestModel{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [sessionManager GET:kMainDataList parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MJJLog(@"%@",responseObject);
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MJJLog(@"%@",error);
    }];
    
}

#pragma mark ---------- 懒加载


#pragma mark ---------- VOSegmentedControl
- (VOSegmentedControl *)segmentControl{
    if (_segmentControl == nil) {
        self.segmentControl = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText:@"推荐"},@{VOSegmentText:@"视频"}]];
        self.segmentControl.contentStyle = VOContentStyleTextAlone;
        self.segmentControl.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segmentControl.backgroundColor = [UIColor whiteColor];
        self.segmentControl.tintColor = MineColor;
        self.segmentControl.selectedBackgroundColor = self.segmentControl.backgroundColor;
        self.segmentControl.allowNoSelection = NO;
        self.segmentControl.frame = CGRectMake(0, 60, kScreenWidth, 40);
        self.segmentControl.indicatorThickness = 2;
        self.segmentControl.selectedSegmentIndex = self.classifyListType-1;
        //返回点击的是哪个按钮
        [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
            NSLog(@"1: block --> %@", @(index));
        }];
        [self.segmentControl addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];    }
    return _segmentControl;
}
- (void)segmentCtrlValuechange:(VOSegmentedControl *)segmentControl{
    self.classifyListType = segmentControl.selectedSegmentIndex + 1;
    
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
