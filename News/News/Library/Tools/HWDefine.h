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
//阅读接口
#define kRead @"http://dailyapi.ibaozou.com/api/v1/rank/read/day"
//赞接口
#define kLike @"http://dailyapi.ibaozou.com/api/v1/rank/vote/day"
//评论
#define kComment @"http://dailyapi.ibaozou.com/api/v1/rank/comment/day"
#endif /* HWDefine_h */
