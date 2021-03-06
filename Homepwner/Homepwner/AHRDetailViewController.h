//
//  AHRDetailViewController.h
//  Homepwner
//
//  Created by Adam Reis on 5/30/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHRItem;

@interface AHRDetailViewController : UIViewController <UIViewControllerRestoration>

- (instancetype)initForNewItem:(BOOL)isNew;

@property (strong, nonatomic) AHRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

@end
