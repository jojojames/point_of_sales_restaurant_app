//
//  HomeViewController.h
//  Login
//
//  Created by Developer on 3/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DatabaseAccess.h"
#include "Employee.h"

@interface HomeViewController : UIViewController

@property (strong, nonatomic) DatabaseAccess *database; // the main database that the whole program draws from
@property (retain, nonatomic) IBOutlet UILabel *currentUserLabel;
@property (nonatomic, assign, getter=isLoggedIn) BOOL isLoggedIn;

// clocked in employees
@property (nonatomic, strong) NSMutableArray *clockedInEmployees;
@property (nonatomic, strong) NSMutableArray *loggedInEmployee; // only one will be logged in a time


@end
