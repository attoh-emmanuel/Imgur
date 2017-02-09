//
//  BaseSidebarCell.h
//  MobiLabTest
//
//  Created by Emmanuel on 4/16/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "BaseTableViewCell.h"

#define TITLE_SECTION_TYPE @[ @"Hot", @"Top"]
#define TITLE_SORT_TYPE @[ @"Viral", @"Top", @"Time"]
#define TITLE_WINDOW_TYPE @[ @"Day", @"Week", @"Month", @"Year",@"All"]

@interface BaseSidebarCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *cellIdentifier;

- (void)setSectionInfoForRow:(NSInteger)row;
- (void)cellSelectedForRow:(NSInteger)row;

@end
