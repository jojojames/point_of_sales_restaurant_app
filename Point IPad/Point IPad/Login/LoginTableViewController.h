//
//  LoginTableViewController.h
//  Point IPad
//
//  Created by Developer on 4/8/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *loginChoices;
@property (nonatomic, strong) NSString *toPass; // pass the user's choice of login to the next view
// employees, all (all), clocked in (many), logged in (1)
@property (nonatomic, strong) NSArray *allEmployees;
@property (nonatomic, strong) NSMutableArray *clockedInEmployees;
@property (nonatomic, strong) NSMutableArray *loggedInEmployee;
@end
