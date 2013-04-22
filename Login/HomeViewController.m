//
//  HomeViewController.m
//  Login
//
//  Created by Developer on 3/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginMenuController.h"
#import "QuickServeCollectionViewController.h"
#import "DatabaseAccess.h"

@interface HomeViewController ()

@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *homeButtons;


@end

@implementation HomeViewController
@synthesize currentUserLabel;

- (DatabaseAccess *)database
{
    if (!_database) _database = [[DatabaseAccess alloc] init];
    return _database;
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
    self.isLoggedIn = NO; // user starts out not logged in
    
    
    self.clockedInEmployees = [[NSMutableArray alloc] init];
    self.loggedInEmployee = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self testLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* When seguing, the next view needs information to pull from the database, so send the database to the next view. */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loginMenuSegue"]) {
        LoginMenuController *destViewController = segue.destinationViewController;
        destViewController.allEmployees = [[self database] returnEmployees];
        destViewController.clockedInEmployees = [self clockedInEmployees];
        destViewController.loggedInEmployee = [self loggedInEmployee];
    }
    
    
    if ([segue.identifier isEqualToString:@"quickServeSegue"]) {
        QuickServeCollectionViewController *destViewController = segue.destinationViewController;
        destViewController.database = [self database];
        destViewController.pushedView = @"mainClassItems";
        destViewController.isActualItems = FALSE; // items don't show immediately, only class names
    }
}

- (void)dealloc {
    [_homeButtons release];
    [super dealloc];
}
@end