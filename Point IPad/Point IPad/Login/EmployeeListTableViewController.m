//
//  EmployeeListTableViewController.m
//  Point IPad
//
//  Created by Developer on 4/8/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "EmployeeListTableViewController.h"
#import "EmployeeListTableViewCell.h"
#import "HomeViewController.h"

@interface EmployeeListTableViewController ()
@property (retain, nonatomic) IBOutlet UITableView *EmployeeList;

@end

@implementation EmployeeListTableViewController
@synthesize whatLoginOption;
@synthesize allEmployees;
@synthesize clockedInEmployees;
@synthesize loggedInEmployee;
@synthesize listToDisplay;
@synthesize EmployeeList;
@synthesize currentEmployee;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    // @"Login", @"Logout", @"Clock In", @"Clock Out", @"Break Start", @"Break End", nil]];
    NSString *loginOption = [self whatLoginOption];
    if ([loginOption isEqualToString:@"Login"]) {
        listToDisplay = [self clockedInEmployees];
    } else if ([loginOption isEqualToString:@"Logout"]) {
        listToDisplay = [self loggedInEmployee]; // will only display a list of 1
    } else if ([loginOption isEqualToString:@"Clock In"]) {
        listToDisplay = [self allEmployees];
    } else if ([loginOption isEqualToString:@"Clock Out"]) {
        listToDisplay = [self clockedInEmployees];
    } else if ([loginOption isEqualToString:@"Break Start"]) {
        //implement later
    } else if ([loginOption isEqualToString:@"Break End"]) {
        // implement later
    } else {
        //error
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listToDisplay count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"employeeCell";
    EmployeeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.employeeLabel.text = [[listToDisplay objectAtIndex:indexPath.row] fullname];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // get the current employee here, after entering the password or logging out,
    // everything will be checked against this current employee, whether logging in or out
    self.currentEmployee = [listToDisplay objectAtIndex:indexPath.row];
    
    NSString *loginOption = [self whatLoginOption];
    if ([loginOption isEqualToString:@"Login"]) {
        //listToDisplay = [self clockedInEmployees];
        // compare selected employee and listToDisplay's index's employee's name
        [self enterPassword];
    } else if ([loginOption isEqualToString:@"Logout"]) {
        //listToDisplay = [self loggedInEmployee]; // will only display a list of 1
        // compare selected employee with the only one in listtodisplay, dont need password
        [self userLogOut:currentEmployee];
    } else if ([loginOption isEqualToString:@"Clock In"]) {
        //listToDisplay = [self allEmployees];
        // compare selected employee with the employee from listtodisplay's idnex
        [self enterPassword];
    } else if ([loginOption isEqualToString:@"Clock Out"]) {
        //listToDisplay = [self clockedInEmployees];
        // compar selected employee with list to display, don't need password
        [self userLogOut:currentEmployee];
    } else if ([loginOption isEqualToString:@"Break Start"]) {
        //implement later
    } else if ([loginOption isEqualToString:@"Break End"]) {
        // implement later
    } else {
        //error
    }
}

- (void)enterPassword {
    // SET UP A TEXT DELEGATE; SET UP USER AGAINST TEXT DELEGATE COMPARISON
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Password" message:@"Enter the password:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alertView show];
    [alertView release];
}

- (void)userLogOut:(Employee *)currentEmployee {
    NSString *__message___;
    if ([[self whatLoginOption] isEqualToString:@"Logout"]) {
        // log out
        __message___ = [[NSString alloc] initWithString:@"You have logged out."];
        [self doLogOutMessage:__message___];
        [self sendDataBackToRoot];
        [self.navigationController popToRootViewControllerAnimated:YES]; // go back to original screen after logging out
    } else if ([[self whatLoginOption] isEqualToString:@"Clock Out"]) {
        // clock out
        __message___ = [[NSString alloc] initWithString:@"You have clocked out."];
        [self doLogOutMessage:__message___];
        [self sendDataBackToRoot];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        // break end
        __message___ = [[NSString alloc] initWithString:@"You have ended your break."];
        // implement the rest
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES]; // go back to the original screen
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        NSString *passwordEntered = [alertView textFieldAtIndex:0].text;
        if([passwordEntered isEqualToString:[[self currentEmployee] password]]) {
            [self passwordSuccessAlert];
        } else {
            [self passwordFailedAlert];
        }
    }
}

/* Alert the user of success, send some data back and then pop back to the root view. */
- (void)passwordSuccessAlert
{
    UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                           message:@"You've entered the correct password."
                                                          delegate:nil
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil];
    [successAlert show];
    [successAlert release];
    
    [self sendDataBackToRoot];
    [self.navigationController popToRootViewControllerAnimated:YES]; // go back to the original screen
}

- (void)sendDataBackToRoot
{
    HomeViewController *hvc = (HomeViewController *) (self.navigationController.viewControllers[0]);
    [self addOrRemoveEmployeeFromList:hvc]; // add or remove
}

// Depending on what the user is doing, this takes care of the array handling of users as well as inputting the correct values into the database.
- (void)addOrRemoveEmployeeFromList:(HomeViewController *)hvc {
    
     NSString *loginOption = [self whatLoginOption];
    // @"Login", @"Logout", @"Clock In", @"Clock Out", @"Break Start", @"Break End", nil]];
     
    if ([loginOption isEqualToString:@"Login"]) {
        hvc.isLoggedIn = YES;
        [[hvc loggedInEmployee] removeLastObject];
        [[hvc loggedInEmployee] addObject:[self currentEmployee]];
    }
    
    if ([loginOption isEqualToString:@"Clock In"]) {
        [[hvc clockedInEmployees] addObject:[self currentEmployee]];
        [[hvc database] insertClockIn:[self currentEmployee]]; // clock them in
    }
    
    if ([loginOption isEqualToString:@"Break Start"]) {
        // implement later
    }
    
    if ([loginOption isEqualToString:@"Logout"]) {
        hvc.isLoggedIn = NO;
        [[hvc loggedInEmployee] removeLastObject];
    }
    
    if ([loginOption isEqualToString:@"Clock Out"]) {
        [[hvc clockedInEmployees] removeObjectIdenticalTo:[self currentEmployee]];
        [[hvc database] insertClockOut:[self currentEmployee]]; // clock them out
    }
    
    if ([loginOption isEqualToString:@"Break End"]) {
        // implement later
        
    }
    
}

// Alert the user and then let the user pick an employee again.
- (void)passwordFailedAlert
{
    UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Wrong password!"
                                                        message:@"You have entered the wrong password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [failAlert show];
    [failAlert release];
}

- (void)doLogOutMessage:(NSString *)__message__ {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Goodbye!"
                                                        message:__message__
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)dealloc {
    [EmployeeList release];
    [super dealloc];
}
@end
