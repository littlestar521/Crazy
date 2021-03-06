//
//  HWDefine.h
//  News
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#ifndef HWDefine_h
#define HWDefine_h


#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,ClassifyListType) {
    ClassifyListTypeRecommend = 1,//推荐
    ClassifyListTypeMedia ,//视频
};
typedef NS_ENUM(NSInteger,BillboardType) {
    BillboardTypeRead = 1,
    BillboardTypeLike,
    BillboardTypeComment,
};

//首页数据接口
#define kMainDataList @"http://dailyapi.ibaozou.com/api/v1/documents/latest"
//详情接口
#define kDetail @"http://dailyapi.ibaozou.com/api/v2/articles/6949159/comments"
////音频接口
#define kMedia @"http://dailyapi.ibaozou.com/api/v1/videos/latest"
//排行榜
#define kBillBoard @"http://dailyapi.ibaozou.com/api/v1/rank/%@/day"
//阅读接口
#define kRead @"http://dailyapi.ibaozou.com/api/v1/rank/read/day"
//赞接口
#define kLike @"http://dailyapi.ibaozou.com/api/v1/rank/vote/day"
//评论
#define kComment @"http://dailyapi.ibaozou.com/api/v1/rank/comment/day"
//栏目接口
#define kList @"http://dailyapi.ibaozou.com/api/v1/sections"
//栏目详情
#define kListDetail @"http://dailyapi.ibaozou.com/api/v1/section/%@"
//搜索
#define kSearch @"http://dailyapi.ibaozou.com/api/v1/articles/search"
//新浪微博分享
#define kAppKey @"2439357515"
#define kRedirectURI @"http://api.weibo.com/oauth2/default.html"
//
#define kAppID @"wxd4a0b906317ef2e3"
//bmob
#define kBmobAppKey @"1596dffd91cde0c81728dd0a03e8070a"


#endif /* HWDefine_h */
