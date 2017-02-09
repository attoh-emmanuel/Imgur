//
//  SessionManager.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/10/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "SessionManager.h"
#import "Constants.h"
#import "IMGModel.h"

@implementation SessionManager

- (instancetype)init {
    if (self = [super initWithBaseURL:[NSURL URLWithString:IMGUR_BASE_URL]]) {
    }
    return self;
}

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static SessionManager *sharedInstance = nil;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SessionManager alloc] init];
    });
    return sharedInstance;
}

+ (instancetype)authenticateApplicationWithClientID:(NSString *)clientID {
    return [self authenticateWithID:clientID];
}

+ (instancetype)authenticateWithID:(NSString *)clientID {
    [[SessionManager sharedInstance] setAuthorizationHeaderForAnonmyousSession:clientID];
    return [self sharedInstance];
}

#pragma mark - Authorization header
- (void)setAuthorizationHeaderForAnonmyousSession:(NSString *)clientID {
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Client-ID %@", clientID] forHTTPHeaderField:@"Authorization"];
}

#pragma mark - GET

- (void)getGalleryWithParams:(NSDictionary *)param andCompletion:(void (^)(NSDictionary *, NSString *))completion {
    
    NSString *endPoint =  ([param count] == 0 ) ? IMGUR_GALLERY_END_POINT : [NSString stringWithFormat:IMGUR_GALLERY_END_POINT,param[@"section"], param[@"sort"], param[@"window"]] ;
    
    [[SessionManager sharedInstance] GET:endPoint parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error.localizedDescription);
    }];
}
@end

