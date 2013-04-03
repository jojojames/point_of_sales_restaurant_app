//
//  LoginMenuController.m
//  Login
//
//  Created by Developer on 3/12/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "LoginMenuController.h"
#import "LoginTableViewController.h"

@interface LoginMenuController ()
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *loginButtons;

@end

@implementation LoginMenuController

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


/* When seguing, the next view needs information to pull from the database, so send the database to the next view. */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"clockInSegue"]) {
        LoginTableViewController *destViewController = segue.destinationViewController;
        destViewController.employees = [self allEmployees];
        destViewController.goingIn = true;
    }
    
    if ([segue.identifier isEqualToString:@"clockOutSegue"]) {
        LoginTableViewController *destViewController = segue.destinationViewController;
        destViewController.employees = [self clockedInEmployees];
        destViewController.goingIn = false;
    }
    
    if ([segue.identifier isEqualToString:@"logInSegue"]) {
        LoginTableViewController *destViewController = segue.destinationViewController;
        destViewController.employees = [self clockedInEmployees];
        destViewController.goingIn = true;
    }
    
    if ([segue.identifier isEqualToString:@"logOutSegue"]) {
        LoginTableViewController *destViewController = segue.destinationViewController;
        destViewController.employees = [self loggedInEmployee];
        destViewController.goingIn = false;
    }
}

- (void)dealloc
{
    [_loginButtons release];
    [super dealloc];
}

@end
