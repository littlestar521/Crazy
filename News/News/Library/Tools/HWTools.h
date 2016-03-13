//
//  HWTools.h
//  News
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HWTools : NSObject
//时间转换的相关方法

+ (NSDate *)getSystemNowDate;

+ (NSTimeInterval)getTimestamp;
@end
