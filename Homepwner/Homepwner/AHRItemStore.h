//
//  AHRItemStore.h
//  Homepwner
//
//  Created by Adam Reis on 5/30/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AHRItem;

@interface AHRItemStore : NSObject
+ (instancetype)sharedStore;

@property (nonatomic, readonly) NSArray *allItems;

- (AHRItem *)createItem;
- (void)removeItem:(AHRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;
- (NSArray *)allAssetTypes;
- (void)addAssetType:(NSString *)newType;

@end
