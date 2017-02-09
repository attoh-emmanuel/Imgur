//
//  IMGCollectionViewCell.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/14/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "IMGCollectionViewCell.h"
#import "IMGModel.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface IMGCollectionViewCell ()
@property (nonatomic, strong) UILabel *imgLabel;
@property (nonatomic, strong) UIImageView *imgImageView;
@end

@implementation IMGCollectionViewCell


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.imgImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
self.imgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imgImageView];
    
    self.imgLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.imgLabel setTextColor:[UIColor redColor]];
    [self.contentView addSubview:self.imgLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.imgLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/4);
}

- (void)setCellData:(id)data {
    
    IMGModel *img = (IMGModel *)data;
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:img.imglink] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    [self.imgLabel setText:img.imgtitle];
}

@end
