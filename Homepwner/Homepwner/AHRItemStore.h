//
//  AHRItemStore.h
//  Homepwner
//
//  Created by Adam Reis on 5/30/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface AHRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;

@end
