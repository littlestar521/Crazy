//
//  BillboardViewController.m
//  News
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "BillboardViewController.h"
#import "VOSegmentedControl.h"
#import "SetView.h"
#import "MainTableViewCell.h"
#import "MainModel.h"
#import <AFNetworking/AFHTTPSessionManager.h>
@interface BillboardViewController ()<PushVCDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)VOSegmentedControl *segmentControl;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,assign)NSInteger billboardNum;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *readArray;
@property(nonatomic,strong)NSMutableArray *likeArray;
@property(nonatomic,strong)NSMutableArray *commentArray;
@property(nonatomic,strong)NSMutableArray *allListArray;

@end

@implementation BillboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"排行榜";
    self.navigationController.navigationBar.backgroundColor = MineColor;
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 60, 44);
    
    [self.leftBtn setImage:[UIImage imageNamed:@"btn_chengshi"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(makeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.leftBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.tableView];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.billboardNum = BillboardTypeRead;
    [self showReadRequest];
    
}
- (void)getOtherViewController:(UIViewController *)otherVC{
    [self.navigationController pushViewController:otherVC animated:YES];
}
- (void)makeAction:(UIButton *)btn{
    
    SetView *setView = [[SetView alloc]init];
    setView.delegate = self;
    [self.view addSubview:setView];

}

#pragma mark ---------- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.billboardNum == BillboardTypeRead) {
        return self.readArray.count;
    }else if (self.billboardNum == BillboardTypeLike){
        return self.likeArray.count;
    }
    return self.commentArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.billboardNum == BillboardTypeRead) {
        if (indexPath.row < self.readArray.count) {
            cell.model = self.readArray[indexPath.row];
            MainModel *model = self.readArray[indexPath.row];
            cell.source_nameLabel.text = model.author_name;
        }
    }else if (self.billboardNum == BillboardTypeLike){
        if (indexPath.row < self.likeArray.count) {
            cell.model = self.likeArray[indexPath.row];
            MainModel *model = self.likeArray[indexPath.row];
            cell.source_nameLabel.text = model.author_name;
        }
    }else{
        if (indexPath.row < self.commentArray.count) {
            cell.model = self.commentArray[indexPath.row];
            MainModel *model = self.commentArray[indexPath.row];
            cell.source_nameLabel.text = model.author_name;
        }
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight - 40)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 150;
        
    }
    return _tableView;
}
#pragma mark ---------- 网络请求
- (void)chooseRequest{
    switch (self.billboardNum) {
        case BillboardTypeRead:
            [self showReadRequest];
            break;
        case BillboardTypeLike:
            [self showLikeRequest];
            break;
        case BillboardTypeComment:
            [self showCommentRequest];
            break;
        default:
            break;
    }
}
- (void)showReadRequest{
    
        AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
        [sessionManager GET:kRead parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (self.readArray.count > 0) {
                [self.readArray removeAllObjects];
            }
            NSDictionary *resultDic = responseObject;
            NSArray *acticlesArray = resultDic[@"articles"];
            for (NSDictionary *dic in acticlesArray) {
                MainModel *mainModel = [[MainModel alloc]initWithDictionary:dic];
                [self.readArray addObject:mainModel];
            }
            [self showSelectBtn];
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
}
- (void)showLikeRequest{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    [sessionManager GET:kLike parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.likeArray.count > 0) {
            [self.likeArray removeAllObjects];
        }
        NSDictionary *resultDic = responseObject;
        NSArray *articles = resultDic[@"articles"];
        for (NSDictionary *dic in articles) {
            MainModel *likeModel = [[MainModel alloc]initWithDictionary:dic];
            [self.likeArray addObject:likeModel];
        }
        [self showSelectBtn];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)showCommentRequest{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [sessionManager GET:kComment parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.commentArray.count > 0) {
            [self.commentArray removeAllObjects];
        }
        NSDictionary *resultDic = responseObject;
        NSArray *articles = resultDic[@"articles"];
        for (NSDictionary *dic in articles) {
            MainModel *commentModel = [[MainModel alloc]initWithDictionary:dic];
            [self.commentArray addObject:commentModel];
        }
        [self showSelectBtn];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)showSelectBtn{
    
    switch (self.billboardNum) {
        case BillboardTypeRead:
        {
            self.allListArray = self.readArray;
        }
            break;
        case BillboardTypeLike:
        {
            self.allListArray = self.likeArray;
        }
            break;
        case BillboardTypeComment:
        {
            self.allListArray = self.commentArray;
        }
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}
#pragma mark ---------- Lazy
- (NSMutableArray *)allListArray{
    if (_allListArray == nil) {
        self.allListArray = [NSMutableArray new];
    }
    return _allListArray;
}
- (NSMutableArray *)readArray{
    if (_readArray == nil) {
        self.readArray = [NSMutableArray new];
    }
    return _readArray;
}

- (NSMutableArray *)likeArray{
    if (_likeArray == nil) {
        self.likeArray = [NSMutableArray new];
    }
    return _likeArray;
}
- (NSMutableArray *)commentArray{
    if (_commentArray == nil) {
        self.commentArray = [NSMutableArray new];
    }
    return _commentArray;
}
#pragma mark ---------- VOSegmentedControl
- (VOSegmentedControl *)segmentControl{
    if (_segmentControl == nil) {
        self.segmentControl = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText:@"阅读"},@{VOSegmentText:@"赞"},@{VOSegmentText:@"评论"}]];
        self.segmentControl.contentStyle = VOContentStyleTextAlone;
        self.segmentControl.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segmentControl.backgroundColor = [UIColor whiteColor];
        self.segmentControl.tintColor = MineColor;
        self.segmentControl.selectedBackgroundColor = self.segmentControl.backgroundColor;
        self.segmentControl.allowNoSelection = NO;
        self.segmentControl.frame = CGRectMake(0, 60, kScreenWidth, 40);
        self.segmentControl.indicatorThickness = 3;
        self.segmentControl.selectedSegmentIndex = self.billboardNum-1;
        [self.segmentControl addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}
- (void)segmentCtrlValuechange:(VOSegmentedControl *)segmentControl{
    self.billboardNum = segmentControl.selectedSegmentIndex+1;
    MJJLog(@"%lu",self.billboardNum);
    [self chooseRequest];
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
