//
//  SecondViewController.m
//  Roster
//
//  Created by slava litskevich on 7/2/15.
//  Copyright (c) 2015 litskevich. All rights reserved.
//

#import "RSTContactsTableViewController.h"
#import "RSTServiceLocator.h"
#import "RSTDataService.h"
#import "RSTGroup.h"
#import "RSTContact.h"

@interface RSTContactsTableViewController () <UISearchResultsUpdating>

@property (nonatomic) NSArray *groups;

@property (nonatomic) RSTContactsTableViewController *resultsViewController;
@property (nonatomic) UISearchController *searchController;

@property BOOL isSearchResultsPresenter;

@end

@implementation RSTContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    static NSString *errorTitleKey = @"error.title";
    static NSString *errorMessageKey = @"error.data_load_failed";
    static NSString *errorCancelKey = @"error.cancel";
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    if (!self.isSearchResultsPresenter) {
        [self prepareSearch];
    }
    
    NSError *error = nil;
    self.groups = [[RSTServiceLocator sharedInstance].dataService loadGroupsError: &error];
    if (error) {
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle: NSLocalizedString(errorTitleKey, nil)
                                                                            message: NSLocalizedString(errorMessageKey, nil)
                                                                     preferredStyle: UIAlertControllerStyleAlert];
        [errorAlert addAction: [UIAlertAction actionWithTitle: NSLocalizedString(errorCancelKey, nil)
                                                        style: UIAlertActionStyleCancel
                                                      handler: nil]];
        [self presentViewController: errorAlert animated: YES completion: nil];
    } else {
        [self.tableView reloadData];
    }
}

- (void)prepareSearch {
    static NSString *storyboardId = @"ContactsTableViewController";
    self.resultsViewController = [self.storyboard instantiateViewControllerWithIdentifier: storyboardId];
    self.resultsViewController.isSearchResultsPresenter = YES;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController: self.resultsViewController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups ? [self.groups count] : 0;
}

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    RSTGroup *sectionGroup = [self.groups objectAtIndex: section];
    return [sectionGroup.people count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((RSTGroup *)[self.groups objectAtIndex: section]).groupName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ContactCell";

    UITableViewCell *cell;
    if (tableView == self.tableView) {
        cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
        }
    } else {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
    }
    RSTGroup *group = [self.groups objectAtIndex: indexPath.section];
    RSTContact *contact = [group.people objectAtIndex: indexPath.row];
    cell.textLabel.text = contact.fullName;
    cell.detailTextLabel.text = contact.statusMessage;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    [cell.imageView setImage: [self imageForContactStatus: contact.status]];
    
    UIImageView *avatar = [[UIImageView alloc] initWithImage: [self avatarForContact: contact]];
    [cell setAccessoryView: avatar];
    
    return cell;
}

- (UIImage *)imageForContactStatus: (RSTPersonStatus)status {
    static NSString *iconAssetNameTemplate = @"contacts_list_status_%@";
    static NSString *onlineIconName = @"online";
    static NSString *offlineIconName = @"offline";
    static NSString *busyIconName = @"busy";
    static NSString *awayIconName = @"away";
    static NSString *pendingIconName = @"pending";
    static NSString *callForwardIconName = @"call_forward";
    NSString *iconName;
    switch (status) {
        case RSTPersonStatusOnline:
            iconName = onlineIconName;
            break;
        case RSTPersonStatusAway:
            iconName = awayIconName;
            break;
        case RSTPersonStatusBusy:
            iconName = busyIconName;
            break;
        case RSTPersonStatusCallForwarding:
            iconName = callForwardIconName;
            break;
        case RSTPersonStatusPending:
            iconName = pendingIconName;
            break;
        case RSTPersonStatusOffline:
        default:
            iconName = offlineIconName;
            break;
    }
    return [UIImage imageNamed: [NSString stringWithFormat: iconAssetNameTemplate, iconName]];
}

- (UIImage *)avatarForContact: (RSTContact *)contact {
    static NSString *avatarAssetNameTemplate = @"contacts_list_avatar_%@";
    static NSString *avatarMaleName = @"male";
    static NSString *avatarFemaleName = @"female";
    static NSString *avatarUnknownName = @"unknown";
    NSString *avatarName;
    switch (contact.avatar) {
        case RSTPersonAvatarMale:
            avatarName = avatarMaleName;
            break;
        case RSTPersonAvatarFemale:
            avatarName = avatarFemaleName;
            break;
        default:
            avatarName = avatarUnknownName;
            break;
    }
    return [UIImage imageNamed: [NSString stringWithFormat: avatarAssetNameTemplate, avatarName]];
}

#pragma mark search updater

- (void)presentSearchResults: (NSArray *)searchResults {
    self.groups = searchResults;
    [self.tableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.resultsViewController presentSearchResults: [self searchGroupsWith: searchController.searchBar.text]];
}

- (NSArray *)searchGroupsWith: (NSString *)searchText {
    NSMutableArray *searchResults = [NSMutableArray arrayWithCapacity: [self.groups count]];
    NSPredicate *contactMatch = [NSPredicate predicateWithBlock: ^BOOL(RSTContact *contact, NSDictionary *bindings) {
        return [[contact.fullName lowercaseString] rangeOfString: [searchText lowercaseString]].location != NSNotFound;
    }];
    for (RSTGroup *group in self.groups) {
        NSArray *foundContacts = [group.people filteredArrayUsingPredicate: contactMatch];
        if ([foundContacts count] > 0) {
            [searchResults addObject: [[RSTGroup alloc] initWithName: group.groupName andPeople: foundContacts]];
        }
    }
    return searchResults;
}

@end