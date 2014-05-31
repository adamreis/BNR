//
//  AHRItemStore.m
//  Homepwner
//
//  Created by Adam Reis on 5/30/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import "AHRItemStore.h"
#import "BNRItem.h"

@interface AHRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation AHRItemStore


+ (instancetype)sharedStore
{
    static AHRItemStore *sharedStore = nil;
    
    // Do I need to create one?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use + [AHRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];

    [self.privateItems addObject:item];
    
    return item;
}


@end
