//
//  RSTGroup.h
//  Roster
//
//  Created by slava litskevich on 7/3/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSTEntity.h"

@interface RSTGroup : RSTEntity

@property (nonatomic, readonly) NSString *groupName;
@property (nonatomic, readonly) NSArray *people;

- (instancetype)initWithName: (NSString *)name andPeople: (NSArray *)people;
- (instancetype)initWithAttributes: (NSDictionary *)attributes;

@end
