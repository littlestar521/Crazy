//
//  MediaTableViewCell.m
//  News
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "MediaTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MediaTableViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *imageV;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *palyTime;


@end
@implementation MediaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(MediaModel *)model{
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
//    self.titleLabel.text = model.title;
//    self.playCount.text = [NSString stringWithFormat:@"%@ 播放",model.play_count];
//    [self.likeBtn setTitle:model.vote_count forState:UIControlStateNormal];
//    [self.commentBtn setTitle:model.comment_count forState:UIControlStateNormal];
//    self.palyTime.text = model.play_time;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
