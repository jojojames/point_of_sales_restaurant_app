//
//  LoginTableViewController.m
//  Point IPad
//
//  Created by Developer on 4/8/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "LoginTableViewController.h"
#import "LoginTableViewCell.h"
#import "EmployeeListTableViewController.h"

@interface LoginTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation LoginTableViewController
@synthesize loginChoices;
@synthesize toPass;

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
    [self setLoginChoices:[[NSArray alloc] initWithObjects:
                           @"Login", @"Logout", @"Clock In", @"Clock Out", @"Break Start", @"Break End", nil]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [loginChoices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"loginChoice";
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.loginChoiceLabel.text = [loginChoices objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *pickedLoginOption = [loginChoices objectAtIndex:indexPath.row];
     // @"Login", @"Logout", @"Clock In", @"Clock Out", @"Break Start", @"Break End", nil]];
    if ([pickedLoginOption isEqualToString:@"Login"]) {
        [self setToPass:pickedLoginOption];
        [self performSegueWithIdentifier:@"pickEmployeeSegue" sender:self];
    } else if ([pickedLoginOption isEqualToString:@"Logout"]) {
        [self setToPass:pickedLoginOption];
        [self performSegueWithIdentifier:@"pickEmployeeSegue" sender:self];
    } else if ([pickedLoginOption isEqualToString:@"Clock In"]) {
        [self setToPass:pickedLoginOption];
        [self performSegueWithIdentifier:@"pickEmployeeSegue" sender:self];
    } else if ([pickedLoginOption isEqualToString:@"Clock Out"]) {
        [self setToPass:pickedLoginOption];
        [self performSegueWithIdentifier:@"pickEmployeeSegue" sender:self];
    } else if ([pickedLoginOption isEqualToString:@"Break Start"]) {
        // i
    } else if ([pickedLoginOption isEqualToString:@"Break End"]) {
        // nished
    } else {
       // something went wrong
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pickEmployeeSegue"]) {
        EmployeeListTableViewController *destViewController = segue.destinationViewController;
        destViewController.whatLoginOption = [self toPass];
        destViewController.allEmployees = [self allEmployees];
        destViewController.clockedInEmployees = [self clockedInEmployees];
        destViewController.loggedInEmployee = [self loggedInEmployee];
    }
    
}

@end
