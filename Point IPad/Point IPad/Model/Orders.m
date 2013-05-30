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
@synthesize nameOfFirstTax;
@synthesize nameOfSecondTax;

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
    
    // change the tax names
    [self getTaxNames:itemId];
    
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
        
        // only create a new entry in the dictionary if the item is new
        [dictionary setObject:[[NSMutableArray alloc] init] forKey:itemId];
    }
    
    
    //[currentItemIds addObject:itemId];
    //[currentQtys addObject:itemQty];
    //[dictionary setObject:[[NSMutableArray alloc] init] forKey:itemId];
    
    // show the dictionary in the log
    //CFShow(dictionary);
    
    [self updateTotals]; // update the totals internally
}

- (void)getTaxNames:(NSNumber *)itemId
{
    if(!nameOfFirstTax || !nameOfSecondTax) {
        nameOfFirstTax = [database getTaxName:@"1"];
        nameOfSecondTax = [database getTaxName:@"2"];
    }
}

#define TAX .09 // tax percentage

- (void)updateTotals
{
    // get the price of the item using the item id, adding it to the total amount, then calculate the total price by calculating tax
    // TODO: create a function to get the tax of that particular item
    // TODO: create a function to check if there's a global tax to apply
    totalAmount = 0;
    NSNumber *tempItemPrice;
    NSNumber *modsPrice; // additional price of every modifier attached to an item
    
    
    NSNumber *firstTax = [NSNumber numberWithInt:0];
    NSNumber *secondTax = [NSNumber numberWithInt:0];
    
    for (int curItem=0; curItem<[currentItemIds count]; curItem++) {
        NSNumber *itemId = [[self currentItemIds] objectAtIndex:curItem];
        for (int curQty=0; curQty<[[currentQtys objectAtIndex:curItem] intValue]; curQty++) {
            tempItemPrice = [[self database] getLunchPriceUsing:itemId];
            modsPrice = [self priceOfEveryModUsing:itemId];
            self.taxOnePercentage = [NSNumber numberWithDouble:[[database getTax:itemId WithTax:@"1"] doubleValue] / 100];
            self.taxTwoPercentage = [NSNumber numberWithDouble:[[database getTax:itemId WithTax:@"2"] doubleValue] / 100];
            
            firstTax = [NSNumber numberWithDouble:[firstTax doubleValue] +
                        ([tempItemPrice doubleValue] *
                         [self.taxOnePercentage doubleValue])];
                         
            secondTax = [NSNumber numberWithDouble:[secondTax doubleValue] +
                         ([tempItemPrice doubleValue] *
                          [self.taxTwoPercentage doubleValue])];
            
            totalAmount = [NSNumber numberWithInt:[tempItemPrice intValue] +
                           [totalAmount intValue] + [modsPrice intValue]];
        }
    }
    
    int intTotalAmount = [totalAmount intValue];
    //double finalPrice = intTotalAmount + (intTotalAmount * TAX);
    double finalPrice = intTotalAmount + [firstTax doubleValue] + [secondTax doubleValue];
    totalPrice = [NSNumber numberWithDouble:finalPrice];
}

// in a string "Modifier 1:M1:1"
#define CATEGORY_INDEX 0 // Modifier 1
#define CHOICE_INDEX 1 // M1
#define BOOLEAN_INDEX 2 // 1

- (NSNumber *)priceOfEveryModUsing:(NSNumber *)itemId
{
    // mod1/hotness, mod2/quantity, mod3/extras, mod4/options
    // Only mod2 and mod3 have extra prices associated with them.
    
    NSNumber *totalModPrice = [NSNumber numberWithInt:0];
    NSMutableArray *modsInDict = [dictionary objectForKey:itemId];
    for (int i=0; i<[modsInDict count]; i++) {
        NSArray *modString = [[modsInDict objectAtIndex:i] componentsSeparatedByString:@":"];
        if ([[modString objectAtIndex:BOOLEAN_INDEX] isEqualToString:@"1"]) {
            if ([[modString objectAtIndex:CATEGORY_INDEX] isEqualToString:@"Modifier 2"]) {
                int modPriceFromDB = [[database getModPriceQuantity:itemId withModName:[modString objectAtIndex:CHOICE_INDEX]] intValue];
                totalModPrice = [NSNumber numberWithInt:modPriceFromDB + [totalModPrice intValue]];
            } else if ([[modString objectAtIndex:CATEGORY_INDEX] isEqualToString:@"Modifier 3"]) {
                int modPriceFromDB = [[database getModPriceExtra:itemId withModName:[modString objectAtIndex:CHOICE_INDEX]] intValue];
                totalModPrice = [NSNumber numberWithInt:modPriceFromDB + [totalModPrice intValue]];
            }
        }
    }
    //NSLog(@"TOTALMODPRICE: %@", totalModPrice);
    
    return totalModPrice;
}

