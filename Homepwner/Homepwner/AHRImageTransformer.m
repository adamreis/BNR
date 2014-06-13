//
//  AHRImageTransformer.m
//  Homepwner
//
//  Created by Adam Reis on 6/4/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import "AHRImageTransformer.h"

@implementation AHRImageTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
