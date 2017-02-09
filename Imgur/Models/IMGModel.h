//
//  imgModel.h
//  MobiLabTest
//
//  Created by Emmanuel on 4/11/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMGModel : NSObject  <NSCoding>

@property (nonatomic, strong) NSString *imglink;
@property (nonatomic, strong) NSString *imgtitle;
@property (nonatomic, strong) NSString *imgdescription;

@property (nonatomic, readonly) NSInteger imgupvotes;
@property (nonatomic, readonly) NSInteger imgdownvotes;
@property (nonatomic, readonly) NSInteger imgscore;
- (instancetype)initWithObject:(NSDictionary *)dict;

@end
