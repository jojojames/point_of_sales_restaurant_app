//
//  PickTableNumberCollectionController.m
//  Point IPad
//
//  Created by Developer on 6/3/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "PickTableNumberCollectionController.h"
#import "PickTableNumberCollectionCell.h"
#import "QuickServeController.h"
#import "HomeViewController.h"

@interface PickTableNumberCollectionController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, retain) NSNumber *selectedTableNumber;

@end

@implementation PickTableNumberCollectionController
@synthesize pushedView;
@synthesize database;
@synthesize isActualItems;
@synthesize listOfTables;
@synthesize selectedTableNumber;
@synthesize currentMenuItems;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        listOfTables = [[NSMutableArray alloc] init];
        currentMenuItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self listOfTables] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PickTable";
    PickTableNumberCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.itemLabel.text = [listOfTables objectAtIndex:indexPath.row];
    [cell changeBorders:cell.frame];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableNum = [listOfTables objectAtIndex:indexPath.row];
    selectedTableNumber = [NSNumber numberWithInt:[tableNum integerValue]];
    [self performSegueWithIdentifier:@"quickServe" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"quickServe"]) {
        QuickServeController *destViewController = segue.destinationViewController;
        destViewController.database = self.database;
        destViewController.pushedView = self.pushedView;
        destViewController.isActualItems = self.isActualItems;
        destViewController.tableNumber = selectedTableNumber;
        destViewController.currentMenuItems = self.currentMenuItems;
        HomeViewController *hvc = (HomeViewController *) (self.navigationController.viewControllers[0]);
        // Once a table is occupied, add to the Dictionary, using the table number as the key.
        [hvc.quickServeDictionary setObject:destViewController forKey:selectedTableNumber];
        // Once a table is occupied, remove the table from the list of available tables.
        [hvc.listOfTables removeObject:[NSString stringWithFormat:@"%@", selectedTableNumber]];
        
    }
}

@end
