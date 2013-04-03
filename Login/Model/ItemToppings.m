//
//  ItemToppings.m
//  Login
//
//  Created by Developer on 3/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "ItemToppings.h"

@implementation ItemToppings

@synthesize location;
@synthesize toppingId;
@synthesize toppingName;
@synthesize isDefault;
@synthesize isSelected;
@synthesize isHalf;
@synthesize isDouble;
@synthesize firstHalf;
@synthesize secondHalf;
@synthesize firstDouble;
@synthesize secondDouble;
@synthesize toppingValue;


- (ItemToppings *)init
{
    [self setArea:FULL];
    int __location__ = LEFT | RIGHT | TOP | BOTTOM;
    self.location = [[NSNumber alloc] initWithInt:__location__];
    [self setAmount:NORMAL];
    self.toppingId = NULL;
    self.toppingName = NULL;
    self.isDefault = FALSE;
    self.isDouble = FALSE;
    self.firstHalf = FALSE;
    self.secondHalf = FALSE;
    self.firstDouble = FALSE;
    self.secondDouble = FALSE;
    self.toppingValue = [[NSNumber alloc] initWithDouble:0.0];
    return self;
}


- (NSNumber *)getArea
{
    return _area;
}

- (void)setArea:(NSNumber *)area
{
    _area = area;
    [self setNextLocation];
}

- (NSNumber *)getAmount
{
    return _amount;
}

- (void)setAmount:(NSNumber *)amount
{
    // Check Input
    if([amount intValue] != NORMAL && [amount intValue]!= DOUBLE && [amount intValue] != TRIPLE) {
        
    } else {
        // Set amount.
        _amount = amount;
    }
}

- (void)setNextLocation
{
    int __full__ = LEFT | RIGHT | TOP | BOTTOM;
    int __area__ = [[self getArea] intValue];
    int __location__ = [[self location] intValue];
    if (__area__ == FULL) {
        self.location = [[NSNumber alloc] initWithInt:__full__];
    } else if (__area__ == HALF) {
        if ([self isSet:__location__ withValue:LEFT]) {
            self.location = [[NSNumber alloc] initWithInt:RIGHT];
        } else if ([self isSet:__location__ withValue:RIGHT]) {
            self.location = [[NSNumber alloc] initWithInt:LEFT];
        } else {
            // default
            self.location = [[NSNumber alloc] initWithInt:LEFT];
        }
    } else if (__area__ == THIRD) {
        if ([self isSet:__location__ withValue:LEFT]) {
            self.location = [[NSNumber alloc] initWithInt:RIGHT];
        } else if ([self isSet:__location__ withValue:RIGHT]) {
            self.location = [[NSNumber alloc] initWithInt:BOTTOM];
        } else if ([self isSet:__location__ withValue:BOTTOM]) {
            self.location = [[NSNumber alloc] initWithInt:LEFT];
        } else {
            self.location = [[NSNumber alloc] initWithInt:LEFT];
        }
    } else if (__area__ == FOURTH) {
        if ([self isSet:__location__ withValue:TOP|LEFT]) {
            self.location = [[NSNumber alloc] initWithInt:TOP|RIGHT];
        } else if ([self isSet:__location__ withValue:TOP|RIGHT]) {
            self.location = [[NSNumber alloc] initWithInt:BOTTOM|RIGHT];
        } else if ([self isSet:__location__ withValue:BOTTOM|RIGHT]) {
            self.location = [[NSNumber alloc] initWithInt:BOTTOM|LEFT];
        } else if ([self isSet:__location__ withValue:BOTTOM|LEFT]) {
            self.location = [[NSNumber alloc] initWithInt:TOP|LEFT];
        } else {
            // default
            self.location = [[NSNumber alloc] initWithInt:TOP|LEFT];
        }
    } else {
        
    }
    // end of method setLocation
}

/* Checks whether a setting is set. This uses bit wise operators to store information. */
- (bool)isSet:(int)setting withValue:(int)value
{
    // No idea what this does
    int mask = ~value;
    return ((setting & value) == value) && ((setting & mask) == 0);
}

- (NSString *)toString
{
    NSMutableString *out = [[NSMutableString alloc] initWithString:@""];
    [out appendFormat:@"name: %@\n", toppingName];
    [out appendString:@"area: "];
    int __area__ = [[self getArea] intValue];
    if (__area__ == FULL) {
        [out appendString:@"FULL\n"];
    } else if (__area__ == HALF) {
        [out appendString:@"HALF\n"];
    } else if (__area__ == THIRD) {
        [out appendString:@"THIRD\n"];
    } else if (__area__ == FOURTH) {
        [out appendString:@"FOURTH\n"];
    } else {
        [out appendString:@"error\n"];
    }
    
    [out appendString:@"location: "];
    int __location__ = [[self location] intValue];
    
    if ([self isSet:__location__ withValue:LEFT]) {
        [out appendString:@"LEFT "];
    } else if ([self isSet:__location__ withValue:RIGHT]) {
        [out appendString:@"RIGHT "];
    } else if ([self isSet:__location__ withValue:TOP]) {
        [out appendString:@"TOP "];
    } else if ([self isSet:__location__ withValue:BOTTOM]) {
        [out appendString:@"BOTTOM "];
    }
    
    [out appendString:@"\n"];
    [out appendString:@"amount: "];
    
    int __amount__ = [[self getAmount] intValue];
    
    if (__amount__ == NORMAL) {
        [out appendString:@"NORMAL\n"];
    } else if (__amount__ == DOUBLE) {
        [out appendString:@"DOUBLE\n"];
    } else if (__amount__ == TRIPLE) {
        [out appendString:@"TRIPLE\n"];
    } else {
        // bad
        [out appendString:@"error\n"];
    }
    return out;
}


@end
