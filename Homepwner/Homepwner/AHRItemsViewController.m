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
#import "AHRItemCell.h"
#import "AHRImageStore.h"
#import "AHRImageViewController.h"

@interface AHRItemsViewController () <UIPopoverControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) UIPopoverController *imagePopover;

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
    return [[[AHRItemStore sharedStore] allItems] count];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"AHRItemCell" bundle:nil];
    
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"AHRItemCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[AHRItemStore sharedStore] allItems];
    
    AHRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AHRItemCell" forIndexPath:indexPath];
    
    BNRItem *item = items[indexPath.row];

    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    
    cell.thumbnailView.image = item.thumbnail;

    __weak AHRItemCell *weakCell = cell;
    
    cell.actionBlock = ^{
        NSLog(@"Going to show image for %@", item);
        
        AHRItemCell *strongCell = weakCell;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            
            UIImage *img = [[AHRImageStore sharedStore] imageForKey:item.itemKey];
            if (!img) {
                return;
            }
            
            // Make a rectangle for the crame of the thumbnail relative to our table view
            CGRect rect = [self.view convertRect:strongCell.thumbnailView.bounds
                                        fromView:strongCell.thumbnailView];
            
            AHRImageViewController *ivc = [[AHRImageViewController alloc] init];
            ivc.image = img;
            
            self.imagePopover = [[UIPopoverController alloc] initWithContentViewController:ivc];
            self.imagePopover.delegate = self;
            self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
            [self.imagePopover presentPopoverFromRect:rect
                                               inView:self.view
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
        }
        
    };
    
    return cell;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.imagePopover = nil;
}

- (IBAction)addNewItem:(id)sender {
    BNRItem *newItem = [[AHRItemStore sharedStore] createItem];
    
    AHRDetailViewController *detailViewController = [[AHRDetailViewController alloc] initForNewItem:YES];
    
    detailViewController.item = newItem;
    
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
        NSLog(@"Reloaded tableView data");
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

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[AHRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
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
