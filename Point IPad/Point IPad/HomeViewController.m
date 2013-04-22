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

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (retain, nonatomic) IBOutlet HomeCollection *homeCollectionView;
@property (retain, nonatomic) IBOutlet UIView *HomeTopView;

@end

@implementation HomeViewController
@synthesize homeOptions;

- (DatabaseAccess *)database
{
    if (!_database) _database = [[DatabaseAccess alloc] init];
    return _database;
}

- (void)viewDidLoad
{
    /*
     Set a delegate and datasource for whatever view.
     */
    self.homeCollectionView.delegate = self;
    self.homeCollectionView.dataSource = self;
    
    // Set the options with this line
    [self setHomeOptions:[[NSArray alloc] initWithObjects:@"Login", @"Quick Serve", @"Blah1", @"blah@", nil]];
    self.clockedInEmployees = [[NSMutableArray alloc] init];
    self.loggedInEmployee = [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    cell.optionLabel.text = [homeOptions objectAtIndex:indexPath.row];
    //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    NSLog(@"%@", cell.optionLabel.text);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *pickedHomeOption = [homeOptions objectAtIndex:indexPath.row];
    if ([pickedHomeOption isEqualToString:@"Login"]) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
    // add more like quickserve in here
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loginSegue"]) {
        LoginTableViewController *destViewController = segue.destinationViewController;
        destViewController.allEmployees = [[self database] returnEmployees];
        destViewController.clockedInEmployees = [self clockedInEmployees];
        destViewController.loggedInEmployee = [self loggedInEmployee];
    }
}

- (void)printAllEmployees:(NSMutableArray *)array {
    for (int i=0; i<[array count]; i++) {
        NSLog(@"%@", [[array objectAtIndex:i] fullname]);
    }
}

- (void)dealloc {
    [_homeCollectionView release];
    [_HomeTopView release];
    [super dealloc];
}
@end
