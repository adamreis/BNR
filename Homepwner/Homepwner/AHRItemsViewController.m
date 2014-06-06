//
//  AHRItemsViewController.m
//  Homepwner
//
//  Created by Adam Reis on 5/30/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import "AHRItemsViewController.h"
#import "AHRItemStore.h"
#import "BNRItem.h"
#import "AHRDetailViewController.h"

@interface AHRItemsViewController ()

@property (strong, nonatomic) IBOutlet UIView *headerView;

@end

@implementation AHRItemsViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(addNewItem:)];
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.navigationItem.rightBarButtonItem = addButton;
        self.navigationItem.title = @"Homepwner";
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[AHRItemStore sharedStore] allItems] count] + 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[AHRItemStore sharedStore] allItems];
    
    if (indexPath.row == [items count]) {
        cell.textLabel.text = @"-------------";
        return cell;
    }
    
    BNRItem *item = items[indexPath.row];

    cell.textLabel.text = [item description];

    return cell;
}


- (IBAction)addNewItem:(id)sender {
    BNRItem *newItem = [[AHRItemStore sharedStore] createItem];
    
    AHRDetailViewController *detailViewController = [[AHRDetailViewController alloc] initForNewItem:YES];
    
    detailViewController.item = newItem;
    
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navController animated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[AHRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[AHRItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSInteger numItems = [[[AHRItemStore sharedStore] allItems] count];
    
    if (proposedDestinationIndexPath.row == numItems) {
        return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row - 1 inSection:sourceIndexPath.section];
    }
    
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[AHRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numItems = [[[AHRItemStore sharedStore] allItems] count];
    
    if (indexPath.row == numItems) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[AHRItemStore sharedStore] allItems];
    
    if (indexPath.row == [items count]) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    AHRDetailViewController *detailVC = [[AHRDetailViewController alloc] initForNewItem:NO];
    
    BNRItem *selectedItem = items[indexPath.row];
    
    detailVC.item = selectedItem;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
