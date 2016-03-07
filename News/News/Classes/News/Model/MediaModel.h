//
//  MediaModel.h
//  News
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaModel : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *play_count;
@property(nonatomic,strong)NSString *vote_count;
@property(nonatomic,strong)NSString *comment_count;
@property(nonatomic,strong)NSString *first_url;
@property(nonatomic,strong)NSString *play_time;
- (instancetype)initWithDictionary:(NSDictionary *)dit;
@end
