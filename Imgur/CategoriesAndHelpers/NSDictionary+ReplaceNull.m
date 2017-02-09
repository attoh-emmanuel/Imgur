//
//  NSDictionary+ReplaceNull.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/14/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "NSDictionary+ReplaceNull.h"

@implementation NSDictionary (ReplaceNull)


- (NSDictionary *)replaceNullWithBlankInDictionary {
    
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nulValue = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        
        if (object == nulValue) {
            [replaced setObject:blank forKey:key];
        }else if ([object isKindOfClass:[NSDictionary class]]) {
            [replaced setObject:[object replaceNullWithBlankInDictionary] forKey:key];
        } else if ([object isKindOfClass:[NSArray class]]) {
            [replaced setObject:[object replaceNullWithBlankInArray] forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

@end
