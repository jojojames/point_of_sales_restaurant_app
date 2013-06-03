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
    [self setHomeOptions:[[NSArray alloc] initWithObjects:@"Login", @"Quick Serve", @"Settings", @"Alpha", @"Beta", @"Gamma", @"Delta", @"Epsilon", @"Zeta", @"Eta", @"Theta", @"Iota", @"Kappa", @"Lambda", @"Mu", @"Nu", @"Xi", @"Omicron", @"Pi", @"Rho", @"Sigma", @"Tau", @"Upsilon", @"Phi", @"Chi", @"Psi", @"Omega", nil]];
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
    //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Frame.png"]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.optionLabel.text = [homeOptions objectAtIndex:indexPath.row];
    [cell changeBorders:cell.frame];
    
    //NSLog(@"%@", cell.optionLabel.text);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *pickedHomeOption = [homeOptions objectAtIndex:indexPath.row];
    if ([pickedHomeOption isEqualToString:@"Login"]) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
    
    if ([pickedHomeOption isEqualToString:@"Quick Serve"]) {
        [self performSegueWithIdentifier:@"quickServe" sender:self];
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
    
    if ([segue.identifier isEqualToString:@"quickServe"]) {
        QuickServeController *destViewController = segue.destinationViewController;
        destViewController.database = [self database];
        destViewController.pushedView = @"mainClassItems";
        destViewController.isActualItems = FALSE; // items don't show immediately, only class names
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
