//
//  AHRItemCell.h
//  Homepwner
//
//  Created by Adam Reis on 6/3/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHRItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
