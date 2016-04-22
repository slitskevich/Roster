//
//  RSTContact.m
//  Roster
//
//  Created by slava litskevich on 7/3/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import "RSTContact.h"

@interface RSTContact()

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *statusMessage;
@property RSTPersonStatus status;
@property RSTPersonAvatar avatar;

@end

@implementation RSTContact

static NSString *iconAttributeName = @"statusIcon";
static NSString *statusValueOnline = @"online";
static NSString *statusValueAway = @"away";
static NSString *statusValueBusy = @"busy";
static NSString *statusValueCallForwarding = @"callforwarding";
static NSString *statusValuePending = @"pending";

- (instancetype)initWithAttributes: (NSDictionary *)attributes {
    self = [super initWithAttributes: attributes];
    if (self) {
        NSString *icon = [attributes objectForKey: iconAttributeName];
        if ([icon isEqualToString: statusValueOnline]) {
            self.status = RSTPersonStatusOnline;
        } else if ([icon isEqualToString: statusValueAway]) {
            self.status = RSTPersonStatusAway;
        } else if ([icon isEqualToString: statusValueBusy]) {
            self.status = RSTPersonStatusBusy;
        } else if ([icon isEqualToString: statusValueCallForwarding]) {
            self.status = RSTPersonStatusCallForwarding;
        } else if ([icon isEqualToString: statusValuePending]) {
            self.status = RSTPersonStatusPending;
        } else {
            self.status = RSTPersonStatusOffline;
        }
        self.avatar = rand() % 3;
    }
    return self;
}

- (NSString *)fullName {
    static NSString *fullNameTemplate = @"%@ %@";
    return [NSString stringWithFormat: fullNameTemplate, self.firstName, self.lastName];
}

@end