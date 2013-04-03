//
//  ListItemProperties.m
//  Login
//
//  Created by Developer on 4/1/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "ListItemProperties.h"

@implementation ListItemProperties
@synthesize debug;
@synthesize itemId;
@synthesize itemName;
@synthesize itemPosition;
@synthesize quantity;
@synthesize itemPrice;
@synthesize itemTax;
@synthesize hotness;
@synthesize options;
@synthesize size;
@synthesize comments;
@synthesize cookNotes;
@synthesize dineCookComments;
@synthesize toppingsStatus;
@synthesize toppingPrice;
@synthesize toppingThreshold;
@synthesize itemProperties;
@synthesize vOrderToppings;

@synthesize toppings;
@synthesize vOrderExtras;
@synthesize deliveryType;
@synthesize sizePrice;
@synthesize originalItemPrice;
@synthesize actualItemPrice;
@synthesize position;
@synthesize itemFinish;
@synthesize detailsId;

// For Reorder
@synthesize orderDetailId;
@synthesize isReorder;
@synthesize extraToppingPrice;
@synthesize extrasPrice;
@synthesize couponId;
@synthesize couponBy;
@synthesize extras;
@synthesize hasSubItems;
@synthesize isSubItem;
@synthesize taxPercentage;
@synthesize deliveryCharge;
@synthesize parentItemId;
@synthesize parentItemProperties;
@synthesize priceModified;
@synthesize dividedItems;
@synthesize isParentDividedItem;
@synthesize parentDividedItemProperties;
@synthesize parentOrderDetailId;
@synthesize holdStatus;
@synthesize tempOrderStatus;
@synthesize tokenNum;
@synthesize isItemDivided;
@synthesize dividedValue;
@synthesize itemPriceModifier;
@synthesize orderId;
@synthesize CookItem;
@synthesize updateQuantityStatus;
@synthesize origToppingPrice;
@synthesize origSizePrice;
@synthesize origExtrasPrice;
@synthesize splInst;
@synthesize removeToppings;
@synthesize rightToppings;
@synthesize leftToppings;
@synthesize olTax;
@synthesize olTax1;
@synthesize olTax2;
@synthesize olTax3;
@synthesize olDeliveryCharge;
@synthesize priceExcDis;
@synthesize taxExempt;
@synthesize totalValue;
@synthesize totalDividedValue;
@synthesize totalOriginalDividedValue;
@synthesize courseLine;
@synthesize clubPrice;
@synthesize slot_time;
//@synthesize startTime;
//@synthesize endTime;
@synthesize hall;
@synthesize ounces;
@synthesize priceUnit;
@synthesize boxValue;
@synthesize boxType;
@synthesize seatString;

- (ListItemProperties *)init
{
    [self setNullValues];
    return self;
}

- (ListItemProperties *)initWithId:(NSString *)__itemId
{
    [self setNullValues];
    [self setItemProperties:[[ItemProperties alloc] initWithItemId:__itemId]];
    [self setCookItem:[[self itemProperties] cookitem]]; // true or false
    return self;
}

- (ListItemProperties *)initWithItemId:(NSString *)__itemId name:(NSString *)__itemName position:(NSNumber *)__itemPosition quantity:(NSString *)__quantity price:(NSString *)__itemPrice tax:(NSString *)__itemTax
{
    [self setNullValues];
    itemId = __itemId;
    itemName = __itemName;
    itemPosition = __itemPosition;
    quantity = __quantity;
    itemPrice = __itemPrice;
    originalItemPrice = __itemPrice;
    itemTax = __itemTax;
    actualItemPrice = itemPrice;
    ItemProperties *IP = [[ItemProperties alloc] initWithItemId:[self itemId]];
    CookItem = [IP cookitem];
    return self;
}

- (void)setNullValues
{
    [self setDebug:false];
    [self setItemId:NULL];
    [self setItemName:NULL];
    //private int itemPosition ;
    [self setQuantity:NULL];
    [self setItemPrice:NULL];
    [self setItemTax:@"0.0"];
    [self setHotness:NULL];
    [self setOptions:NULL];
    [self setSize:NULL];
    [self setComments:NULL];
    [self setCookNotes:NULL];
    [self setDineCookComments:NULL];
    [self setToppingsStatus:FALSE];
    [self setToppingPrice:NULL];
    [self setToppingThreshold:0];
    [self setItemProperties:NULL];
    self.vOrderToppings = [[NSMutableArray alloc] init];
    [self setToppings:NULL];
    self.vOrderExtras = [[NSMutableArray alloc] init];
    [self setDeliveryType:NULL];
    [self setSizePrice:@"0.00"];
    [self setOriginalItemPrice:NULL];
    [self setActualItemPrice:NULL];
    [self setPosition:0];
    [self setItemFinish:FALSE];
    
    // For Reordering
    [self setDetailsId:NULL];
    [self setOrderDetailId:NULL];
    [self setIsReorder:FALSE];
    [self setExtraToppingPrice:@"0.0"];
    [self setExtrasPrice:@"0.0"];
    [self setCouponId:NULL];
    [self setCouponBy:NULL];
    [self setExtras:NULL];
    [self setHasSubItems:FALSE];
    [self setIsSubItem:FALSE];
    [self setTaxPercentage:@"0"];
    [self setDeliveryCharge:@"0.0"];
    [self setParentItemId:NULL];
    [self setParentItemProperties:NULL];
    [self setPriceModified:FALSE];
    self.dividedItems = [[NSMutableArray alloc] init];
    [self setIsParentDividedItem:FALSE];
    [self setParentDividedItemProperties:NULL];
    [self setParentOrderDetailId:NULL];
    [self setHoldStatus:FALSE];
    [self setTempOrderStatus:FALSE];
    [self setTokenNum:NULL];
    [self setIsItemDivided:FALSE];
    [self setDividedValue:NULL];
    [self setItemPriceModifier:NULL];
    [self setOrderId:NULL];
    [self setCookItem:TRUE];
    [self setUpdateQuantityStatus:FALSE];
    [self setOrigToppingPrice:@"0.00"];
    [self setOrigSizePrice:@"0.00"];
    [self setOrigExtrasPrice:@"0.00"];
    [self setSplInst:NULL];
    [self setRemoveToppings:NULL];
    [self setRightToppings:NULL];
    [self setLeftToppings:NULL];
    [self setOlTax:@"0.00"];
    [self setOlTax1:@"0.00"];
    [self setOlTax2:@"0.00"];
    [self setOlTax3:@"0.00"];
    [self setOlDeliveryCharge:NULL];
    self.priceExcDis = [[NSNumber alloc] initWithDouble:-1.00];
    [self setTaxExempt:FALSE];
    [self setTotalValue:NULL];
    [self setTotalDividedValue:NULL];
    [self setTotalOriginalDividedValue:NULL];
    [self setCourseLine:NULL];
    [self setClubPrice:NULL];
    [self setSlot_time:NULL];
    // set start time
    // set end time
    [self setHall:NULL];
    [self setOunces:NULL];
    [self setPriceUnit:NULL];
    [self setBoxValue:NULL];
    [self setBoxType:NULL];
    [self setSeatString:@""];
}
@end
