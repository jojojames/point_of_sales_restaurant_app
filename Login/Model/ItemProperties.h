//
//  ItemProperties.h
//  Login
//
//  Created by Developer on 3/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DatabaseAccess;

@interface ItemProperties : NSObject {
    DatabaseAccess *database; // the main database that the whole program draws from
}

// All the properties of an item
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *hotness;
@property (nonatomic, strong) NSString *options;
@property (nonatomic, strong) NSString *comments;
@property (nonatomic, strong) NSString *toppingsLevel;
@property (nonatomic, strong) NSString *toppingPrice;
@property (nonatomic, strong) NSNumber *toppingThreshold;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *commentsLevel;
@property (nonatomic, strong) NSString *hotnessLevel;
@property (nonatomic, strong) NSString *priceStatus;
@property (nonatomic, strong) NSString *optionsLevel;
@property (nonatomic, strong) NSString *quantityLevel;
@property (nonatomic, strong) NSString *extrasLevel;
@property (nonatomic, strong) NSNumber *item_price;
@property (nonatomic, strong) NSNumber *item_tax;
@property (nonatomic, strong) NSMutableArray *vItemToppings;
@property (nonatomic, strong) NSMutableArray *vItemExtras;
@property (nonatomic, assign, getter=hasSubItems) BOOL hasSubItems;
@property (nonatomic, strong) NSString *taxPercentage;
@property (nonatomic, assign, getter=cookitem) BOOL cookitem;
@property (nonatomic, strong) NSString *slot_time;
@property (nonatomic, strong) NSString *course;

- (ItemProperties *)initWithItemId:(NSString *)_itemId;

@end
