//
//  DetailViewController.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/14/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Functions.h"
#import "UILabel+Boldify.h"
#define PADDING 10.0f

@interface DetailViewController ()
@property (nonatomic, strong) IMGModel *imgObj;

@property (nonatomic, strong) UIImageView *imgImageView;

@property (nonatomic, strong) UILabel *imgTitleLabel;
@property (nonatomic, strong) UILabel *imgDescriptionLabel;
@property (nonatomic, strong) UILabel *imgUpVotesLabel;
@property (nonatomic, strong) UILabel *imgDownVotesLabel;
@property (nonatomic, strong) UILabel *imgScoreLabel;

@end

@implementation DetailViewController

- (instancetype)initWithIMG:(IMGModel *)object {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.imgObj = object;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
//    show its details: big image, title, description, upvotes, downvotes and score
    [self setup];
    [self setViewData];
}

- (void)setup {
    CGRect defaultHeight;
    defaultHeight.size.height = 300;
    self.imgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)*2.0 / 3.0)];
    self.imgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imgImageView];
    
    self.imgTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(self.imgImageView.frame), CGRectGetWidth(self.imgImageView.frame)-PADDING*2, 50)];
    self.imgTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    self.imgTitleLabel.numberOfLines = 2;
    [self.view addSubview:self.imgTitleLabel];
    
    self.imgDescriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.imgTitleLabel.frame), CGRectGetMaxY(self.imgTitleLabel.frame), CGRectGetWidth(self.imgTitleLabel.frame), 0)];
    CGRect newFrame = [self setFrameForRowLabelString:self.imgObj.imgdescription Size:CGSizeMake(CGRectGetWidth(self.view.frame), CGFLOAT_MAX) fontAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:20]} andFrame:self.imgDescriptionLabel.frame];
    
    newFrame.size.height >= 350 ? newFrame.size.height = defaultHeight.size.height : newFrame.size.height;
    self.imgDescriptionLabel.frame = newFrame;
    self.imgDescriptionLabel.numberOfLines = 0;
    [self.view addSubview:self.imgDescriptionLabel];
    
    self.imgUpVotesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgDescriptionLabel.frame), CGRectGetWidth(self.view.frame)/3, 25)];
    self.imgUpVotesLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.imgUpVotesLabel];
    
    self.imgDownVotesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imgUpVotesLabel.frame), CGRectGetMinY(self.imgUpVotesLabel.frame), CGRectGetWidth(self.imgUpVotesLabel.frame), CGRectGetHeight(self.imgUpVotesLabel.frame))];
    self.imgDownVotesLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.imgDownVotesLabel];
    
    self.imgScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imgDownVotesLabel.frame), CGRectGetMinY(self.imgDownVotesLabel.frame), CGRectGetWidth(self.imgDownVotesLabel.frame), CGRectGetHeight(self.imgDownVotesLabel.frame))];
    self.imgScoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.imgScoreLabel];
    
}


- (void)setViewData {
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:self.imgObj.imglink] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
    [self.imgTitleLabel setText:[NSString stringWithFormat:@"Title: %@",self.imgObj.imgtitle]];
    [self.imgTitleLabel boldSubstring: @"Title:"];
    
    [self.imgDescriptionLabel setText:[NSString stringWithFormat:@"Description: %@",self.imgObj.imgdescription]];
    [self.imgDescriptionLabel boldSubstring: @"Description:"];
    
    [self.imgUpVotesLabel setText:[NSString stringWithFormat:@"up vote:%ld", (long)self.imgObj.imgupvotes]];
    [self.imgUpVotesLabel boldSubstring: @"up vote:"];
    
    [self.imgDownVotesLabel setText:[NSString stringWithFormat:@"Down vote:%ld", (long)self.imgObj.imgdownvotes]];
    [self.imgDownVotesLabel boldSubstring: @"Down vote:"];
    
    [self.imgScoreLabel setText:[NSString stringWithFormat:@"Score:%ld", (long)self.imgObj.imgscore]];
    [self.imgScoreLabel boldSubstring: @"Score:"];
}


#pragma mark - Helper
- (CGRect)setFrameForRowLabelString:(NSString *)text Size:(CGSize)size fontAttributes:(NSDictionary *)attribute andFrame:(CGRect)lblframe {
    CGRect rect = [text boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attribute
                              context:nil];
    
    CGRect fr = lblframe;
    fr.size.height = rect.size.height;
    
    return fr;
}



@end
