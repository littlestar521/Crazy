//
//  MediaTableViewCell.m
//  News
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "MediaTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SelfViewController.h"
#import "ShareView.h"
@interface MediaTableViewCell ()

@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UILabel *palyTime;

- (IBAction)playBtnAction:(id)sender;

- (IBAction)likeBtnAction:(id)sender;
- (IBAction)commentBtnAction:(id)sender;

- (IBAction)shareBtnAction:(id)sender;

@end
@implementation MediaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(MediaModel *)model{
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.titleLabel.text = model.title;
    self.playCount.text = [NSString stringWithFormat:@"%@ 播放",model.play_count];
    [self.likeBtn setTitle:model.vote_count forState:UIControlStateNormal];
    [self.commentBtn setTitle:model.comment_count forState:UIControlStateNormal];
    NSInteger time = [model.play_time integerValue];
    self.palyTime.text = [NSString stringWithFormat:@"%lu:%02lu",time/60,time%60];
    self.url = model.first_url;
    
    
    
    
}
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSString *urlstr = [self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlstr];
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
        _moviePlayer.view.frame = CGRectMake(4, 5, 367, 192);
        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.moviePlayer.view];
    }
    return _moviePlayer;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)playBtnAction:(id)sender {
    [self.moviePlayer play];
}

- (IBAction)likeBtnAction:(id)sender {
    SelfViewController *selfVC = [[SelfViewController alloc]init];
    if (self.delegate && [self.delegate respondsToSelector:@selector(getOneVC:)]) {
        [self.delegate getOneVC:selfVC];
        [selfVC popoverPresentationController];
    }
    
}

- (IBAction)commentBtnAction:(id)sender {
}

- (IBAction)shareBtnAction:(id)sender {
    ShareView *shareView =[[ShareView alloc]init];
    [self addSubview:shareView];
}
@end
