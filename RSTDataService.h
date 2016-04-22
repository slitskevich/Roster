//
//  RSTDataService.h
//  Roster
//
//  Created by slava litskevich on 7/2/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSTDataService : NSObject

- (NSArray *)loadGroupsError: (NSError **)loadingError;

@end
