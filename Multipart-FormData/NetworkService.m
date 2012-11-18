//
//  NetworkService.m
//  Table
//
//  Created by Jakub Hladík on 24.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "NetworkService.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "ToastService.h"
#import "Item.h"

@interface NetworkService ()

@property (nonatomic, strong) AFHTTPClient *client;

@end

@implementation NetworkService

+ (NetworkService *)sharedService
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[NetworkService alloc] init];
    });
}

- (id)init
{
    self = [super init];
    if (self) {
//        NSURL *url = [NSURL URLWithString:@"http://localhost:3000"];
        NSURL *url = [NSURL URLWithString:@"http://illy.kubbing.com:3000"];
        _client = [AFHTTPClient clientWithBaseURL:url];
        [_client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        _client.operationQueue.maxConcurrentOperationCount = 2;
        
//        [_client setDefaultHeader:@"Accept-Charset" value:@"UTF-8"];
//        [_client setDefaultHeader:@"Accept-Charset" value:@"utf-8"];
    }
    
    return self;
}

- (void)getJSONAtPath:(NSString *)aPath
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))onSuccess
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))onFailure
{
    [_client getPath:aPath
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 TRC_LOG(@"%d, GET %@", operation.response.statusCode, operation.request.URL);
                 onSuccess(operation, responseObject);
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 TRC_LOG(@"%d, GET %@", operation.response.statusCode, operation.request.URL);
                 [[ToastService sharedService] toastErrorWithHTTPStatusCode:operation.response.statusCode];
                 onFailure(operation, error);
             }];
}

- (void)postJSONObject:(id)JSONObject
                toPath:(NSString *)aPath
               success:(void (^)(AFHTTPRequestOperation *, id))onSuccess
               failure:(void (^)(AFHTTPRequestOperation *, NSError *))onFailure
{
    [_client postPath:aPath
           parameters:JSONObject
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  TRC_LOG(@"%d, POST %@", operation.response.statusCode, operation.request.URL);
                  onSuccess(operation, responseObject);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  TRC_LOG(@"%d, POST %@", operation.response.statusCode, operation.request.URL);
                  onFailure(operation, error);
              }];
}

- (void)getFriendsSuccess:(void (^)(NSMutableArray *))onSuccess failure:(void (^)())onFailure
{
    [self getJSONAtPath:@"friends.json"
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSMutableArray *itemArray = [NSMutableArray array];
                    for (NSDictionary *itemDictionary in responseObject) {
                        Item *item = [[Item alloc] initWithJSONObject:itemDictionary];
                        [itemArray addObject:item];
                    }
                    
                    if (onSuccess) {
                        onSuccess(itemArray);
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    if (onFailure) {
                        onFailure();
                    }
                }];
}

- (void)getFriendWithId:(NSUInteger)anId
{
    [self getJSONAtPath:[NSString stringWithFormat:@"friends/%d.json", anId]
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    TRC_OBJ(responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    ;
                }];
}

- (void)createFriend:(Item *)item success:(void (^)(Item *item))onSuccess failure:(void (^)())onFailure
{    
    [self postJSONObject:[item JSONObject]
                  toPath:@"friends.json"
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     Item *item = [[Item alloc] initWithJSONObject:responseObject];
                     if (onSuccess) {
                         onSuccess(item);
                     }
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     if (onFailure) {
                         onFailure();
                     }
                 }];
}

- (void)updateFriend:(Item *)item withImage:(UIImage *)anImage success:(void (^)(Item *))onSuccess failure:(void (^)())onFailure
{
    NSMutableURLRequest *request = [_client multipartFormRequestWithMethod:@"PUT" path:@"friends/4" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDictionary *headers = @{
        @"Content-Disposition" : [NSString stringWithFormat:@"form-data; name=\"friend[image]\"; filename=\"filename.png\""]};
        [formData appendPartWithHeaders:headers body:UIImagePNGRepresentation(anImage)];
    }];
    
    AFHTTPRequestOperation *operation = [_client HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             TRC_LOG(@"%d, PUT %@", operation.response.statusCode, operation.request.URL);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             TRC_LOG(@"%d, PUT %@", operation.response.statusCode, operation.request.URL);
                                                                         }];
    
    [_client enqueueHTTPRequestOperation:operation];
}

- (void)put
{
    NSDictionary *parameters = @{
    @"friend[status]" : [NSString stringWithFormat:@"new status at %@", [NSDate date]],
    };
    
    [_client putPath:@"friends/4.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        TRC_LOG(@"%d, PUT %@", operation.response.statusCode, operation.request.URL);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TRC_LOG(@"%d, PUT %@", operation.response.statusCode, operation.request.URL);
    }];
}

@end
