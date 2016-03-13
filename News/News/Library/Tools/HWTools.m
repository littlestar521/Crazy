//
//  HWTools.m
//  News
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "HWTools.h"

@implementation HWTools
+ (NSDate *)getSystemNowDate{
    NSDateFormatter *dF = [[NSDateFormatter alloc]init];
    dF.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [dF stringFromDate:[NSDate date]];
    NSDate *date = [dF dateFromString:dateStr];
    return date;
}

+ (NSTimeInterval)getTimestamp{
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970];
    return time;
}

@end
