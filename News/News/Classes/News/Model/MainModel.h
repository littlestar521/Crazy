//
//  MainModel.h
//  News
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

@property(nonatomic,strong)NSString *article_type;//文章类型
@property(nonatomic,strong)NSString *comment_count;//评论数
@property(nonatomic,strong)NSString *created_at;//创建时间
@property(nonatomic,strong)NSString *document_id;
@property(nonatomic,strong)NSString *hit_count;//阅读量
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *link;
//详情
@property(nonatomic,strong)NSString *publish_time;//出版时间
@property(nonatomic,strong)NSString *name;//上传者名字
@property(nonatomic,strong)NSString *source_name;//来源名
@property(nonatomic,strong)NSString *title;//标题
@property(nonatomic,strong)NSString *thumbnail;
@property(nonatomic,strong)NSString *section_name;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