- (void)updateDictionaryWithModifierString:(NSMutableArray *)newChanges forKey:(NSNumber *)itemId
{
    NSMutableArray *modsInDict = [dictionary objectForKey:itemId];
    for (int changeIndex=0; changeIndex<[newChanges count]; changeIndex++) {
        if ([self newChangeInDictionary:modsInDict change:[newChanges objectAtIndex:changeIndex]]) {
            // in dictionary, if different, make changes and then update
            NSArray *modUpdate = [[newChanges objectAtIndex:changeIndex] componentsSeparatedByString:@":"];
            for (int modInDictIndex=0; modInDictIndex<[modsInDict count]; modInDictIndex++) {
                NSArray *modNames = [[modsInDict objectAtIndex:modInDictIndex] componentsSeparatedByString:@":"];
                if ([[modNames objectAtIndex:CHOICE_INDEX] isEqualToString:[modUpdate objectAtIndex:CHOICE_INDEX]]) {
                    
                    // update the array, then update the dictionary
                    NSMutableArray *updateMutableNames = [[NSMutableArray alloc] initWithArray:modNames];
                    [updateMutableNames replaceObjectAtIndex:BOOLEAN_INDEX withObject:[modUpdate objectAtIndex:BOOLEAN_INDEX]];
                    
                    // create a new string in format of "Modifier 1:M1:1" and replace a similar string in format of "Modifier 1:M1:0"
                    NSMutableString *stringOfupdateMutableNames = [[NSMutableString alloc] initWithFormat:@"%@:%@:%@", [updateMutableNames objectAtIndex:CATEGORY_INDEX], [updateMutableNames objectAtIndex:CHOICE_INDEX], [updateMutableNames objectAtIndex:BOOLEAN_INDEX]];
                    [modsInDict replaceObjectAtIndex:modInDictIndex withObject:stringOfupdateMutableNames];
                    [dictionary setObject:modsInDict forKey:itemId];
                }
            }
        } else {
            // not in dictionary, update the dictionary
            [modsInDict addObject:[newChanges objectAtIndex:changeIndex]];
            [dictionary setObject:modsInDict forKey:itemId];
        }
    }
}

- (BOOL)newChangeInDictionary:(NSMutableArray *)modsInDict change:(NSString *)newChange
{
    // if modsInDict contains a string like "Modifier 1:M1:1", it will match "Modifier 1:M1:1" and "Modifier 1:M1:0"
    NSArray *splitNewChange = [newChange componentsSeparatedByString:@":"];
    for (int modStringIndex=0; modStringIndex<[modsInDict count]; modStringIndex++) {
        NSArray *splitModsInDict = [[modsInDict objectAtIndex:modStringIndex] componentsSeparatedByString:@":"];
        if ([[splitModsInDict objectAtIndex:CHOICE_INDEX] isEqualToString:[splitNewChange objectAtIndex:CHOICE_INDEX]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)nameInKey:(NSString *)cellValue ofKey:(NSNumber *)itemId
{
    NSMutableArray *arrayOfModStrings = [dictionary objectForKey:itemId];
    
    for (int i=0; i<[arrayOfModStrings count]; i++) {
        // check if the cellValue is a substring of any modifier string
        NSArray *modNames = [[arrayOfModStrings objectAtIndex:i] componentsSeparatedByString:@":"];
        if ([[modNames objectAtIndex:CHOICE_INDEX] isEqualToString:cellValue]) {
            if ([[modNames objectAtIndex:BOOLEAN_INDEX] isEqualToString:@"1"]) {
                // user had picked the modifier to be on
                return YES;
            } else {
                // user had picked the modifier to be off
                return NO;
            }
        }
    }
    // The substring wasn't found so the user had not touched this particular modifier yet, so return the default NO.
    return NO;
    
}

@end
