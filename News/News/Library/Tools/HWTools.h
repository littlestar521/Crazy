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
+ (NSString *)getDataFromString:(NSString *)timeStamp;
+ (NSDate *)getSystemNowDate;
//根据文字内容返回文字高度
+ (CGFloat)getTextHeightWithText:(NSString *)text biggestSize:(CGSize)bigSize textFont:(CGFloat)textFont;

+ (NSTimeInterval)getTimestamp;
@end
