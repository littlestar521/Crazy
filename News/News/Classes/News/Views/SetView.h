//
//  SetView.h
//  News
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PushVCDelegate <NSObject>

- (void)getOtherViewController:(UIViewController *)otherVC;


@end
@interface SetView : UIView
@property(nonatomic,assign)id<PushVCDelegate>delegate;
@end
