//
//  HWTools.m
//  News
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "HWTools.h"

@implementation HWTools
+ (NSString *)getDataFromString:(NSString *)timeStamp{
    NSTimeInterval time = [timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}
+ (NSDate *)getSystemNowDate{
    NSDateFormatter *dF = [[NSDateFormatter alloc]init];
    dF.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [dF stringFromDate:[NSDate date]];
    NSDate *date = [dF dateFromString:dateStr];
    return date;
}
+ (CGFloat)getTextHeightWithText:(NSString *)text biggestSize:(CGSize)bigSize textFont:(CGFloat)textFont{
    CGRect textRext = [text boundingRectWithSize:bigSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]} context:nil];
    return textRext.size.height;
}
+ (NSTimeInterval)getTimestamp{
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970];
    return time;
}

@end
