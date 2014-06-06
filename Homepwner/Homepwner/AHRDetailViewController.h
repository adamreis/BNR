//
//  AHRDetailViewController.h
//  Homepwner
//
//  Created by Adam Reis on 5/30/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface AHRDetailViewController : UIViewController

- (instancetype)initForNewItem:(BOOL)isNew;

@property (strong, nonatomic) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

@end
