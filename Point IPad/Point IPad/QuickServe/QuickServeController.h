//
//  QuickServeController.h
//  Point IPad
//
//  Created by Developer on 4/22/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"
#import "Orders.h"

@interface QuickServeController : UIViewController 
@property (strong, nonatomic) DatabaseAccess *database; // database query
@property (strong, nonatomic) Orders *order; // the model for orders, handles the logic behind orders
@property (strong, nonatomic) NSNumber *selectedItemIndex;


@property (strong, nonatomic) NSString *pushedView;
@property (strong, nonatomic) NSString *nameOfSelected; // whatever is selected in the menu

// These six handle selecting and navigating through the menus.
@property (nonatomic, strong) NSMutableArray * stackOfMenus;
@property (nonatomic, strong) NSMutableArray * currentMenuItems;
@property (nonatomic, assign, getter=isActualItems) BOOL isActualItems;
@property (nonatomic, assign, getter=isSubclass) BOOL isSubclass;
@property (nonatomic, strong) NSMutableArray * stackOfIsActualItemBools;
@property (nonatomic, strong) NSMutableArray * stackOfIsSubclassBools;

// Use this along with the item name to get the item id for uniqueness.
@property (nonatomic, strong) NSString *classNameForDatabase;
@property (nonatomic, strong) NSString *subclassNameForDatabase;
@property (nonatomic, strong) NSNumber *selectedItemId;

// Change the names of the extra taxes only once.
@property (nonatomic, assign, getter=taxNameChanged) BOOL taxNameChanged;

// Table number, the key for a hashmap that holds QuickServe controllers.
@property (nonatomic, strong) NSNumber *tableNumber;

// tax label names
@property (retain, nonatomic) IBOutlet UILabel *firstTaxNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *secondTaxNameLabel;


@end
