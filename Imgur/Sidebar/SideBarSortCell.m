//
//  SideBarSortCell.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/13/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "SideBarSortCell.h"

@interface SideBarSortCell ()
@end

@implementation SideBarSortCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    [super setup];
}

- (void)setSectionInfoForRow:(NSInteger)row {
    [self.titleLabel setText:TITLE_SORT_TYPE[row]];
}

- (void)cellSelectedForRow:(NSInteger)row {
    [[IMGRequestGallery sharedInstance] setGallerySortType:row];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
