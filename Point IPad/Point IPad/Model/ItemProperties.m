//
//  ItemProperties.m
//  Login
//
//  Created by Developer on 3/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "ItemProperties.h"
#import "DatabaseAccess.h"

@implementation ItemProperties

@synthesize hotness;
@synthesize options;
@synthesize comments;
@synthesize toppingsLevel;
@synthesize toppingPrice;
@synthesize toppingThreshold;
@synthesize itemName;
@synthesize commentsLevel;
@synthesize hotnessLevel;
@synthesize priceStatus;
@synthesize optionsLevel;
@synthesize quantityLevel;
@synthesize extrasLevel;
@synthesize item_price;
@synthesize item_tax;
@synthesize vItemToppings;
@synthesize vItemExtras;
@synthesize hasSubItems;
@synthesize taxPercentage;
@synthesize cookitem;
@synthesize slot_time;
@synthesize course;

- (DatabaseAccess *)database
{
    if (!database) database = [[DatabaseAccess alloc] init];
    return database;
}

- (void)setItemId:(NSString *)itemId
{
    if (!_itemId) _itemId = itemId;
}

- (ItemProperties *)initWithItemId:(NSString *)__itemId
{
    [self setNullItems];
    [self setItemId:__itemId];
    [self getItemProperties];
    [self getExtras];
    [self getToppings];
    return self;
}

- (void)setNullItems
{
    hotness = NULL;
    options = NULL;
    comments = NULL;
    toppingsLevel = NULL;
    toppingPrice = NULL;
    toppingThreshold = 0;
    itemName = NULL;
    commentsLevel = NULL;
    hotnessLevel = NULL;
    priceStatus = NULL;
    optionsLevel = NULL;
    quantityLevel = NULL;
    extrasLevel = NULL;
    item_price = 0;
    item_tax = 0;
    vItemToppings = NULL;
    vItemExtras = NULL;
    hasSubItems = FALSE;
    taxPercentage = @"0.0";
    cookitem = TRUE;
    slot_time = NULL;
    course = NULL;
}

- (void)getItemProperties
{
    [[self database] itemProperties:self withItemId:[self itemId]];
}

- (void)getExtras
{
    [[self database] itemExtras:self withItemId:[self itemId]];
}

- (void)getToppings
{
    [[self database] itemToppings:self withItemId:[self itemId]];
}

- (void)getItemValues
{
    // grab the item price and item tax
    [[self database] itemValues:self withItemId:[self itemId]];
}
















@end
