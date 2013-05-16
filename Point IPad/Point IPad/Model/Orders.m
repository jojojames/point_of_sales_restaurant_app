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
@synthesize totalAmount;

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
    
    [self updateTotals]; // update the totals internally
    
}

#define TAX .09 // tax percentage

- (void)updateTotals
{
    totalAmount = 0;
    for (int i=0; i<[currentPrices count]; i++) {
        for (int j=0; j<[[currentQtys objectAtIndex:i] intValue]; j++) {
            totalAmount = [NSNumber numberWithInt:[[currentPrices objectAtIndex:i] integerValue] + [totalAmount integerValue]];
        }
    }
    
    int intTotalAmount = [totalAmount intValue];
    double finalPrice = intTotalAmount + (intTotalAmount * TAX);
    totalPrice = [NSNumber numberWithDouble:finalPrice];
}

@end
