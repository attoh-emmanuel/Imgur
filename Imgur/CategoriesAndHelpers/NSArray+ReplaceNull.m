//
//  NSArray+ReplaceNull.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/14/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "NSArray+ReplaceNull.h"

@implementation NSArray (ReplaceNull)

- (NSArray *)replaceNullWithBlankInArray {
    
    NSMutableArray *replaced = [self mutableCopy];
    const id nulValue = [NSNull null];
    const NSString *blank = @"";
    
    for (int i = 0; i < [replaced count]; i++) {
        id object = [replaced objectAtIndex:i];
        
        if (object == nulValue) {
            [replaced replaceObjectAtIndex:i withObject:blank];
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            [replaced replaceObjectAtIndex:i withObject:[object replaceNullWithBlankInDictionary]];
        } else if ([object isKindOfClass:[NSArray class]]){
            [replaced replaceObjectAtIndex:i withObject:[object replaceNullWithBlankInArray]];
        }
    }
    
    return [replaced copy];
}


@end
