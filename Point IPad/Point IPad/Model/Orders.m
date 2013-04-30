//
//  Orders.m
//  Point IPad
//
//  Created by Developer on 4/29/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "Orders.h"

@implementation Orders
@synthesize totalPrice;
@synthesize currentOrder;

- (Orders *)init
{
    currentOrder = [[NSMutableArray alloc] init];
    return self;
}


- (void)addToOrder:(NSString *)itemName
{
    // use a database, get the price of the item and then add it to the total of the order
}

@end
