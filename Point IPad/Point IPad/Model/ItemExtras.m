//
//  ItemExtras.m
//  Login
//
//  Created by Developer on 3/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "ItemExtras.h"

@implementation ItemExtras
@synthesize extrasId;
@synthesize extrasName;
@synthesize extrasPrice;

- (ItemExtras *)init
{
    extrasId = NULL;
    extrasName = NULL;
    extrasPrice = NULL;
    return self;
}

@end
