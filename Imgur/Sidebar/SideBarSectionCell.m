//
//  SideBarSectionCell.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/13/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//


#import "SideBarSectionCell.h"
#import "IMGRequestGalleryEnum.h"



@interface SideBarSectionCell ()
@end

@implementation SideBarSectionCell

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
    [self.titleLabel setText:TITLE_SECTION_TYPE[row]];
}

-(void)cellSelectedForRow:(NSInteger)row {
    NSLog(@"%ld", (long)row);
    [[IMGRequestGallery sharedInstance] setGallerySectionType:row];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected)
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        self.accessoryType = UITableViewCellAccessoryNone;
}


@end
