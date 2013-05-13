//
//  QuickModifierCell.m
//  Point IPad
//
//  Created by Developer on 5/13/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "QuickModifierCell.h"

@implementation QuickModifierCell
//@synthesize quickModifierLabel;

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
    //[quickModifierLabel release];
    [super dealloc];
}
@end
