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
        
        // only create a new entry in the dictionary if the item is new
        [dictionary setObject:[[NSMutableArray alloc] init] forKey:itemId];
    }
    
    // show the dictionary in the log
    CFShow(dictionary);
    
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

// in a string "Modifier 1:M1:1"
#define MOD_CATEGORY_INDEX 0 // Modifier 1
#define MOD_CHOICE_NAME_INDEX 1 // M1
#define MOD_BOOLEAN_INDEX 2 // 1

- (void)updateDictionaryWithModifierString:(NSMutableArray *)newChanges forKey:(NSNumber *)itemId
{
    NSMutableArray *modsInDict = [dictionary objectForKey:itemId];
    for (int changeIndex=0; changeIndex<[newChanges count]; changeIndex++) {
        if ([self newChangeInDictionary:modsInDict change:[newChanges objectAtIndex:changeIndex]]) {
            // in dictionary, if different, make changes and then update
            NSArray *modUpdate = [[newChanges objectAtIndex:changeIndex] componentsSeparatedByString:@":"];
            for (int modInDictIndex=0; modInDictIndex<[modsInDict count]; modInDictIndex++) {
                NSArray *modNames = [[modsInDict objectAtIndex:modInDictIndex] componentsSeparatedByString:@":"];
                if ([[modNames objectAtIndex:MOD_CHOICE_NAME_INDEX] isEqualToString:[modUpdate objectAtIndex:MOD_CHOICE_NAME_INDEX]]) {
                    
                    // update the array, then update the dictionary
                    NSMutableArray *updateMutableNames = [[NSMutableArray alloc] initWithArray:modNames];
                    [updateMutableNames replaceObjectAtIndex:MOD_BOOLEAN_INDEX withObject:[modUpdate objectAtIndex:MOD_BOOLEAN_INDEX]];
                    // create a string from updateMutableNames, UPDATE arrayInDict at index j, THEN replace the dict with arrayInDict
                    NSMutableString *stringOfupdateMutableNames = [[NSMutableString alloc] initWithFormat:@"%@:%@:%@", [updateMutableNames objectAtIndex:MOD_CATEGORY_INDEX], [updateMutableNames objectAtIndex:MOD_CHOICE_NAME_INDEX], [updateMutableNames objectAtIndex:MOD_BOOLEAN_INDEX]];
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
        if ([[splitModsInDict objectAtIndex:MOD_CHOICE_NAME_INDEX] isEqualToString:[splitNewChange objectAtIndex:MOD_CHOICE_NAME_INDEX]]) {
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
        if ([[modNames objectAtIndex:MOD_CHOICE_NAME_INDEX] isEqualToString:cellValue]) {
            if ([[modNames objectAtIndex:MOD_BOOLEAN_INDEX] isEqualToString:@"1"]) {
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
