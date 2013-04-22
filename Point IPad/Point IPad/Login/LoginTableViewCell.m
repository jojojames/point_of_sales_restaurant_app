//
//  LoginTableViewCell.m
//  Point IPad
//
//  Created by Developer on 4/8/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "LoginTableViewCell.h"

@implementation LoginTableViewCell
@synthesize loginChoiceLabel;

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
    [loginChoiceLabel release];
    [super dealloc];
}
@end
