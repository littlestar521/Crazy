//
//  MediaModel.m
//  News
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "MediaModel.h"

@implementation MediaModel
- (instancetype)initWithDictionary:(NSDictionary *)dit{
    self =  [super init];
    if (self) {
        self.image = dit[@"image"];
        self.title = dit[@"title"];
        self.play_count = [dit[@"play_count"] stringValue];
        self.vote_count = [dit[@"vote_count"] stringValue];
        self.comment_count = [dit[@"comment_count"] stringValue];
        self.first_url = dit[@"first_url"];
        self.play_time = [dit[@"play_time"] stringValue];
    }
    return self;
}

@end
