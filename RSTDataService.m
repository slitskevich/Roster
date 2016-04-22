//
//  RSTDataService.m
//  Roster
//
//  Created by slava litskevich on 7/2/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import "RSTDataService.h"
#import "RSTGroup.h"

@interface RSTDataService()

@end

@implementation RSTDataService

- (NSArray *)loadGroupsError: (NSError **)loadingError {
    static NSString *groupsKey = @"groups";
    static NSString *dataFileName = @"contacts";
    static NSString *dataFileExtension = @"json";
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData: [NSData dataWithContentsOfURL: [[NSBundle mainBundle] URLForResource: dataFileName withExtension: dataFileExtension]] options: 0 error: loadingError];
    if (*loadingError == nil) {
        NSArray *groups = [data objectForKey: groupsKey];
        NSMutableArray *result = [NSMutableArray arrayWithCapacity: [groups count]];
        for (NSDictionary *group in groups) {
            [result addObject: [[RSTGroup alloc] initWithAttributes: group]];
        }
        return result;
    }
    return nil;
}

@end
