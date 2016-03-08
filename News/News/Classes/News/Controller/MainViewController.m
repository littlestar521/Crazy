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
#import "MainModel.h"
#import "PullingRefreshTableView.h"
#import "HWTools.h"
#import "MediaViewController.h"
#import "DetailViewController.h"
#import "ProgressHUD.h"
#import "SetView.h"
#import "MediaTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPSessionManager.h>


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,PullingRefreshTableViewDelegate,PushVCDelegate>
{
    NSInteger _timeStamp;
    UIWebView *webView;
}

@property(nonatomic,strong)UIScrollView *carouseView;
@property(nonatomic,strong)UIPageControl *pageControll;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIView *tableViewHeaderView;
@property(nonatomic,strong)UIButton *leftBtn;

@property(nonatomic,strong)NSMutableArray *adArray;
@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSMutableArray *mediaListArray;
@property(nonatomic,strong)NSMutableArray *allDataArray;
@property(nonatomic,strong)VOSegmentedControl *segmentControl;
@property(nonatomic,strong)PullingRefreshTableView *pullrefreshV;
@property(nonatomic,assign)BOOL refreshing;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"暴走日报";
    self.navigationController.navigationBar.backgroundColor = MineColor;
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 60, 44);
    
    [self.leftBtn setImage:[UIImage imageNamed:@"btn_chengshi"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(makeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.leftBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.pullrefreshV];

//    [self.pullrefreshV launchRefreshing];

    self.automaticallyAdjustsScrollViewInsets = NO;
    _timeStamp = [HWTools getTimestamp];
    
    
    //注册cell
    [self.pullrefreshV registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.pullrefreshV registerNib:[UINib nibWithNibName:@"MediaTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    self.pullrefreshV.tableFooterView = [[UIView alloc]init];
    self.refreshing = YES;
    self.classifyListType = ClassifyListTypeRecommend;
    [self requestModel];
}
//实现自定义代理方法
- (void)getOtherViewController:(UIViewController *)otherVC{
    
    [self.navigationController pushViewController:otherVC animated:NO];
}

#pragma mark ----------  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.classifyListType == ClassifyListTypeRecommend) {
        return self.listArray.count;
    }
        return self.mediaListArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.classifyListType == ClassifyListTypeRecommend) {
        MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        //防止数组越界
        if (indexPath.row < self.listArray.count) {
            cell.model = self.listArray[indexPath.row];
        }
        return cell;
    }
    MediaTableViewCell *mediaCell = [self.pullrefreshV dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    if (indexPath.row < self.mediaListArray.count) {
        mediaCell.model = self.mediaListArray[indexPath.row];
    }
    return mediaCell;
    
}

#pragma mark ---------- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.classifyListType == ClassifyListTypeRecommend) {
        return 150;
    }
    return 293;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.classifyListType == ClassifyListTypeRecommend) {
        DetailViewController *detailVC = [[DetailViewController alloc]init];
        MainModel *model = self.listArray[indexPath.row];
        if (model.link) {
            detailVC.data = model.link;
        }else{
            detailVC.data = model.share_url;
        }
        [self.navigationController pushViewController:detailVC animated:NO];
    }else if (self.classifyListType == ClassifyListTypeMedia){
//        [self.mediaListArray removeAllObjects];
    }
    
    
}
#pragma mark ---------- 上拉加载下拉刷新
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(requestModel) withObject:nil afterDelay:1.0];
}
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    if (_timeStamp > 3600*10) {
        _timeStamp -= 3600*10;
    }
    self.refreshing = NO;
    [self performSelector:@selector(requestModel) withObject:nil afterDelay:1.0];
}
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [HWTools getSystemNowDate];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.pullrefreshV tableViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.pullrefreshV tableViewDidEndDragging:scrollView];
    [self startTimer];
}
- (PullingRefreshTableView *)pullrefreshV{
    if (_pullrefreshV == nil) {
        self.pullrefreshV = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight - 40)pullingDelegate:self];
        self.pullrefreshV.delegate = self;
        self.pullrefreshV.dataSource = self;
        if (self.classifyListType == ClassifyListTypeRecommend) {
            self.pullrefreshV.rowHeight = 90;
        }else if(self.classifyListType ==ClassifyListTypeMedia){
            self.pullrefreshV.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
            self.pullrefreshV.rowHeight = 293;
        }
        
        
    }
    return _pullrefreshV;
}
#pragma mark ---------- CustomMethod
- (void)chooseRequest{
    switch (self.classifyListType) {
        case ClassifyListTypeRecommend:
            [self requestModel];
            break;
        case ClassifyListTypeMedia:
            [self getMediaRequest];
            break;
        default:
            break;
    }
    
}
//网络请求
- (void)requestModel{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [ProgressHUD show:@"别催，加载着呢~"];
    NSString *urlstr =kMainDataList;
    if (!_refreshing) {
        urlstr = [urlstr stringByAppendingString:[NSString stringWithFormat:@"?timestamp=%lu&",_timeStamp]];
    }else{
        if (self.listArray.count > 0){
            [self.listArray removeAllObjects];
        }
    }
    [sessionManager GET: urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ProgressHUD showSuccess:@"已加载~"];
        NSDictionary *resultDic = responseObject;
        
        NSArray *dataArray = resultDic[@"data"];
        if (self.refreshing) {
            if (self.listArray.count > 0) {
                [self.listArray removeAllObjects];
            }
        }
        for (NSDictionary *dit in dataArray) {
            MainModel *model = [[MainModel alloc]initWithDictionary:dit];
            [self.listArray addObject:model];
        }
        
        NSArray *topArray = resultDic[@"top_stories"];
        if (_refreshing) {
            if (self.adArray.count > 0) {
                [self.adArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in topArray) {
            MainModel *model = [[MainModel alloc]initWithDictionary:dic];
            [self.adArray addObject:model];
        }
        [self showPreviousSelectBtn];
        [self.pullrefreshV reloadData];
        [self configTableViewHeaderView];
        [self.pullrefreshV tableViewDidFinishedLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"网络有误!!!%@",error]];
    }];
}
//MV网络请求
- (void)getMediaRequest{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [ProgressHUD show:@"拼命加载中···"];
    [sessionManager GET:kMedia parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ProgressHUD showSuccess:@"已加载~"];
        NSDictionary *resultDic = responseObject;
        NSArray *videosArray = resultDic[@"videos"];
        if (_refreshing) {
            if (self.mediaListArray.count > 0) {
                [self.mediaListArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in videosArray) {
            MediaModel *model = [[MediaModel alloc]initWithDictionary:dic];
            [self.mediaListArray addObject:model];
        }
        [self.pullrefreshV tableViewDidFinishedLoading];

        self.pullrefreshV.reachedTheEnd = NO;
        [self showPreviousSelectBtn];
        [self.pullrefreshV reloadData];
        MJJLog(@"%lu",self.mediaListArray.count);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"网络有误!!!%@",error]];
    }];
}
- (void)showPreviousSelectBtn{
    
    switch (self.classifyListType) {
        case ClassifyListTypeRecommend:
        {
            self.allDataArray = self.listArray;
        }
            break;
        case ClassifyListTypeMedia:
        {
            self.allDataArray = self.mediaListArray;
        }
            break;
            
        default:
            break;
    }
    
    [self.pullrefreshV reloadData];
    if (self.classifyListType == ClassifyListTypeMedia) {
        self.pullrefreshV.tableHeaderView = nil;
    }else{
        self.pullrefreshV.tableHeaderView = self.tableViewHeaderView;
    }
}

