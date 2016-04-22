//
//  SecondViewController.h
//  Roster
//
//  Created by slava litskevich on 7/2/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTContactsTableViewController : UITableViewController

- (void)presentSearchResults: (NSArray *)searchResults;
- (NSArray *)searchGroupsWith: (NSString *)searchText;

@end