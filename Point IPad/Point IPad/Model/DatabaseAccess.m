//
//  DatabaseAccess.m
//  Login
//
//  Created by Developer on 3/5/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "DatabaseAccess.h"
#import "PGSQLConnection.h"
#import "PGSQLConnectionInfo.h"
#import "Employee.h"
#import "ItemToppings.h"
#import "ItemProperties.h"

@implementation DatabaseAccess

- (DatabaseAccess *)init
{
    pgConn = [[[[PGSQLConnection alloc] init] autorelease] retain];
    time = [[Time alloc] init];
    
    /* Manually connect for now */
    [self setDatabase:@"postgres" server:@"192.168.1.14" port:@"5432" dbname:@"POS" password:@""]; // POS
    //[self setDatabase:@"postgres" server:@"192.168.1.26" port:@"5432" dbname:@"RGN30" password:@""]; // RGN 30
    
    if (![pgConn connect]) {
        NSLog(@"fail");
        return self;
    }
    return self;
    
}

- (void)setDatabase:(NSString *)userName server:(NSString *)server port:(NSString *)port dbname:(NSString *)databaseName password:(NSString *)password
{
    [pgConn setUserName:userName];
    [pgConn setServer:server];
    [pgConn setPort:port];
    [pgConn setDatabaseName:databaseName];
    [pgConn setPassword:password];
}

- (NSArray *)employeesFromDatabase
{
    NSArray *employees = [[self getEmployeeFromDatabase] copy];
    return employees;
}

- (NSArray *)getEmployeeFromDatabase
{
    
    NSMutableArray *employeeArray = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT FNAME, LNAME, PASSWORD, EMPLOYEE_ID FROM TBL_EMPLOYEE";
    NSMutableString *command = [[NSMutableString alloc] initWithString:query];
    PGSQLRecordset *rs = [pgConn open:command];
    for(int i=0; i<[rs rowCount]; i++) {
        Employee *employee = [[Employee alloc] init];
        employee.fname = [[rs fieldByIndex:0] asString];
        employee.lname = [[rs fieldByIndex:1] asString];
        NSMutableString *fl_name = [[NSMutableString alloc] initWithString:@""];
        [fl_name appendString:employee.fname];
        [fl_name appendString:@" "];
        [fl_name appendString:employee.lname];
        employee.fullname = fl_name;
        employee.password = [[rs fieldByIndex:2] asString];
        employee.empId = [[rs fieldByIndex:3] asString];
        [employeeArray addObject:employee];
        [rs moveNext];
    }
    return employeeArray;
}

- (void)itemProperties:(ItemProperties *)item withItemId:(NSString *)itemId
{
    NSString *query = [[NSString alloc] initWithFormat:@"SELECT HOTNESS, OPTIONS, COMMENT, TOPPINGS_LEVEL, TOPPING_THRESHOLD, TOPPING_PRICE, NAME, HOTNESS_LEVEL, COMMENTS_LEVEL, OPTIONS_LEVEL, QUANTITY_LEVEL, EXTRAS_LEVEL, HAS_SUBITEMS, getTaxPercentage(%@), COOK_ITEM, SET_PRICE, SLOT_TIME, COURSE FROM TBL_ITEMS WHERE ITEM_ID = %@", itemId, itemId];
    
    
    NSMutableString *command = [[NSMutableString alloc] initWithString:query];
    PGSQLRecordset *rs = [pgConn open:command];
    
    [item setHotness:[[rs fieldByIndex:0] asString]];
    [item setOptions:[[rs fieldByIndex:1] asString]];
    [item setComments:[[rs fieldByIndex:2] asString]];
    [item setToppingsLevel:[[rs fieldByIndex:3] asString]];
    [item setToppingThreshold:[[rs fieldByIndex: 4] asNumber]];
    [item setToppingPrice:[[rs fieldByIndex:5] asString]];
    [item setItemName:[[rs fieldByIndex:6] asString]];
    [item setHotnessLevel:[[rs fieldByIndex:7] asString]];
    [item setCommentsLevel:[[rs fieldByIndex:8] asString]];
    [item setOptionsLevel:[[rs fieldByIndex:9] asString]];
    [item setQuantityLevel:[[rs fieldByIndex:10] asString]];
    [item setExtrasLevel:[[rs fieldByIndex:11] asString]];
    [item setHasSubItems:[[rs fieldByIndex:12] asBoolean]];
    [item setTaxPercentage:[[rs fieldByIndex:13] asString]];
    [item setCookitem:[[rs fieldByIndex:14] asBoolean]];
    [item setPriceStatus:[[rs fieldByIndex:15] asString]];
    [item setSlot_time:[[rs fieldByIndex:16] asString]];
    [item setCourse:[[rs fieldByIndex:17] asString]];
    
    for (int i=0; i<[[rs columns] count]; i++) {
        //NSLog(@"%d:", i);
        //NSLog([[rs fieldByIndex:i] asString]);
    }
    
}

