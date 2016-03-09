//
//  ListModel.m
//  News
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.color = dic[@""];
        self.desc = dic[@"description"];
        self.name = dic[@"name"];
        self.thumbnail = dic[@"thumbnail"];
        self.uniq_id = dic[@"uniq_id"];
        
    }
    return self;
}
@end
