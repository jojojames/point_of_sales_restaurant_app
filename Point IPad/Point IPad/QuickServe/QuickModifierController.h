//
//  QuickModifierController.h
//  Point IPad
//
//  Created by Developer on 5/13/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"

@interface QuickModifierController : UITableViewController
@property (nonatomic, strong) NSNumber *selectedItemId;
@property (nonatomic, strong) NSMutableArray *modsToShow;
@property (nonatomic, strong) NSMutableArray *modOptionKeys;
@property (nonatomic, strong) NSString *selectedModifier;
@property (strong, nonatomic) DatabaseAccess *database;
@end