- (void)itemExtras:(ItemProperties *)item withItemId:(NSString *)itemId
{
    NSString *selectExtras = [[NSString alloc] initWithFormat:
                              @"SELECT EXTRAS_ID, PRICE FROM TBL_EXTRAS WHERE ITEM_ID = %@::text", itemId];
    NSMutableString *command = [[NSMutableString alloc] initWithString:selectExtras];
    PGSQLRecordset *rs = [pgConn open:command];
    for (int i=0; i<[rs rowCount]; i++) {
        ItemExtras *extras = [[ItemExtras alloc] init];
        extras.extrasId = [[rs fieldByIndex:0] asString];
        extras.extrasName = [[rs fieldByIndex:1] asString];
        extras.extrasPrice = [[rs fieldByIndex:2] asString];
        [[item vItemExtras] addObject:extras];
        [rs moveNext];
    }
    
}

- (void)itemToppings:(ItemProperties *)item withItemId:(NSString *)itemId
{
    NSString *query = [[NSString alloc] initWithFormat:@"SELECT A.TOPPING_ID, B.TOPPING_NAME, B.TOPPING_VALUE FROM TBL_ITEM_TOPPINGS A, TBL_TOPPINGS B WHERE A.ITEM_ID = %@ AND A.TOPPING_ID=B.TOPPING_ID", itemId];
    NSMutableString *command = [[NSMutableString alloc] initWithString:query];
    PGSQLRecordset *rs = [pgConn open:command];
    for (int i=0; i<[rs rowCount]; i++) {
        ItemToppings *toppings = [[ItemToppings alloc] init];
        toppings.toppingId = [[rs fieldByIndex:0] asString];
        toppings.toppingName = [[rs fieldByIndex:1] asString];
        toppings.toppingValue = [[rs fieldByIndex:2] asNumber];
        toppings.isDefault = TRUE;
        toppings.isSelected = TRUE;
        [[item vItemToppings] addObject:toppings];
        [rs moveNext];
    }
}

- (void)itemValues:(ItemProperties *)item withItemId:(NSString *)itemId
{
    NSString *selectValues = [[NSString alloc] initWithFormat:
                              @"SELECT getPrice(%@), getTax(%@) FROM TBL_ITEMS WHERE ITEM_ID = %@", itemId, itemId, itemId];
    NSMutableString *command = [[NSMutableString alloc] initWithString:selectValues];
    PGSQLRecordset *rs = [pgConn open:command];
    item.item_price = [[rs fieldByIndex:0] asNumber];
    item.item_tax = [[rs fieldByIndex:1] asNumber];
}

