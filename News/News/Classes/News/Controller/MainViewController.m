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
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPSessionManager.h>


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UIScrollView *carouseView;
@property(nonatomic,strong)UIPageControl *pageControll;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIView *tableViewHeaderView;
@property(nonatomic,strong)VOSegmentedControl *segmentControl;
@property(nonatomic,strong)NSMutableArray *adArray;
@property(nonatomic,strong)NSMutableArray *listArray;



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"暴走日报";
    self.navigationController.navigationBar.backgroundColor = MineColor;
    [self.view addSubview:self.segmentControl];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self requestModel];

}

#pragma mark ---------- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //防止数组越界
    if (indexPath.row < self.listArray.count) {
        cell.model = self.listArray[indexPath.row];
    }
    return cell;
}

#pragma mark ---------- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark ---------- CustomMethod
- (void)configTableViewHeaderView{
    self.tableViewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 260)];
    self.tableViewHeaderView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.tableViewHeaderView;
    NSLog(@"!!!!!%lu", self.adArray.count);

    
       [self.tableViewHeaderView addSubview:self.carouseView];
    //添加图片
//    if (!self.adArray.count) {
        for (int i = 0; i < self.adArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i , 0, kScreenWidth, 260)];
            MJJLog(@"%@",self.adArray[i]);
            MainModel *model = self.adArray[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
            
            MJJLog(@"%@",model.image);
            
            imageView.userInteractionEnabled = YES;
            [self.carouseView addSubview:imageView];
            
            UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            touchBtn.frame = imageView.frame;
            touchBtn.tag = 100 + i;
            [touchBtn addTarget:self action:@selector(touchADAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.carouseView addSubview:touchBtn];
//        }
            //标题
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * i + 30, 260 - 40- 30, kScreenWidth - 60, 60)];
            label.text = model.title;
            label.font = [UIFont systemFontOfSize:18.0];
            label.textColor = [UIColor whiteColor];
            label.numberOfLines = 0;
            
            [self.carouseView addSubview:label];
    }
//    if (!self.adArray.count) {
    
    self.pageControll.numberOfPages = self.adArray.count;
 
//    }
    MJJLog(@"1111111%@",self.adArray);
    [self.tableViewHeaderView addSubview:self.pageControll];
    
    
    
}
//网络请求
- (void)requestModel{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [sessionManager GET:kMainDataList parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = responseObject;
        NSArray *dataArray = resultDic[@"data"];
        for (NSDictionary *dit in dataArray) {
            MainModel *model = [[MainModel alloc]initWithDictionary:dit];
            [self.listArray addObject:model];
         }
//        MJJLog(@"%ld",self.listArray.count);
        NSArray *topArray = resultDic[@"top_stories"];
        for (NSDictionary *dic in topArray) {
            MainModel *model = [[MainModel alloc]initWithDictionary:dic];
            [self.adArray addObject:model];

        }
        for (NSString *url in self.adArray) {
            MJJLog(@"%@",url);
        }
         [self.tableView reloadData];
        [self configTableViewHeaderView];
       
//        MJJLog(@"%lu",self.adArray.count);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


#pragma mark ---------- 按钮点击方法
- (void)touchADAction:(UIButton *)btn{
    
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
- (UIScrollView *)carouseView{
    if (_carouseView == nil) {
        self.carouseView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 260)];
        MJJLog(@"#####%lu", self.adArray.count);
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
//- (NSTimer *)timer{
//    if (_timer == nil) {
//        self.timer = [NSTimer new];
//    }
//    return _timer;
//}

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
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(rollAnimation) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
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

//当scollView是手动滑动的时候，定时器依然在计算时间，可能我们刚刚滑到下一页，导致在当前页停留的时间不够两秒。
//解决方案在scollView开始移动的时候结束定时器
//在scollView移动完毕的时候再启动定时器
//scollview将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //停止计时器
    [self.timer invalidate];
    self.timer = nil;//停止计时器并置为空，再次启动定时器才能正常执行
}
//scollView将要结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
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
        //返回点击的是哪个按钮
        [self.segmentControl addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];    }
    return _segmentControl;
}
- (void)segmentCtrlValuechange:(VOSegmentedControl *)segmentControl{
    self.classifyListType = segmentControl.selectedSegmentIndex + 1;
    
}
- (void)viewDidAppear:(BOOL)animated{
    [self startTimer];
}
- (void)viewWillDisappear:(BOOL)animated{
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
