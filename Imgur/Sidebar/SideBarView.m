//
//  SideBarView.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/13/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "SideBarView.h"
#import "SideBarSectionCell.h"
#import "SideBarSortCell.h"
#import "SideBarWindowCell.h"

#define WIDTH 300.0f
#define TITLE_HEIGHT 30.0f

@interface SideBarView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *sideBarTableView;
@property (nonatomic, strong) SideBarSectionCell *sectionCell;
@property (nonatomic, strong) SideBarSortCell *sortCell;
@property (nonatomic, strong) SideBarWindowCell *windowCell;
@end

@implementation SideBarView

#pragma mark - Setup

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, TITLE_HEIGHT)];
    [title setTextColor:[UIColor whiteColor]];
    [title setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setText:@"Sort Feed"];
    [self addSubview:title];
    
    self.sideBarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame), WIDTH, CGRectGetHeight(self.frame)- CGRectGetHeight(title.frame))];
    [self.sideBarTableView setDelegate:self];
    [self.sideBarTableView setDataSource:self];
    [self.sideBarTableView setShowsVerticalScrollIndicator:NO];
    [self.sideBarTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.sideBarTableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.sideBarTableView];
    
}

#pragma mark - UITableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 2;
    else if (section == 1)
        return 3;
    else
        return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return [self SideBarSectionCellWithIdentifier:@"sectionCell" andIndexPath:indexPath];
    else if (indexPath.section == 1)
        return [self SideBarSortCellWithIdentifier:@"sortCell" andIndexPath:indexPath];
    else
        return [self SideBarWindowCellWithIdentifier:@"windowCell" andIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 60)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, CGRectGetWidth(tableView.bounds), TITLE_HEIGHT)];
    [headerLabel setTextAlignment:NSTextAlignmentLeft];
    [headerLabel setTextColor:[UIColor blackColor]];
    [headerLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    if (section == 0)
        headerLabel.text = @"Section Key";
    else if (section == 1)
        headerLabel.text = @"Sort Key";
    else
        headerLabel.text = @"Window Key";
    
    [headerView addSubview:headerLabel];
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0)
        return @"Section Key";
    else if(section == 1)
        return @"Sort Key";
    else
        return @"Window Key";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0)
        [_sectionCell cellSelectedForRow:indexPath.row];
    else if (indexPath.section == 1)
        [_sortCell cellSelectedForRow:indexPath.row];
    else
        [_windowCell cellSelectedForRow:indexPath.row];
    
    
}
#pragma mark - Helpers
- (SideBarSectionCell *)SideBarSectionCellWithIdentifier:(NSString *)cellIdentifier andIndexPath:(NSIndexPath *)indexPath{
    self.sectionCell = [self.sideBarTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (self.sectionCell == nil)
        self.sectionCell = [[SideBarSectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    [self.sectionCell setSectionInfoForRow:indexPath.row];
    return self.sectionCell;
}

- (SideBarSortCell *)SideBarSortCellWithIdentifier:(NSString *)cellIdentifier andIndexPath:(NSIndexPath *)indexPath {
     self.sortCell = [self.sideBarTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (self.sortCell  == nil)
        self.sortCell  = [[SideBarSortCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    [self.sortCell setSectionInfoForRow:indexPath.row];
    return self.sortCell ;
}

- (SideBarWindowCell *)SideBarWindowCellWithIdentifier:(NSString *)cellIdentifier andIndexPath:(NSIndexPath *)indexPath {
     self.windowCell = [self.sideBarTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (self.windowCell == nil)
        self.windowCell = [[SideBarWindowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    [self.windowCell setSectionInfoForRow:indexPath.row];
    return self.windowCell;
}



@end