- (void)insertClockIn:(Employee *)employee
{
    
    NSString *CURRENT_DATE = [time yearMonthDay];
    NSString *CURRENT_TIMESTAMP = [time yearMonthDayTime];
    
    NSString *insertString = [NSString stringWithFormat:
                              @"insert into tbl_salary(DATE, EMPLOYEE_ID, CLOCK_IN, auto_status, update_status, hrs_status) VALUES(\'%@\', %@, \'%@\', %@, %@, %@)", CURRENT_DATE, [employee empId], CURRENT_TIMESTAMP, @"false", @"false", @"true"];
    NSString *updateString = [NSString stringWithFormat:
                              @"UPDATE TBL_EMPLOYEE SET STATUS = TRUE, DRIVER_STATUS=TRUE WHERE EMPLOYEE_ID=%@", [employee empId]];
    
    employee.clockInTime = CURRENT_TIMESTAMP; // set the timestamp for the employee for clockout later
    [pgConn open:insertString];
    [pgConn open:updateString];
}



#define SECONDS_IN_HOURS 3600 // database is in hours

- (void)insertClockOut:(Employee *)employee
{
    // time
    NSString *CURRENT_TIMESTAMP = [time yearMonthDayTime];
    double timeDiff = [time timeBetweenDate:[employee clockInTime] andSecondDate:CURRENT_TIMESTAMP];
    double timeDiffInHours = timeDiff / SECONDS_IN_HOURS;
    
    // sql
    NSString *updateTblSalary = [NSString stringWithFormat:
                                 @"UPDATE TBL_SALARY SET CLOCK_OUT=\'%@\', HRS=%f WHERE EMPLOYEE_ID=%@ AND CLOCK_OUT IS NULL", CURRENT_TIMESTAMP, timeDiffInHours, [employee empId]];
    NSString *updateTblEmployee = [NSString stringWithFormat:
                                   @"UPDATE TBL_EMPLOYEE SET STATUS=FALSE, driver_status=FALSE, break_status=false WHERE EMPLOYEE_ID=%@", [employee empId]];
    [pgConn open:updateTblSalary];
    [pgConn open:updateTblEmployee];
    
    //NSLog(@"timedifference: %f \nsecondsinhours: %d \n together: %f", timeDiff, SECONDS_IN_HOURS, timeDiff/SECONDS_IN_HOURS);
}

/* Get a distinct set of class names to display to the user. */
- (NSMutableArray *)classNames
{
    NSString *query = [NSString stringWithFormat:
                       @"SELECT DISTINCT CLASS FROM TBL_ITEMS"];
    PGSQLRecordset *rs = [pgConn open:query];
    NSMutableArray *vClassNames = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[rs rowCount]; i++) {
        NSString *className = [[rs fieldByIndex:0] asString];
        [vClassNames addObject:className];
        [rs moveNext];
    }
    
    return vClassNames;
}


/* User picks choice of class/food choices, to retrieve the subclass of the food. */
- (NSMutableArray *)subclassWhereClassIs:(NSString *)className
{
    
    NSLog(@"%@:", className);
    NSString *query = [NSString stringWithFormat:
                       @"SELECT DISTINCT SUBCLASS FROM TBL_ITEMS WHERE CLASS='%@'", className];
    PGSQLRecordset *rs = [pgConn open:query];
    NSMutableArray *vSubClassNames = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[rs rowCount]; i++) {
        NSString *subClassName = [[rs fieldByIndex:0] asString];
        [vSubClassNames addObject:subClassName];
        [rs moveNext];
    }
    return vSubClassNames;
}

- (NSMutableArray *)itemsWhereClassIs:(NSString *)className
{
    NSString *query = [NSString stringWithFormat:
                       @"SELECT DISTINCT NAME FROM TBL_ITEMS WHERE CLASS='%@'", className];
    PGSQLRecordset *rs = [pgConn open:query];
    NSMutableArray *vItemNames = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[rs rowCount]; i++) {
        NSString *itemName = [[rs fieldByIndex:0] asString];
        [vItemNames addObject:itemName];
        [rs moveNext];
    }
    return vItemNames;
}

