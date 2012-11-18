//
//  NetworkService.h
//  Table
//
//  Created by Jakub Hladík on 24.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "Item.h"

@interface NetworkService : NSObject

+ (NetworkService *)sharedService;

- (void)getJSONAtPath:(NSString *)aPath
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))onSuccess
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))onFailure;

- (void)postJSONObject:(id)JSONObject
                toPath:(NSString *)aPath
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))onSuccess
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))onFailure;

- (void)getFriendsSuccess:(void (^)(NSMutableArray *array))onSuccess failure:(void (^)())onFailure;
- (void)getFriendWithId:(NSUInteger)anId;

- (void)createFriend:(Item *)item success:(void (^)(Item *item))onSuccess failure:(void (^)())onFailure;

- (void)updateFriend:(Item *)item withImage:(UIImage *)anImage success:(void (^)(Item *item))onSuccess failure:(void (^)())onFailure;

- (void)put;

@end
