//
//  SessionManager.h
//  MobiLabTest
//
//  Created by Emmanuel on 4/10/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SessionManager : AFHTTPSessionManager

+ (instancetype) sharedInstance;
+ (instancetype) authenticateApplicationWithClientID:(NSString *)clientID;

- (void)getGalleryWithParams:(NSDictionary *)param andCompletion:(void(^)(NSDictionary *obj, NSString *response))completion;


@end
