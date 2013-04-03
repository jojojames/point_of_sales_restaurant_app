//
//  LoginMenuController.h
//  Login
//
//  Created by Developer on 3/12/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"

@interface LoginMenuController : UIViewController
@property (strong, nonatomic) DatabaseAccess *database;
@property (nonatomic, assign, getter=isLoggedIn) BOOL isLoggedIn;

// employees, all (all), clocked in (many), logged in (1)
@property (nonatomic, strong) NSArray *allEmployees;
@property (nonatomic, strong) NSMutableArray *clockedInEmployees;
@property (nonatomic, strong) NSMutableArray *loggedInEmployee;
@end
