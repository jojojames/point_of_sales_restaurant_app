//
//  EmployeeListTableViewController.h
//  Point IPad
//
//  Created by Developer on 4/8/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@interface EmployeeListTableViewController : UITableViewController
@property (strong, nonatomic) Employee *currentEmployee; // the current employee chosen
@property (nonatomic, strong) NSString *whatLoginOption;
@property (nonatomic, strong) NSArray *allEmployees;
@property (nonatomic, strong) NSMutableArray *clockedInEmployees;
@property (nonatomic, strong) NSMutableArray *loggedInEmployee;
@property (nonatomic, strong) NSArray *listToDisplay; // displays all employees, clocked in employees are only one logged in employee
@end
