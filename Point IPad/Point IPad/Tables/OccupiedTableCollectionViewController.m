//
//  OccupiedTableCollectionViewController.m
//  Point IPad
//
//  Created by Developer on 6/3/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "OccupiedTableCollectionViewController.h"
#import "OccupiedTableCollectionCell.h"
#import "QuickServeController.h"
#import "HomeViewController.h"

@interface OccupiedTableCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, retain) NSNumber *selectedTableNumber;

@end

@implementation OccupiedTableCollectionViewController
@synthesize database; // database query
@synthesize pushedView;
@synthesize isActualItems;
@synthesize quickServeDictionary;
@synthesize quickServeArrayOfKeys;
@synthesize selectedTableNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        quickServeDictionary = [[NSMutableDictionary alloc] init];
        //quickServeArrayOfKeys = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    quickServeArrayOfKeys = [[NSMutableArray alloc] initWithArray:[quickServeDictionary allKeys]];
    
    //NSLog(@"OBJECT AT %@", [quickServeArrayOfKeys objectAtIndex:0]);
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{

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
    return [[[self quickServeDictionary] allKeys] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"occupiedTable";
    OccupiedTableCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSLog(@"ARRAYKEYS: %@", [quickServeArrayOfKeys objectAtIndex:indexPath.row]);
    cell.optionLabel.text = [NSString stringWithFormat:@"%@", [quickServeArrayOfKeys objectAtIndex:indexPath.row]];
    [cell changeBorders:cell.frame];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableNum = [quickServeArrayOfKeys objectAtIndex:indexPath.row];
    selectedTableNumber = [NSNumber numberWithInt:[tableNum integerValue]];
    [self performSegueWithIdentifier:@"quickServe" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    HomeViewController *hvc = (HomeViewController *) (self.navigationController.viewControllers[0]);
    QuickServeController *occupiedQuickServeController = [hvc.quickServeDictionary objectForKey:selectedTableNumber] ;
    
    if ([segue.identifier isEqualToString:@"quickServe"]) {
        QuickServeController *destViewController = segue.destinationViewController;
        destViewController.database = occupiedQuickServeController.database;
        destViewController.order = occupiedQuickServeController.order;
        destViewController.selectedItemId = occupiedQuickServeController.selectedItemId;
        destViewController.pushedView = occupiedQuickServeController.pushedView;
        destViewController.nameOfSelected = occupiedQuickServeController.nameOfSelected;
        destViewController.stackOfMenus = occupiedQuickServeController.stackOfMenus;
        destViewController.currentMenuItems = occupiedQuickServeController.currentMenuItems;
        destViewController.isActualItems = occupiedQuickServeController.isActualItems;
        destViewController.isSubclass = occupiedQuickServeController.isSubclass;
        destViewController.stackOfIsActualItemBools = occupiedQuickServeController.stackOfIsActualItemBools;
        destViewController.stackOfIsSubclassBools = occupiedQuickServeController.stackOfIsSubclassBools;
        destViewController.classNameForDatabase = occupiedQuickServeController.classNameForDatabase;
        destViewController.subclassNameForDatabase = occupiedQuickServeController.subclassNameForDatabase;
        destViewController.selectedItemId = occupiedQuickServeController.selectedItemId;
        destViewController.taxNameChanged = occupiedQuickServeController.taxNameChanged;
        destViewController.tableNumber = occupiedQuickServeController.tableNumber;
        destViewController.firstTaxNameLabel.text = destViewController.firstTaxNameLabel.text;
        destViewController.secondTaxNameLabel.text = destViewController.secondTaxNameLabel.text;
        
    }
}

@end
