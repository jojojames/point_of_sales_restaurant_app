//
//  LoginTableViewController.h
//  Login
//
//  Created by Developer on 3/5/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"
#import "Employee.h"

@interface LoginTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *employees;
@property (strong, nonatomic) DatabaseAccess *database;
@property (nonatomic, assign, getter=goingIn) BOOL goingIn; // logging/clocking in || logging/clocking out
@end
