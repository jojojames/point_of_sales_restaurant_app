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
@synthesize currentQtys;
@synthesize database;
@synthesize totalAmount;
@synthesize currentItemIds;
@synthesize dictionary;

- (Orders *)init
{
    currentItemIds = [[NSMutableArray alloc] init];
    currentQtys = [[NSMutableArray alloc] init];
    database = [[DatabaseAccess alloc] init];
    dictionary = [[NSMutableDictionary alloc] init];
    return self;
}


- (void)addToOrder:(NSNumber *)itemId
{
    // use a database, get the price of the item and then add it to the total of the order
    // add somethign to the currentOrder array
    
    NSNumber *itemQty = [NSNumber numberWithInt:1]; // every item starts at 1 quantity
    
    // if the item was already selected, increment the quantity instead
    if([currentItemIds containsObject:itemId]) {
        for (int qtyIndex=0; qtyIndex<[currentItemIds count]; qtyIndex++) {
            if ([[currentItemIds objectAtIndex:qtyIndex] isEqual:itemId]) {
                int incrementQuantity = [[currentQtys objectAtIndex:qtyIndex] intValue] + 1;
                [currentQtys replaceObjectAtIndex:qtyIndex  withObject:[NSNumber numberWithInt:incrementQuantity]];
            }
        }
    } else {
        // else add a new item to the order
        [currentItemIds addObject:itemId];
        [currentQtys addObject:itemQty];
        
        // only create a new dictionary if the item is new
        [dictionary setObject:[[NSMutableArray alloc] init] forKey:itemId];
    }
    
    [self updateTotals]; // update the totals internally
}

#define TAX .09 // tax percentage

- (void)updateTotals
{
    // get the price of the item using the item id, adding it to the total amount, then calculate the total price by calculating tax
    // TODO: create a function to get the tax of that particular item
    // TODO: create a function to check if there's a global tax to apply
    totalAmount = 0;
    NSNumber *tempItemPrice;
    for (int i=0; i<[currentItemIds count]; i++) {
        for (int j=0; j<[[currentQtys objectAtIndex:i] intValue]; j++) {
            tempItemPrice = [[self database] getLunchPriceUsing:[[self currentItemIds] objectAtIndex:i]];
            totalAmount = [NSNumber numberWithInt:[tempItemPrice intValue] + [totalAmount intValue]];
        }
    }
    
    int intTotalAmount = [totalAmount intValue];
    double finalPrice = intTotalAmount + (intTotalAmount * TAX);
    totalPrice = [NSNumber numberWithDouble:finalPrice];
}

@end
