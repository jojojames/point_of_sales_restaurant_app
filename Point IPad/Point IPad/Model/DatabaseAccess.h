//
//  DatabaseAccess.h
//  Login
//
//  Created by Developer on 3/5/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSQLConnection.h"
#import "PGSQLConnectionInfo.h"
#import "Time.h"
#import "ItemExtras.h"
#import "ItemColorProperties.h"

@class ItemProperties;
@class Employee;

@interface DatabaseAccess : NSObject {
    PGSQLConnection *pgConn;
    Time *time;
}

// Database access for Employees, Logging In/Logging Out
- (NSArray *)employeesFromDatabase;
- (void)insertClockIn:(Employee *)employee;
- (void)insertClockOut:(Employee *)employee;


// ItemProperties class
- (void)itemProperties:(ItemProperties *)item withItemId:(NSString *)itemId;
- (void)itemExtras:(ItemProperties *)item withItemId:(NSString *)itemId;
- (void)itemToppings:(ItemProperties *)item withItemId:(NSString *)itemId;
- (void)itemValues:(ItemProperties *)item withItemId:(NSString *)itemId;

// Database access for displaying item names, subclass names
- (NSMutableArray *)itemsWhereClassIs:(NSString *)className andSubclassIs:(NSString *)subClassName;
- (NSMutableArray *)classNames;
- (NSMutableArray *)subclassWhereClassIs:(NSString *)className;
- (NSMutableArray *)itemsWhereClassIs:(NSString *)className;
- (NSMutableArray *)itemsWhereSubclassIs:(NSString *)className;

- (NSNumber *)itemIdWhereClassIs:(NSString *)className andSubclassIs:(NSString *)subClassName andItemIs:(NSString *)itemName;

// Database access to pull modifier settings
- (NSMutableArray *)hotnessOptionsModifierOne:(NSNumber *)item_id;
- (NSMutableArray *)quantityOptionsModifierTwo:(NSNumber *)item_id;
- (NSMutableArray *)extraOptionsModifierThree:(NSNumber *)item_id;
- (NSMutableArray *)optionOptionsModifierFour:(NSNumber *)item_id;
@end
