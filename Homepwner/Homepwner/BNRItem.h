//
//  BNRItem.h
//  RandomItems
//
//  Created by John Gallagher on 1/12/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject <NSCoding>

@property (nonatomic) NSString *itemName;
@property (nonatomic) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;
@property (nonatomic, strong) UIImage *thumbnail;

- (void)setThumbnailFromImage:(UIImage *)image;


//+ (instancetype)randomItem;

// Designated initializer for BNRItem
//- (instancetype)initWithItemName:(NSString *)name
//                  valueInDollars:(int)value
//                    serialNumber:(NSString *)sNumber;
//
//- (instancetype)initWithItemName:(NSString *)name;

@end
