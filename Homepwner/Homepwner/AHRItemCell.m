//
//  AHRItemCell.m
//  Homepwner
//
//  Created by Adam Reis on 6/3/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import "AHRItemCell.h"

@implementation AHRItemCell

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
