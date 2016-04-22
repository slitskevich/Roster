//
//  RSTContact.h
//  Roster
//
//  Created by slava litskevich on 7/3/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSTEntity.h"

typedef enum {
    RSTPersonStatusOffline,
    RSTPersonStatusOnline,
    RSTPersonStatusAway,
    RSTPersonStatusBusy,
    RSTPersonStatusCallForwarding,
    RSTPersonStatusPending
} RSTPersonStatus;

typedef enum {
    RSTPersonAvatarUnknown,
    RSTPersonAvatarMale,
    RSTPersonAvatarFemale
} RSTPersonAvatar;

@interface RSTContact : RSTEntity

- (instancetype)initWithAttributes: (NSDictionary *)attributes;

@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;
@property (nonatomic, readonly) NSString *statusMessage;
@property (readonly) RSTPersonStatus status;
@property (readonly) RSTPersonAvatar avatar;

- (NSString *)fullName;

@end
