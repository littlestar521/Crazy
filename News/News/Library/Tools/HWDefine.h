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
//分类列表接口
#define kClassifyList @"http://dailyapi.ibaozou.com/api/v2/articles/6949159/comments"
//音频接口
#define k4 @"http://dailyapi.ibaozou.com/api/v1/videos/latest"
//
#define media @"http://dailyapi.ibaozou.com/api/v1/videos/latest?timestamp=1456970400000&"

#endif /* HWDefine_h */
