//
//  RSTGroup.m
//  Roster
//
//  Created by slava litskevich on 7/3/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import "RSTGroup.h"
#import "RSTContact.h"

@interface RSTGroup()

@property (nonatomic) NSString *groupName;
@property (nonatomic) NSArray *people;

@end

@implementation RSTGroup

- (instancetype)initWithAttributes: (NSDictionary *)attributes {
    self = [super initWithAttributes: attributes];
    if (self) {
        NSMutableArray *peopleObjects = [NSMutableArray arrayWithCapacity: [self.people count]];
        for (NSDictionary *personAttributes in self.people) {
            [peopleObjects addObject: [[RSTContact alloc] initWithAttributes: personAttributes]];
        }
        self.people = peopleObjects;
    }
    return self;
}

- (instancetype)initWithName: (NSString *)name andPeople: (NSArray *)people {
    self = [super init];
    if (self) {
        self.groupName = name;
        self.people = people;
    }
    return self;
}

@end
