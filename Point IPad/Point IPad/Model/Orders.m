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
@synthesize currentNames;
@synthesize currentPrices;
@synthesize currentQtys;
@synthesize database;

- (Orders *)init
{
    currentNames = [[NSMutableArray alloc] init];
    currentPrices = [[NSMutableArray alloc] init];
    currentQtys = [[NSMutableArray alloc] init];
    database = [[DatabaseAccess alloc] init];
    return self;
}


- (void)addToOrder:(NSNumber *)itemId
{
    // use a database, get the price of the item and then add it to the total of the order
    // add somethign to the currentOrder array
    
    //NSLog(@"%@ : %@", self.selectedItemId, [[self database] getLunchPriceUsing:self.selectedItemId]);
    
    NSString *itemName = [[self database] getItemNameUsing:itemId];
    NSNumber *itemPrice = [[self database] getLunchPriceUsing:itemId];
    NSNumber *itemQty = [NSNumber numberWithInt:1]; // every item starts at 1 quantity
    [currentNames addObject:itemName];
    [currentPrices addObject:itemPrice];
    [currentQtys addObject:itemQty];
    
}

@end