- (void)configTableViewHeaderView{
    self.tableViewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 260)];
    self.tableViewHeaderView.backgroundColor = [UIColor whiteColor];
   
    //添加图片
    if (self.adArray.count > 0) {
        for (int i = 0; i < self.adArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i , 0, kScreenWidth, 260)];
            MainModel *model = self.adArray[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
            imageView.userInteractionEnabled = YES;
            [self.carouseView addSubview:imageView];
            
            UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            touchBtn.frame = imageView.frame;
            touchBtn.tag = 100 + i;
            [touchBtn addTarget:self action:@selector(touchADAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.carouseView addSubview:touchBtn];
        
            //标题
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * i + 30, 260 - 40- 30, kScreenWidth - 60, 60)];
            label.text = model.title;
            label.font = [UIFont systemFontOfSize:18.0];
            label.textColor = [UIColor whiteColor];
            label.numberOfLines = 0;
            
            [self.carouseView addSubview:label];
       }
    }
    self.pageControll.numberOfPages = self.adArray.count;
     [self.tableViewHeaderView addSubview:self.carouseView];
    [self.tableViewHeaderView addSubview:self.pageControll];
    [self showPreviousSelectBtn];
}

#pragma mark ---------- 按钮点击方法
- (void)makeAction:(UIButton *)btn{
    SetView *setView = [[SetView alloc]init];
    setView.delegate = self;
    [self.view addSubview:setView];
}
- (void)touchADAction:(UIButton *)btn{
    
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    MainModel *model = self.adArray[btn.tag-100];
    detailVC.data = model.share_url;
    [self.navigationController pushViewController:detailVC animated:NO];
    
}
#pragma mark ---------- 懒加载
- (NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (NSMutableArray *)adArray{
    if (_adArray == nil) {
        self.adArray = [NSMutableArray new];
    }
    return _adArray;
}
- (NSMutableArray *)mediaListArray{
    if (_mediaListArray == nil) {
        self.mediaListArray = [NSMutableArray new];
    }
    
    return _mediaListArray;
}
- (UIScrollView *)carouseView{
    if (_carouseView == nil) {
        self.carouseView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 260)];
        self.carouseView.contentSize = CGSizeMake(self.adArray.count*kScreenWidth, 260);
        self.carouseView.pagingEnabled = YES;
        self.carouseView.scrollEnabled = YES;
        self.carouseView.showsHorizontalScrollIndicator = NO;
        self.carouseView.delegate = self;
        

           }
    return _carouseView;
}
- (UIPageControl *)pageControll{
    if (_pageControll == nil) {
        
        self.pageControll = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 230, kScreenWidth, 30)];
        self.pageControll.currentPageIndicatorTintColor = [UIColor cyanColor];
        [self.pageControll addTarget:self action:@selector(pageControllAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControll;
}

#pragma mark ---------- 首页轮播图
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取scollView页面宽度
    CGFloat pageWidth = self.carouseView.frame.size.width;
    //获取scollView停止移动时的偏移量
    CGPoint offset = self.carouseView.contentOffset;
    //通过偏移量计算当前页面数
    NSInteger pageNum = offset.x/pageWidth;
    self.pageControll.currentPage = pageNum;
    
}
//让scrollView的页面跟随pageControl的滚动移动
- (void)pageControllAction:(UIPageControl *)pageControll{
    //第一步：pageControll当前点击的页面
    NSInteger pageNum = pageControll.currentPage;
    //第二步：获取页面的宽度
    CGFloat pageWidth = self.carouseView.frame.size.width;
    //让scrollView滚动到第几页
    self.carouseView.contentOffset = CGPointMake(pageNum*pageWidth, 0);
}
#pragma mark------轮播图之定时器
- (void)startTimer{
    //防止定时器重复创建
    if (_timer != nil) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(rollAnimation) userInfo:nil repeats:YES];

}
//每两秒执行一次,图片自动轮播
- (void)rollAnimation{
    //sel数组个数可能为0，当对0取余时没有意义
    //把page当前页+1
    if (self.adArray.count > 0) {
        NSInteger rollPage = (self.pageControll.currentPage + 1) % self.adArray.count;
        self.pageControll.currentPage = rollPage;
        //计算scollView应该滚动的坐标
        CGFloat offsetX = self.pageControll.currentPage*kScreenWidth;
        [self.carouseView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //停止计时器
    [self.timer invalidate];
    self.timer = nil;//停止计时器并置为空，再次启动定时器才能正常执行
}

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
        [self.segmentControl addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];    }
    return _segmentControl;
}
- (void)segmentCtrlValuechange:(VOSegmentedControl *)segmentControl{
    self.classifyListType = segmentControl.selectedSegmentIndex + 1;
    [self chooseRequest];
}
- (void)viewDidAppear:(BOOL)animated{
    [self viewWillDisappear:animated];
    [ProgressHUD dismiss];
    [self startTimer];
}
- (void)viewWillDisappear:(BOOL)animated{
    [ProgressHUD dismiss];
    //相当于mrc中的release
    [_timer invalidate], _timer = nil;
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
