//
//  QuickServeCell.m
//  Point IPad
//
//  Created by Developer on 4/22/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "QuickServeCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation QuickServeCell
@synthesize itemLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.itemLabel.numberOfLines = 0;
    }
    return self;
}

- (void)changeBorders:(CGRect)frame
{
    self.restorationIdentifier = @"quickServe";
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    CGFloat borderWidth = 3.0f;
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.layer.borderColor = [UIColor redColor].CGColor;
    bgView.layer.borderWidth = borderWidth;
    self.selectedBackgroundView = bgView;
    
    CGRect myContentRect = CGRectInset(self.contentView.bounds, borderWidth, borderWidth);
    
    UIView *myContentView = [[UIView alloc] initWithFrame:myContentRect];
    myContentView.backgroundColor = [UIColor whiteColor];
    myContentView.layer.borderColor = [UIColor colorWithWhite:0.5f alpha:1.0f].CGColor;
    myContentView.layer.borderWidth = borderWidth;
    [self.contentView addSubview:myContentView];
    [self.contentView bringSubviewToFront:itemLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
