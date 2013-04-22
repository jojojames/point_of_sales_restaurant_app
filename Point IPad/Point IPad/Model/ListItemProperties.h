//
//  ListItemProperties.h
//  Login
//
//  Created by Developer on 4/1/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemProperties.h"

@interface ListItemProperties : NSObject

@property (nonatomic, assign, getter=debug) BOOL debug;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSNumber *itemPosition;
@property (nonatomic, strong) NSString *quantity;
@property (nonatomic, strong) NSString *itemPrice;
@property (nonatomic, strong) NSString *itemTax;
@property (nonatomic, strong) NSString *hotness;
@property (nonatomic, strong) NSString *options;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *comments;
@property (nonatomic, strong) NSString *cookNotes;
@property (nonatomic, strong) NSString *dineCookComments;
@property (nonatomic, assign, getter=toppingsStatus) BOOL toppingsStatus;
@property (nonatomic, strong) NSString *toppingPrice;
@property (nonatomic, strong) NSNumber *toppingThreshold;
@property (nonatomic, strong) ItemProperties *itemProperties;
@property (nonatomic, strong) NSMutableArray *vOrderToppings;
@property (nonatomic, strong) NSString *toppings;
@property (nonatomic, strong) NSMutableArray *vOrderExtras;
@property (nonatomic, strong) NSString *deliveryType;
@property (nonatomic, strong) NSString *sizePrice;
@property (nonatomic, strong) NSString *originalItemPrice;
@property (nonatomic, strong) NSString *actualItemPrice;
@property (nonatomic, strong) NSNumber *position;
@property (nonatomic, assign, getter=itemFinish) BOOL itemFinish;
@property (nonatomic, strong) NSString *detailsId;

 //For Reorder
@property (nonatomic, strong) NSString *orderDetailId;
@property (nonatomic, assign, getter=isReorder) BOOL isReorder;
@property (nonatomic, strong) NSString *extraToppingPrice;
@property (nonatomic, strong) NSString *extrasPrice;
@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *couponBy;

@property (nonatomic, strong) NSString *extras;
@property (nonatomic, assign, getter=hasSubItems) BOOL hasSubItems;
@property (nonatomic, assign, getter=isSubItem) BOOL isSubItem;
@property (nonatomic, strong) NSString *taxPercentage;
@property (nonatomic, strong) NSString *deliveryCharge;
@property (nonatomic, strong) NSString *parentItemId;
@property (nonatomic, strong) ListItemProperties *parentItemProperties;
@property (nonatomic, assign, getter=priceModified) BOOL priceModified;
@property (nonatomic, strong) NSMutableArray *dividedItems;
@property (nonatomic, assign, getter=isParentDividedItem) BOOL isParentDividedItem;
@property (nonatomic, strong) ListItemProperties *parentDividedItemProperties;
@property (nonatomic, strong) NSString *parentOrderDetailId;
@property (nonatomic, assign, getter=holdStatus) BOOL holdStatus;
@property (nonatomic, assign, getter=tempOrderStatus) BOOL tempOrderStatus;
@property (nonatomic, strong) NSString *tokenNum;
@property (nonatomic, assign, getter=isItemDivided) BOOL isItemDivided;
@property (nonatomic, strong) NSString *dividedValue;
@property (nonatomic, strong) NSString *itemPriceModifier;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, assign, getter=CookItem) BOOL CookItem;
@property (nonatomic, assign, getter=updateQuantityStatus) BOOL updateQuantityStatus;
@property (nonatomic, strong) NSString *origToppingPrice;
@property (nonatomic, strong) NSString *origSizePrice;
@property (nonatomic, strong) NSString *origExtrasPrice;
@property (nonatomic, strong) NSString *splInst;
@property (nonatomic, strong) NSString *removeToppings;
@property (nonatomic, strong) NSString *rightToppings;
@property (nonatomic, strong) NSString *leftToppings;
@property (nonatomic, strong) NSString *olTax;
@property (nonatomic, strong) NSString *olTax1;
@property (nonatomic, strong) NSString *olTax2;
@property (nonatomic, strong) NSString *olTax3;
@property (nonatomic, strong) NSString *olDeliveryCharge;
@property (nonatomic, strong) NSNumber *priceExcDis;
@property (nonatomic, assign, getter=taxExempt) BOOL taxExempt;
@property (nonatomic, strong) NSString *totalValue;
@property (nonatomic, strong) NSString *totalDividedValue;
@property (nonatomic, strong) NSString *totalOriginalDividedValue;
@property (nonatomic, strong) NSString *courseLine;
@property (nonatomic, strong) NSString *clubPrice;
@property (nonatomic, strong) NSString *slot_time;
// Figure out how to use Calendar or use the Time.h file instead
// private Calendar startTime = null;
// private Calendar endTime = null;
@property (nonatomic, strong) NSString *hall;
@property (nonatomic, strong) NSString *ounces;
@property (nonatomic, strong) NSString *priceUnit;
@property (nonatomic, strong) NSString *boxValue;
@property (nonatomic, strong) NSString *boxType;
@property (nonatomic, strong) NSString *seatString;

@end
