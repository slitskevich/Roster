//
//  RSTServiceLocator.m
//  Roster
//
//  Created by slava litskevich on 7/3/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import "RSTServiceLocator.h"
#import "RSTDataService.h"

@interface RSTServiceLocator()

@property (nonatomic) RSTDataService *dataService;

@end

@implementation RSTServiceLocator


+ (RSTServiceLocator*)sharedInstance {
    static dispatch_once_t once;
    static RSTServiceLocator *sharedInstance = nil;
    
    dispatch_once(&once, ^{
        sharedInstance = [[RSTServiceLocator alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataService = [[RSTDataService alloc] init];
    }
    return self;
}

@end
