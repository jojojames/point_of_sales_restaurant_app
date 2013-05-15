//
//  QuickServeTableCell.m
//  Point IPad
//
//  Created by Developer on 5/15/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "QuickServeTableCell.h"

@implementation QuickServeTableCell
@synthesize itemNameLabel;
@synthesize priceLabel;
@synthesize qtyLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [itemNameLabel release];
    [priceLabel release];
    [qtyLabel release];
    [super dealloc];
}
@end
