//
//  Item.m
//  Table
//
//  Created by Jakub Hladík on 24.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "Item.h"

@implementation Item

- (id)initWithJSONObject:(NSDictionary *)JSONObject
{
    self = [super init];
    if (self) {
        TRC_OBJ(JSONObject);
        
        _name = [JSONObject[@"name"] stringValue];
        _status = [JSONObject[@"status"] stringValue];
    }
    
    return self;
}

- (NSDictionary *)JSONObject
{
    /*
     Do NSDictionaty @ { key : value} nesmi prijit nil, takze tam dame zastupny objekt [NSNull null]
     */
    
    return @{
    @"friend[name]" : _name? _name : [NSNull null],
    @"friend[status]" : _status? _status : [NSNull null],

    };
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Item: %@, %@", _name, _status];
}

@end
