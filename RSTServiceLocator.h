//
//  RSTServiceLocator.h
//  Roster
//
//  Created by slava litskevich on 7/3/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSTDataService;

@interface RSTServiceLocator : NSObject

@property (readonly) RSTDataService *dataService;

+ (RSTServiceLocator *)sharedInstance;

@end
