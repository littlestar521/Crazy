//
//  MainModel.m
//  News
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.article_type = dic[@"article_type"];
        self.comment_count = dic[@"comment_count"];
        self.created_at = dic[@"created_at"];
        self.document_id = dic[@"document_id"];
        self.hit_count = dic[@"hit_count_string"];
        self.image = dic[@"image"];
        self.link = dic[@"link"];
        self.url = dic[@"url"];
        
        self.title = dic[@"title"];
        self.source_name = dic[@"source_name"];
        self.thumbnail = dic[@"thumbnail"];
        self.section_name = dic[@"section_name"];
        self.share_url = dic[@"share_url"];
        self.author_name = dic[@"author_name"];
        self.section_color = dic[@"section_color"];
        self.recommenders = dic[@"recommenders"];
        self.uniq_id = dic[@"uniq_id"];
        if (self.recommenders.count > 0) {
            NSDictionary *recomDic = _recommenders[0];
            self.avatar = recomDic[@"avatar"];
            self.name = recomDic[@"name"];
        }
        
        
    }
    return self;
}

@end
