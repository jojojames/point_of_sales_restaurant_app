//
//  HomeViewController.m
//  Point IPad
//
//  Created by Developer on 4/8/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollection.h"
#import "HomeCollectionCell.h"
#import "LoginTableViewController.h"
#import "QuickServeController.h"
#import "HomeCollectionFlow.h"
#import "PickTableNumberCollectionController.h"
#import "OccupiedTableCollectionViewController.h"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (retain, nonatomic) IBOutlet HomeCollection *homeCollectionView;
@property (retain, nonatomic) IBOutlet UIView *HomeTopView;
@property (strong, nonatomic) HomeCollectionFlow *flowLayout;
@end

@implementation HomeViewController
@synthesize homeOptions;
@synthesize homeCollectionView;
@synthesize HomeTopView;
@synthesize quickServeDictionary;
@synthesize listOfTables;


- (DatabaseAccess *)database
{
    if (!_database) _database = [[DatabaseAccess alloc] init];
    return _database;
}

- (void)viewDidLoad
{
    
    // Testing setting an image.
    self.HomeTopView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background2.png"]];
    
    // Set the layout
    self.flowLayout = [[HomeCollectionFlow alloc] init];
    // init the collection view
    self.homeCollectionView = [[HomeCollection alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    
    // Initialize the Dictionary that holds QuickServe controllers.
    quickServeDictionary = [[NSMutableDictionary alloc] init];
    
    listOfTables = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    
    // Set datasource and delegate
    homeCollectionView.delegate = self;
    homeCollectionView.dataSource = self;
    
    // Set the options with this line
    [self setHomeOptions:[[NSArray alloc] initWithObjects:@"Login", @"Quick Serve", @"Pick Table", @"Settings", @"Tables", nil]];
    self.clockedInEmployees = [[NSMutableArray alloc] init];
    self.loggedInEmployee = [[NSMutableArray alloc] init];
    
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [homeOptions count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"homeOptions";
    HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.optionLabel.text = [homeOptions objectAtIndex:indexPath.row];
    [cell changeBorders:cell.frame];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *pickedHomeOption = [homeOptions objectAtIndex:indexPath.row];
    if ([pickedHomeOption isEqualToString:@"Login"]) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
    
    if ([pickedHomeOption isEqualToString:@"Pick Table"]) {
        //[self performSegueWithIdentifier:@"quickServe" sender:self];
        [self performSegueWithIdentifier:@"pickTableQuickServe" sender:self];
    }
    
    if ([pickedHomeOption isEqualToString:@"Quick Serve"]) {
        [self performSegueWithIdentifier:@"onlyQuickServe" sender:self];
    }
    
    if ([pickedHomeOption isEqualToString:@"Tables"]) {
        [self performSegueWithIdentifier:@"selectedOccupiedTable" sender:self];
    }
    
    // add more like quickserve in here
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loginSegue"]) {
        LoginTableViewController *destViewController = segue.destinationViewController;
        destViewController.allEmployees = [[self database] employeesFromDatabase];
        destViewController.clockedInEmployees = [self clockedInEmployees];
        destViewController.loggedInEmployee = [self loggedInEmployee];
    }
    
    if ([segue.identifier isEqualToString:@"pickTableQuickServe"]) {
        PickTableNumberCollectionController *destViewController = segue.destinationViewController;
        // These variables aren't important to PickTableNumberCollectionController.
        // PickTableNumberCollectionController sends these variables to the next view QuickServeController.
        destViewController.database = [self database];
        destViewController.pushedView = @"mainClassItems";
        destViewController.currentMenuItems = [[self database] classNames];
        
        destViewController.isActualItems = NO; // items don't show immediately, only class names
        // This array contains the list of tables that are currently available to seating.
        destViewController.listOfTables = self.listOfTables;
    }
    
    if ([segue.identifier isEqualToString:@"selectedOccupiedTable"]) {
        OccupiedTableCollectionViewController *destViewController = segue.destinationViewController;
        // This array contains the list of tables that are currently available to seating.
        destViewController.quickServeDictionary = self.quickServeDictionary;
    }
    
    if ([segue.identifier isEqualToString:@"onlyQuickServe"]) {
        QuickServeController *destViewController = segue.destinationViewController;
        destViewController.database = [self database];
        destViewController.pushedView = @"mainClassItems";
        destViewController.currentMenuItems = [[self database] classNames];
        destViewController.isActualItems = NO; // items don't show immediately, only class names
    }
}

- (void)printAllEmployees:(NSMutableArray *)array
{
    for (int i=0; i<[array count]; i++) {
        NSLog(@"%@", [[array objectAtIndex:i] fullname]);
    }
}

- (void)dealloc
{
    [homeCollectionView release];
    [HomeTopView release];
    [super dealloc];
}
@end
