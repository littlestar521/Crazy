//
//  SearchViewController.m
//  News
//
//  Created by scjy on 16/3/11.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "SearchViewController.h"
#import "SetView.h"
#import "MainTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "DetailViewController.h"
@interface SearchViewController ()<PushVCDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
//{
//    NSString *input;
//}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)NSMutableArray *searchArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showLeftBtn];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(kScreenWidth/8,20, kScreenWidth/2+kScreenWidth/6*2,40)];
    //占位符
    [self.searchBar setPlaceholder:@"Search"];
    [self.searchBar setTintColor:[UIColor blackColor]];
    [self.searchBar setTranslucent:YES];
    [self.searchBar setSearchResultsButtonSelected:NO];
    [self.searchBar setBackgroundImage:[[UIImage alloc] init]];
    [self.searchBar setShowsBookmarkButton:YES];
    self.searchBar.delegate = self;
    [self.navigationController.view addSubview:self.searchBar];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (void)getOtherViewController:(UIViewController *)otherVC{
    [self.navigationController pushViewController:otherVC animated:YES];
}
#pragma mark --------- UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.searchArray[indexPath.row];
    return cell;
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 150;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    MainModel *model = self.searchArray[indexPath.row];
    detailVC.data = model.share_url;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
#pragma mark --------- 网络请求
- (void)requestModel{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [sessionManager POST:kSearch parameters:@{@"page":@"1", @"keywords": self.searchBar.text} progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_searchArray.count > 0) {
            [self.searchArray removeAllObjects];
        }
        NSDictionary *resultDic = responseObject;
        NSArray *articles = resultDic[@"articles"];
        for (NSDictionary *dic in articles) {
            MainModel *model = [[MainModel alloc]initWithDictionary:dic];
            [self.searchArray addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
//键盘中，搜索按钮点击方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self requestModel];
    [self.view addSubview:self.tableView];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    SetView *setView = [[SetView alloc]init];
    setView.delegate = self;
    [self.view addSubview:setView];
}

//当搜索内容变化时，实现实时搜索。
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.searchBar resignFirstResponder];
    self.searchBar.text = searchText;
    [self requestModel];
    [self.view addSubview:self.tableView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.searchBar removeFromSuperview];
    [self.view endEditing:YES];

}

- (NSMutableArray *)searchArray{
    if (_searchArray == nil) {
        self.searchArray = [NSMutableArray new];
    }
    return _searchArray;
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
