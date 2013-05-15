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
@property (nonatomic, strong) NSNumber * totalPrice;
@property (nonatomic, strong) NSMutableArray *currentNames;  // contains the names of the current order
@property (nonatomic, strong) NSMutableArray *currentPrices; // contains the prices of the current order
@property (nonatomic, strong) NSMutableArray *currentQtys;   // containts the quantities of every order

- (void)addToOrder:(NSNumber *)itemId;

@end
