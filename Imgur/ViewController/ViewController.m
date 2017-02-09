//
//  ViewController.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/8/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "ViewController.h"
#import "IMGRequestGallery.h"
#import "IMGModel.h"

#import "IMGTableViewCell.h"
#import "IMGCollectionViewCell.h"

#import "Functions.h"

#import "DetailViewController.h"
#import "AboutViewController.h"

NSString * const collectionViewCellIdentifier = @"collectionViewCellIdentifier";
NSString * const tableViewCellIdentifier = @"tableViewCellIdentifier";

#define PADDING 10.0f
#define SEGMENT_HEIGHT 50.0f

@interface ViewController () <IMGRequestGalleryDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *imgData;

@property (nonatomic, strong) UIView *viewHolder;

@end

@implementation ViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self setupTablView];
    [self setupCollectionView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

#pragma mark - Setup
- (void)setup {
    
    [IMGRequestGallery sharedInstance].delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.imgData = [NSMutableArray array];
    
    NSArray *segmentItems = [NSArray arrayWithObjects:@"List View", @"Grid View", nil];
    self.segmentControl = [[UISegmentedControl alloc]initWithItems:segmentItems];
    self.segmentControl.tintColor = [UIColor darkGrayColor];
    self.segmentControl.frame = CGRectMake(PADDING, 65, CGRectGetWidth(self.view.frame) - PADDING*2, SEGMENT_HEIGHT);
    self.segmentControl.selectedSegmentIndex = 0;
    [self.segmentControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentControl];
    
    CGFloat xtraHeight = CGRectGetHeight(self.segmentControl.frame)+50 ;
    self.viewHolder = [[UIView alloc]initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(self.segmentControl.frame), CGRectGetWidth(self.segmentControl.frame), CGRectGetHeight(self.view.frame) - xtraHeight)];
}

- (void)setupTablView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.viewHolder.frame), CGRectGetHeight(self.viewHolder.frame))];
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.viewHolder addSubview:self.tableView];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.tableView.frame collectionViewLayout:flowLayout];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self hideTableView:NO];
    
    [self.collectionView registerClass:[IMGCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    
    [self.viewHolder addSubview:self.collectionView];
}

- (void)loadData {
    
    [[IMGRequestGallery sharedInstance] IMGRequestFromGallery];
    
    
    [self hideViewHolder:YES];
    [Functions displayLoading];
}

#pragma mark - Action
- (void)segmentValueChanged:(UISegmentedControl *)segment {
    if (segment.selectedSegmentIndex == 0)
        [self hideTableView:NO];
    else
        [self hideTableView:YES];
}

- (IBAction)aboutButtonPressed:(id)sender {
    AboutViewController *about = [[AboutViewController alloc]init];
    [self presentViewController:about animated:YES completion:nil];
}


#pragma mark - Helpers
- (void)hideTableView:(BOOL)hide {
    self.tableView.hidden = hide;
    self.collectionView.hidden = !hide;
}

- (void)reloadData {
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (void)displayDetailView:(IMGModel *)img {
    DetailViewController *detail = [[DetailViewController alloc]initWithIMG:img];
    [self.navigationController pushViewController:detail animated:YES];

}

- (void)hideViewHolder:(BOOL)hide {
    if (hide)
        [self.viewHolder removeFromSuperview];
    else
        [self.view addSubview:self.viewHolder];
}

#pragma mark - IMGRequestGalleryDelegate
- (void)finishedWithData:(id)objects {
    [Functions dismissLoading];
    [self hideViewHolder:NO];
    [self.imgData removeAllObjects];
    NSArray *dataObject = (NSArray *)objects;
    [self.imgData addObjectsFromArray:dataObject];

    [self reloadData];
    
}

- (void)fail:(NSString *)error {
    [Functions dismissLoading];
    NSLog(@"failed: %@", error);
}

- (void)sortParamsChanged {
    [self hideViewHolder:YES];
    [Functions displayLoading];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.imgData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    IMGTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    if (cell == nil)
        cell = [[IMGTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];

    [cell setCellData:self.imgData[indexPath.row]];
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.frame.size.width * 2.0 / 3.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self displayDetailView:self.imgData[indexPath.row]];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imgData count];
}

- (IMGCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IMGCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    [cell setCellData:self.imgData[indexPath.row]];

    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width =  CGRectGetWidth(self.tableView.frame)/2 - PADDING;
    return CGSizeMake(width , width);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    [self displayDetailView:self.imgData[indexPath.row]];
}

@end
