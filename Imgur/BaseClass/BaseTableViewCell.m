//
//  BaseTableViewCell.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/13/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell



- (void)setup {
    self.backgroundColor = [UIColor clearColor];
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.preservesSuperviewLayoutMargins = false;
    [self setSeparatorInset:UIEdgeInsetsZero];
    [self setLayoutMargins:UIEdgeInsetsZero];
}

- (void)setCellData:(id)data {
    
}

@end
