//
//  PasswordViewController.m
//  Login
//
//  Created by Developer on 3/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "PasswordViewController.h"
#import "HomeViewController.h"
#import "LoginMenuController.h"

// Default use for Clock In
@interface PasswordViewController ()
@property (retain, nonatomic) IBOutlet UIButton *clockingButton;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
@end


@implementation PasswordViewController
@synthesize passwordField;
@synthesize goingInOrOut;
@synthesize clockingButton;

- (IBAction)userEnteredPassword:(UIButton *)sender
{
    if([self.passwordField.text isEqualToString:[[self currentEmployee] password]]) {
        [self passwordSuccessAlert];
    } else {
        [self passwordFailedAlert];
    }
}

/* Alert the user of success, send some data back and then pop back to the root view. */
- (void)passwordSuccessAlert
{
    NSString *successHeader = [NSString stringWithFormat:@"Clock %@ Success!", [self goingInOrOut]];
    NSString *successMessage = [NSString stringWithFormat:@"You have clocked %@.", [self goingInOrOut]];
    UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:successHeader
                                                           message:successMessage
                                                          delegate:nil
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil];
    [successAlert show];
    [successAlert release];
    
    [self sendDataBackToRoot];
    [self.navigationController popToRootViewControllerAnimated:YES]; // go back to the original screen
}

/* The root view needs to know whether or not the user has clocked in or not. 
    If it reaches this method, the user has clocked in. */
- (void)sendDataBackToRoot
{
    HomeViewController *hvc = (HomeViewController *) (self.navigationController.viewControllers[0]);
    [self addOrRemoveEmployeeFromList:hvc]; // add or remove
}

/* After getting the root HomeViewController, if the person is clocking in, add the current employee to the list of employees clocked in, if the person is clocking out, remove the person from the list of people currently clocked in. */
- (void)addOrRemoveEmployeeFromList:(HomeViewController *)hvc {
    if ([self goingIn]) {
        hvc.currentUserLabel.text = [[self currentEmployee] fullname];
        [[hvc clockedInEmployees] addObject:[self currentEmployee]];
        [[hvc database] insertClockIn:[self currentEmployee]]; // clock them in
    } else {
        hvc.currentUserLabel.text = @""; // reset the label
        [[hvc clockedInEmployees] removeObjectIdenticalTo:[self currentEmployee]];
        [[hvc database] insertClockOut:[self currentEmployee]]; // clock them out
    }
}

/* Show a fail notication and erase the password field for the user to start over. */
- (void)passwordFailedAlert
{
    NSString *failMessage = [NSString stringWithFormat:@"Clock %@ Failed", [self goingInOrOut]];
    UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:failMessage
                                                        message:@"You have entered the wrong password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    self.passwordField.text = @"";
    [failAlert show];
    [failAlert release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    passwordField.text = textField.text;
    [textField resignFirstResponder];
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    passwordField.delegate = self;
    [self setGoingInOrGoingOut];
}

/* For setting the title of the button as well as the messages surrounding clock/log in/out. */
- (void)setGoingInOrGoingOut {
    if([self goingIn]) {
        self.goingInOrOut = @"in";
        [[self clockingButton] setTitle:@"Clock In" forState:UIControlStateNormal];
    } else {
        self.goingInOrOut = @"out";
        [[self clockingButton] setTitle:@"Clock Out" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [passwordField release];
    [clockingButton release];
    [super dealloc];
}
@end