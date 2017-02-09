//
//  IMGRequestGallery.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/11/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "IMGRequestGallery.h"
#import "SessionManager.h"
#import "IMGModel.h"
#import "Constants.h"

#import "NSArray+ReplaceNull.h"

@interface IMGRequestGallery () {
    NSString *sectionKey;
    NSString *sortKey;
    NSString *windowKey;
}
@property (nonatomic, strong) NSString *sectionType;
@property (nonatomic, strong) NSString *sortType;
@property (nonatomic, strong) NSString *windowType;
@end

@implementation IMGRequestGallery

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static IMGRequestGallery *sharedInstance = nil;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IMGRequestGallery alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        
        [self setGallerySectionType:IMGRequestGallerySectionTypeHot];
        [self setGallerySortType:IMGRequestGallerySortTypeTime];
        [self setGalleryWindowType:IMGRequestGalleryWindowTypeAll];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sideBarClosed:) name:kKeySideBarNotification object:nil];
    }
    return self;
}

- (void) IMGRequestFromGallery {
    [[SessionManager sharedInstance] getGalleryWithParams:[self params] andCompletion:^(NSDictionary *obj, NSString *response) {
        if (!response) {
            NSArray *data = [self buildIMGModelFromDictionary:obj];
            if (data.count == 0)
                [self.delegate fail:@"Empty data set"];
            [self.delegate finishedWithData:data];
        } else {
            [self.delegate fail:response];
        }
    }];
}


#pragma mark - helper
- (NSArray *)buildIMGModelFromDictionary:(NSDictionary *)objects {
    
    if (![objects objectForKey:@"data"])
        return [NSArray array];
    
    NSArray *JSONData = [objects[@"data"] replaceNullWithBlankInArray];
    
    NSMutableArray *d = [NSMutableArray new];
    for (NSDictionary *dict in JSONData) {
        if ([[dict objectForKey:@"is_album"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            IMGModel *img = [[IMGModel alloc]initWithObject:dict];
            [d addObject:img];
        }
    }
    return d;
}

- (NSDictionary *)params {
    
    NSDictionary *dict = @{
                           @"section" : self.sectionType == nil ? sectionKey : self.sectionType,
                           @"sort"    : self.sortType == nil ? sortKey :self.sortType,
                           @"window"  : self.windowType == nil ? windowKey : self.windowType
                           };
    
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"obj %@", obj);
        if ([obj isEqual:NULL]) {
            *stop = YES;;
            return;
        }
    }];
    
    return dict;
    
}

- (void)logError {
    NSLog(@"IMGRequestGallery Delegate not set");
}

#pragma mark - setter
- (void)setGallerySectionType:(IMGRequestGallerySectionType)type {
    NSString *title = @"";
    switch (type) {
        case IMGRequestGallerySectionTypeHot:
            title = @"hot";
            break;
        case IMGRequestGallerySectionTypeTop:
            title = @"top";
            break;
        default:
            break;
    }
    sectionKey = title;
    NSLog(@"section type: %@", self.sectionType);
    
}
- (void)setGallerySortType:(IMGRequestGallerySortType)type {
    NSString *tile = @"";
    switch (type) {
        case IMGRequestGallerySortTypeTime:
            tile = @"time";
            break;
        case IMGRequestGallerySortTypeTop:
            tile = @"top";
            break;
        case IMGRequestGallerySortTypeViral:
            tile = @"viral";
            break;
        default:
            break;
    }
    sortKey = tile;
    NSLog(@"sort type: %@", self.sortType);
    
}
- (void)setGalleryWindowType:(IMGRequestGalleryWindowType)type {
    NSString *title = @"";
    switch (type) {
        case IMGRequestGalleryWindowTypeAll:
            title = @"all";
            break;
        case IMGRequestGalleryWindowTypeDay:
            title = @"day";
            break;
        case IMGRequestGalleryWindowTypeMonth:
            title = @"month";
            break;
        case IMGRequestGalleryWindowTypeWeek:
            title = @"week";
            break;
        case IMGRequestGalleryWindowTypeYear:;
            title = @"year";
            break;
        default:
            break;
    }
     windowKey = title;
    NSLog(@"window type: %@", self.windowType);
    
}

- (void)sideBarClosed:(NSNotification *)notification {

    if (![self.sectionType isEqualToString:sectionKey] || ![self.sortType isEqualToString:sortKey] || ![self.windowType isEqualToString:windowKey]){
        [self makeRequestWithNewParams];
    }
}

- (void)setParamKeys {
    self.sectionType = sectionKey;
    self.sortType = sortKey;
    self.windowType = windowKey;
}

- (void)makeRequestWithNewParams {
    [self setParamKeys];
    [self.delegate sortParamsChanged];
    [self IMGRequestFromGallery];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
