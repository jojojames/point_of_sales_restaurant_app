//
//  QuickServeCollectionViewCell.m
//  Login
//
//  Created by Developer on 3/25/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "QuickServeCollectionViewCell.h"

@implementation QuickServeCollectionViewCell

@synthesize itemLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}
@end
