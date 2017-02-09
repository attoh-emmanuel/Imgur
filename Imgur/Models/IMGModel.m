//
//  IMGModel.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/11/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "IMGModel.h"
#import "Constants.h"

@implementation IMGModel

- (instancetype)initWithObject:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setupWithDictionary:dict];
    }
    return self;
}

- (void)setupWithDictionary:(NSDictionary *)data {
    
    _imglink = data[kKeyNameLink];
    _imgtitle = data[kKeyNameTitle];
    _imgdescription = data[kKeyNameDescription];
    _imgupvotes = [data[kKeyNameUpVote] integerValue];
    _imgdownvotes = [data[kKeyNameDownVotes] integerValue];
    _imgscore = [data[kKeyNameScore]integerValue];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _imglink = [aDecoder decodeObjectForKey:kKeyNameLink];
        _imgtitle = [aDecoder decodeObjectForKey:kKeyNameTitle];
        _imgdescription = [aDecoder decodeObjectForKey:kKeyNameDescription];
        _imgupvotes = [[aDecoder decodeObjectForKey:kKeyNameUpVote] integerValue];
        _imgdownvotes = [[aDecoder decodeObjectForKey:kKeyNameDownVotes] integerValue];
        _imgscore = [[aDecoder decodeObjectForKey:kKeyNameScore] integerValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.imglink forKey:kKeyNameLink];
    [aCoder encodeObject:self.imgtitle forKey:kKeyNameTitle];
    [aCoder encodeObject:self.imgdescription forKey:kKeyNameDescription];
    [aCoder encodeObject:@(self.imgupvotes) forKey:kKeyNameUpVote];
    [aCoder encodeObject:@(self.imgdownvotes) forKey:kKeyNameDownVotes];
    [aCoder encodeObject:@(self.imgscore) forKey:kKeyNameScore];
}
@end
