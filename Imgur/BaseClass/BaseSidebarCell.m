//
//  BaseSidebarCell.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/16/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "BaseSidebarCell.h"
#define PADDING 20.0f

@implementation BaseSidebarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [super setup];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel setFrame:CGRectMake(PADDING, 0, CGRectGetWidth(self.frame)-PADDING, CGRectGetHeight(self.frame))];
}

//@override
- (void)setSectionInfoForRow:(NSInteger)row {
}
- (void)cellSelectedForRow:(NSInteger)row {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected)
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        self.accessoryType = UITableViewCellAccessoryNone;
    
}

@end
