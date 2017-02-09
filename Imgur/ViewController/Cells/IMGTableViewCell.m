//
//  IMGTableViewCell.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/14/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "IMGTableViewCell.h"
#import "IMGModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface IMGTableViewCell ()
@property (nonatomic, strong) UIImageView *imgImageView;
@property (nonatomic, strong) UILabel *imgTitleLabel;
@end

@implementation IMGTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    [super setup];
    
    self.imgImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.imgImageView.contentMode = UIViewContentModeRedraw;
    [self.contentView addSubview:self.imgImageView];
    
    self.imgTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.imgTitleLabel.textColor = [UIColor redColor];
    self.imgTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.contentView addSubview:self.imgTitleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imgImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.frame.size.width * 2.0 / 3.0);
    self.imgTitleLabel.frame = CGRectMake(5, 0, CGRectGetWidth(self.frame)-10, 50);
}


- (void)setCellData:(id)data {
    IMGModel *img = (IMGModel *)data;
    self.imgTitleLabel.text = img.imgtitle;
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:img.imglink] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"cached type %ld", (long)cacheType);
    }];
    
    
    
}

@end