- (NSNumber *)itemIdWhereClassIs:(NSString *)className andSubclassIs:(NSString *)subClassName andItemIs:(NSString *)itemName
{
    
    NSString *query;
    if (subClassName) {
        query = [NSString stringWithFormat:
                          @"SELECT item_id from TBL_ITEMS WHERE CLASS='%@' AND SUBCLASS='%@' AND NAME='%@'", className, subClassName, itemName];
    } else {
        // subclass name empty
        query = [NSString stringWithFormat:@"SELECT item_id from TBL_ITEMS WHERE CLASS='%@' AND NAME='%@'", className, itemName];
    }
    //NSLog(@"%@", subClassName);

    PGSQLRecordset *rs = [pgConn open:query];
    return [[rs fieldByIndex:0] asNumber];
}


- (NSMutableArray *)itemsWhereSubclassIs:(NSString *)className
{
    NSLog(@"CLASSNAME: : : : %@:", className);
    NSString *query = [NSString stringWithFormat:
                       @"SELECT DISTINCT NAME FROM TBL_ITEMS WHERE SUBCLASS='%@'", className];
    PGSQLRecordset *rs = [pgConn open:query];
    NSMutableArray *vItemNames = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[rs rowCount]; i++) {
        NSString *itemName = [[rs fieldByIndex:0] asString];
        [vItemNames addObject:itemName];
        [rs moveNext];
    }
    return vItemNames;
}


- (NSMutableArray *)itemsWhereClassIs:(NSString *)className andSubclassIs:(NSString *)subClassName
{
    
    NSString *queryStripped = [NSString stringWithFormat:
                       @"SELECT ITEM_ID, NAME, getPrice(ITEM_ID), getTax(ITEM_ID), ITEM_COLOR, ITEM_IMAGE, ITEM_LOCATION, item_size, font_size FROM TBL_ITEMS WHERE CLASS = '%@' AND SUBCLASS = '%@' AND getPrice(ITEM_ID) !=0 ORDER BY NAME", className, subClassName];
    
    NSMutableString *command = [[NSMutableString alloc] initWithString:queryStripped];
    PGSQLRecordset *rs = [pgConn open:command];
    
    
    // need an array to add itemColorProperties to
    NSMutableArray *vItems = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[rs rowCount]; i++) {
        ItemColorProperties *itemColorProperties = [[ItemColorProperties alloc] init];
        /* ItemColorProperties doesn't need the 6th column because it doesn't have a property for it.
         Column/Index 6 is location.
         */
        [itemColorProperties setItemId:[[rs fieldByIndex:0] asString]];
        [itemColorProperties setItemName:[[rs fieldByIndex:1] asString]];
        [itemColorProperties setItemPrice:[[rs fieldByIndex:2] asString]];
        [itemColorProperties setItemTax:[[rs fieldByIndex:3] asString]];
        [itemColorProperties setItemColor:[[rs fieldByIndex:4] asString]];
        [itemColorProperties setItemImage:[[rs fieldByIndex:5] asString]];
        [itemColorProperties setItemsize:[[rs fieldByIndex:7] asString]];
        [itemColorProperties setFontsize:[[rs fieldByIndex:8] asString]];
        [vItems addObject:itemColorProperties]; // add it to an array and then return the array as data to another view
        //NSLog([[rs fieldByIndex:0] asString]);
        //NSLog([itemColorProperties itemName]);
        [rs moveNext];
        
    }
    return vItems;
    
}

- (NSMutableArray *)hotnessOptionsModifierOne:(NSNumber *)item_id
{
    NSString *query = [NSString stringWithFormat:@"SELECT hotness, hotness_level, hotness_threshold, hotness_images from TBL_ITEMS where item_id=%@", item_id];
    return [self createModsUsing:query];
}

- (NSMutableArray *)quantityOptionsModifierTwo:(NSNumber *)item_id
{
    NSString *query = [NSString stringWithFormat:@"SELECT size, quantity_id, price, quantity_images from TBL_QUANTITY where item_id=%@", item_id];
    return [self createModsUsing:query];
}

