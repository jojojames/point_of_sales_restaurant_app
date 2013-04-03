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
- (NSArray *)returnEmployees;
- (void)insertClockIn:(Employee *)employee;
- (void)insertClockOut:(Employee *)employee;


// ItemProperties class
- (void)getItemProperties:(ItemProperties *)item withItemId:(NSString *)itemId;
- (void)getItemExtras:(ItemProperties *)item withItemId:(NSString *)itemId;
- (void)getItemToppings:(ItemProperties *)item withItemId:(NSString *)itemId;
- (void)getItemValues:(ItemProperties *)item withItemId:(NSString *)itemId;

// Database access for displaying item names, subclass names
- (NSMutableArray *)getItemsWithClassName:(NSString *)className andSubClassName:(NSString *)subClassName;
- (NSMutableArray *)getClassNames;
- (NSMutableArray *)getSubClassNameGivenClassName:(NSString *)className;
- (NSMutableArray *)getItemNamesGivenClassName:(NSString *)className;
- (NSMutableArray *)getItemsGiveSubClassName:(NSString *)className;
@end
