//
//  Orders.h
//  Point IPad
//
//  Created by Developer on 4/29/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseAccess.h"

@interface Orders : NSObject
@property (strong, nonatomic) DatabaseAccess *database; // database query
@property (nonatomic, strong) NSNumber *totalAmount; // the amount without tax
@property (nonatomic, strong) NSNumber *totalPrice; // the amount with tax

// possible to use only currentItemIds and currentQtys and have the names and price taken from an SQL query using itemid
@property (nonatomic, strong) NSMutableArray *currentItemIds; // containts the ids of the current order
@property (nonatomic, strong) NSMutableArray *currentQtys;   // containts the quantities of every order


@property (nonatomic, strong) NSMutableDictionary *dictionary; // keys are itemids, retrieves an array of mod strings, mod strings being in the format of "Modifier 1:M1:1"

- (void)updateTotals;
- (void)addToOrder:(NSNumber *)itemId;
- (BOOL)nameInKey:(NSString *)cellValue ofKey:(NSNumber *)itemId;
- (void)updateDictionaryWithModifierString:(NSMutableArray *)newChanges forKey:(NSNumber *)itemId;


@property (nonatomic, strong) NSNumber *taxOnePercentage;
@property (nonatomic, strong) NSNumber *taxTwoPercentage;
@property (nonatomic, strong) NSString *nameOfFirstTax;
@property (nonatomic, strong) NSString *nameOfSecondTax;
@end
