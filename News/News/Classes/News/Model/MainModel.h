//
//  MainModel.h
//  News
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

@property(nonatomic,copy)NSString *article_type;//文章类型
@property(nonatomic,copy)NSString *comment_count;//评论数
@property(nonatomic,copy)NSString *created_at;//创建时间
@property(nonatomic,copy)NSString *document_id;
@property(nonatomic,copy)NSString *hit_count;//阅读量
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *link;
//详情
@property(nonatomic,copy)NSString *url;//
@property(nonatomic,copy)NSString *name;//上传者名字
@property(nonatomic,copy)NSString *source_name;//来源名
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *thumbnail;
@property(nonatomic,copy)NSString *section_name;
@property(nonatomic,copy)NSString *share_url;
@property(nonatomic,copy)NSString *author_name;
@property(nonatomic,copy)NSString *section_color;
@property(nonatomic,copy)NSArray *recommenders;
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *uniq_id;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
