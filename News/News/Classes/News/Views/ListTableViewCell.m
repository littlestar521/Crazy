//
//  ListTableViewCell.m
//  News
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "ListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(ListModel *)model{
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:nil];
    self.nameLabel.text = model.name;
    self.descriptionLabel.text = model.desc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
