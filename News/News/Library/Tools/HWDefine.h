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

//首页数据接口
#define kMainDataList @"http://dailyapi.ibaozou.com/api/v1/documents/latest"
//详情接口
#define kDetail @"http://dailyapi.ibaozou.com/api/v2/articles/6949159/comments"

#define kMedia @"http://dailyapi.ibaozou.com/api/v1/videos/latest"
////音频接口
#define media @"http://dailyapi.ibaozou.com/api/v1/videos/latest"

#endif /* HWDefine_h */
