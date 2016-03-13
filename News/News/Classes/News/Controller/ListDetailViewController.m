
//
//  ListDetailViewController.m
//  News
//
//  Created by scjy on 16/3/12.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "ListDetailViewController.h"
#import "MainTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "DetailViewController.h"

@interface ListDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArray;

@end

@implementation ListDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackBtnWithName:self.name];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self requestModel];
}
#pragma mark ---------- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row < self.listArray.count) {
       
        cell.model = self.listArray[indexPath.row] ;
    }
    return cell;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 120;
    }
    return _tableView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    MainModel *model = self.listArray[indexPath.row];
    detailVC.data = model.share_url;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark ---------- 网络请求
- (void)requestModel{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [sessionManager GET:[NSString stringWithFormat:kListDetail, self.data] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = responseObject;
        NSArray *articles = resultDic[@"articles"];
        for (NSDictionary *dic in articles) {
            MainModel *listmodel = [[MainModel alloc]initWithDictionary:dic];
            [self.listArray addObject:listmodel];
            NSLog(@"%@", self.listArray);

        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
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
