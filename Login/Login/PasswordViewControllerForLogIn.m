//
//  PasswordViewControllerForLogIn.m
//  Login
//
//  Created by Developer on 3/12/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "PasswordViewControllerForLogIn.h"
#import "HomeViewController.h"

@interface PasswordViewControllerForLogIn ()
@property (retain, nonatomic) IBOutlet UIButton *loggingButton;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
@end


@implementation PasswordViewControllerForLogIn
@synthesize passwordField;

- (IBAction)userEnteredPassword:(UIButton *)sender
{
    if([self.passwordField.text isEqualToString:[[self currentEmployee] password]]) {
        [self passwordSuccessAlert];
    } else {
        [self passwordFailedAlert];
    }
}

- (void)passwordSuccessAlert
{
    NSString *successHeader = [NSString stringWithFormat:@"Log %@ Success!", [self goingInOrOut]];
    NSString *successMessage = [NSString stringWithFormat:@"You have logged %@.", [self goingInOrOut]];
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

/* The root view needs to know whether or not the user has logged in or not.
 If it reaches this method, the user has logged in. */
- (void)sendDataBackToRoot
{
    HomeViewController *hvc = (HomeViewController *) (self.navigationController.viewControllers[0]);
    [self addOrRemoveEmployeeFromList:hvc];
    
}

- (void)addOrRemoveEmployeeFromList:(HomeViewController *)hvc {
    if ([self goingIn]) {
        hvc.isLoggedIn = YES;
        hvc.currentUserLabel.text = [[self currentEmployee] fullname];
        [[hvc loggedInEmployee] removeLastObject];
        [[hvc loggedInEmployee] addObject:[self currentEmployee]];
    } else {
        hvc.isLoggedIn = NO;
        hvc.currentUserLabel.text = @"";
        [[hvc loggedInEmployee] removeLastObject];
    }
}

/* Show a fail notication and erase the password field for the user to start over. */
- (void)passwordFailedAlert
{
    NSString *failMessage = [NSString stringWithFormat:@"Log %@ Failed", [self goingInOrOut]];
    UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:failMessage
                                                        message:@"You have entered the wrong password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    self.passwordField.text = @"";
    [failAlert show];
    [failAlert release];
}


- (void)setGoingInOrGoingOut {
    if([self goingIn]) {
        self.goingInOrOut = @"in";
        [[self loggingButton] setTitle:@"Log In" forState:UIControlStateNormal];
    } else {
        self.goingInOrOut = @"out";
        [[self loggingButton] setTitle:@"Log Out" forState:UIControlStateNormal];
    }
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_loggingButton release];
    [super dealloc];
}
@end
