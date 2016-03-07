//
//  MainTableViewCell.m
//  News
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "MainTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MainTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *source_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *name;


@end
@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(MainModel *)model{
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:nil];
    self.titleLabel.text = model.title;
    self.name.text = model.section_name;
    self.source_nameLabel.text = [NSString stringWithFormat:@"%@ | %@ 阅读",model.source_name,model.hit_count];
    

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