- (NSMutableArray *)extraOptionsModifierThree:(NSNumber *)item_id
{
    NSString *query = [NSString stringWithFormat:@"SElECT extras, extras_id, price, extra_images from TBL_EXTRAS where item_id=%@", item_id];
    return [self createModsUsing:query];
}

- (NSMutableArray *)optionOptionsModifierFour:(NSNumber *)item_id
{
    NSString *query = [NSString stringWithFormat:@"SELECT options, options_level, option_threshold, option_images from TBL_ITEMS where item_id=%@", item_id];
    return [self createModsUsing:query];
}

//mod1/hotness, mod2/quantity, mod3/extras, mod4/options


- (NSMutableArray *)createModsUsing:(NSString *)query
{
    
    NSMutableArray *modOptions = [[NSMutableArray alloc] init];
    PGSQLRecordset *rs = [pgConn open:query];
    
    if([[rs fieldByIndex:0] asString]) {
        [modOptions addObject:[[rs fieldByIndex:0] asString]];
    } else {
        [modOptions insertObject:@"null" atIndex:[modOptions count]];
    }
    
    if([[rs fieldByIndex:1] asString]) {
        [modOptions addObject:[[rs fieldByIndex:1] asString]];
    } else {
        [modOptions insertObject:@"null" atIndex:[modOptions count]];
    }
    
    if([[rs fieldByIndex:2] asString]) {
        [modOptions addObject:[[rs fieldByIndex:2] asString]];
    } else {
        [modOptions insertObject:@"null" atIndex:[modOptions count]];
    }
    
    if([[rs fieldByIndex:3] asString]) {
        [modOptions addObject:[[rs fieldByIndex:3] asString]];
    } else {
        [modOptions insertObject:@"null" atIndex:[modOptions count]];
    }
    
    return modOptions;
}

// Dealing with orders
- (NSNumber *)getLunchPriceUsing:(NSNumber *)itemId
{
    NSString *query = [NSString stringWithFormat:@"SELECT lunch_price from TBL_ITEMS where item_id=%@", itemId];
    //NSLog(@"DATABASEACCESS: ITEM_ID: %@", itemId);
    PGSQLRecordset *rs = [pgConn open:query];
    //NSLog(@"PRICE: %@", [[rs fieldByIndex:0] asNumber]);
    return [[rs fieldByIndex:0] asNumber];
}

- (NSString *)getItemNameUsing:(NSNumber *)itemId
{
    NSString *query = [NSString stringWithFormat:@"SELECT name from TBL_ITEMS where item_id=%@", itemId];
    PGSQLRecordset *rs = [pgConn open:query];
    return [[rs fieldByIndex:0] asString];
}

- (NSNumber *)getModPriceExtra:(NSNumber *)itemId withModName:(NSString *)modName
{
    // select price from tbl_extras where item_id='57' AND extras='M3';
    NSString *query = [NSString stringWithFormat:@"SELECT price from TBL_EXTRAS where item_id=\'%@\' AND extras=\'%@\'", itemId, modName];
    PGSQLRecordset *rs = [pgConn open:query];
    //NSLog(@"EXTRA MOD EXTRA : %@", [[rs fieldByIndex:0] asNumber]); // TEST
    return [[rs fieldByIndex:0] asNumber];
}

- (NSNumber *)getModPriceQuantity:(NSNumber *)itemId withModName:(NSString *)modName
{
    // select price from tbl_quantity where item_id=57 AND size='M2';
    NSString *query = [NSString stringWithFormat:@"SELECT price from TBL_QUANTITY where item_id=%@ AND size=\'%@\'", itemId, modName];
    PGSQLRecordset *rs = [pgConn open:query];
    //NSLog(@"QTY MOD EXTRA : %@", [[rs fieldByIndex:0] asNumber]); // TEST
    return [[rs fieldByIndex:0] asNumber];
}

- (void)closeConnection
{
    [pgConn close];
}



@end
