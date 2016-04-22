//
//  RSTEntity.m
//  Roster
//
//  Created by slava litskevich on 7/6/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import "RSTEntity.h"

@implementation RSTEntity

- (instancetype)initWithAttributes: (NSDictionary *)attributes {
    static NSString *unknownKeyExceptionName = @"NSUnknownKeyException";
    self = [super init];
    if (self) {
        NSString *attributeName;
        NSEnumerator *namesEnumerator = attributes.keyEnumerator;
        while (attributeName = [namesEnumerator nextObject]) {
            @try {
                [self setValue: [attributes objectForKey: attributeName] forKey: attributeName];
            }
            @catch (NSException *exception) {
                if (![exception.name isEqualToString: unknownKeyExceptionName]) {
                    @throw exception;
                }
            }
        }
    }
    return self;
}

@end