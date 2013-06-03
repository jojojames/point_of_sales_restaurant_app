//
//  PaymentTableViewController.m
//  Point IPad
//
//  Created by Developer on 6/3/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "PaymentTableViewController.h"
#import "PaymentTableViewCell.h"

@interface PaymentTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation PaymentTableViewController
@synthesize paymentChoices;
@synthesize order;
@synthesize tableNumber;

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
    // Initialize all the payment choices.
    [self setPaymentChoices:[[NSArray alloc] initWithObjects:@"Cash", @"Debit", nil]];
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
    return [paymentChoices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"paymentChoice";
    PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.paymentChoiceLabel.text = [paymentChoices objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *pickedPaymentChoice = [paymentChoices objectAtIndex:indexPath.row];
    if ([pickedPaymentChoice isEqualToString:@"Cash"]) {
        // Handle Cash payment.
    } else if ([pickedPaymentChoice isEqualToString:@"Debit"]) {
        // Handle Debit payment.
    }

}

@end
