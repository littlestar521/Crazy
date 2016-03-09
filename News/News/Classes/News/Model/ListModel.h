//
//  ListModel.h
//  News
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property(nonatomic,copy)NSString *color;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *thumbnail;
@property(nonatomic,copy)NSString *uniq_id;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
