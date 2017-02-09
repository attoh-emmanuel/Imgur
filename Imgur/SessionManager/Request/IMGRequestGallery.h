//
//  IMGRequestGallery.h
//  MobiLabTest
//
//  Created by Emmanuel on 4/11/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMGRequestGalleryEnum.h"


@protocol IMGRequestGalleryDelegate <NSObject>
@required
- (void)fail:(NSString *)error;
- (void)finishedWithData:(id)objects;
@optional
- (void)sortParamsChanged;
@end

@interface IMGRequestGallery : NSObject
@property (nonatomic, weak) id <IMGRequestGalleryDelegate> delegate;

+ (instancetype) sharedInstance;

- (void)IMGRequestFromGallery;

- (void)setGallerySectionType:(IMGRequestGallerySectionType)type;
- (void)setGalleryWindowType:(IMGRequestGalleryWindowType)type;
- (void)setGallerySortType:(IMGRequestGallerySortType)type;



@end
