//
//  Item.h
//  Table
//
//  Created by Jakub Hladík on 24.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;

- (id)initWithJSONObject:(NSDictionary *)JSONObject;

- (NSDictionary *)JSONObject;

@end
