//
//  ItemToppings.h
//  Login
//
//  Created by Developer on 3/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemToppings : NSObject

#define FULL 0
#define HALF 1
#define THIRD 2
#define FOURTH 3

#define LEFT 1 << 0
#define RIGHT 1 << 1
#define TOP 1 << 2
#define BOTTOM 1 << 3

#define NORMAL 0
#define DOUBLE 1
#define TRIPLE 2

// Data Members and Properties
@property (nonatomic, strong) NSNumber *area;
@property (nonatomic, strong) NSNumber *location;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *toppingId;
@property (nonatomic, strong) NSString *toppingName;
@property (nonatomic, assign, getter=isDefault) BOOL isDefault;
@property (nonatomic, assign, getter=isSelected) BOOL isSelected;

// old
@property (nonatomic, assign, getter=isHalf) BOOL isHalf;
@property (nonatomic, assign, getter=isDouble) BOOL isDouble;
@property (nonatomic, assign, getter=firstHalf) BOOL firstHalf;
@property (nonatomic, assign, getter=secondHalf) BOOL secondHalf;
@property (nonatomic, assign, getter=firstDouble) BOOL firstDouble;
@property (nonatomic, assign, getter=secondDouble) BOOL secondDouble;
@property (nonatomic, strong) NSNumber *toppingValue;

@end
