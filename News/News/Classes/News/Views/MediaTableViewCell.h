//
//  MediaTableViewCell.h
//  News
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaModel.h"

@protocol MediaDelegate <NSObject>

- (void)getOneVC:(UIViewController *)oneVC;

@end
@interface MediaTableViewCell : UITableViewCell


@property(nonatomic,strong)MediaModel *model;

@property(nonatomic,strong)id<MediaDelegate>delegate;


@end
