//
//  QuickServeCollectionViewController.m
//  Login
//
//  Created by Developer on 3/25/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "QuickServeCollectionViewController.h"
#import "QuickServeCollectionViewCell.h"
#import "ItemProperties.h"
#import "ItemColorProperties.h"

@interface QuickServeCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>


@end

@implementation QuickServeCollectionViewController
@synthesize vMenuItemNames;
@synthesize selectedItemIndex;
@synthesize isActualItems;


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
    
    // test on itemproperties
    NSString *itemTestid = [[NSString alloc] initWithFormat:@"%d", 74];
    ItemProperties *itemProperties = [[ItemProperties alloc] initWithItemId:itemTestid];
    
    if ([[self pushedView] isEqualToString:@"mainClassItems"]) {
        /* 
         The if statement always executes first because of the segue from HomeViewController.
         Since it always executes first, class names are the first thing to be pulled from the database.
         */
        self.vMenuItemNames = [[self database] getClassNames];
    } else if ([[self pushedView] isEqualToString:@"subclassItems"]) {
        self.isActualItems = FALSE; // vMenuItemNames should contain subclass names so they aren't actual items yet
    } else {
        self.isActualItems = TRUE; // vMenuItemNames are items
    }
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
    //NSLog(@"%d", [[self vMenuItemNames] count]);
    return [[self vMenuItemNames] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    /* The collection view cells get filled with names of classes like 'LUNCH'. */
    static NSString *CellIdentifier = @"quickServeCell";
    QuickServeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    int row = [indexPath row];
    NSString * menuItemName = [[self vMenuItemNames] objectAtIndex:row];
    cell.itemLabel.text = menuItemName;
    //NSLog(cell.classNameLabel.text);
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", [[self vMenuItemNames] count]);
}



/*
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
} */


/* Will continually segue to another view using the same class, the data that is sent depends on what it is seguing to. */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"subclassMenuSegue"]) {
        QuickServeCollectionViewController *destViewController = segue.destinationViewController;
        
        /*
         Only one class/subclass/item is selected at a time. To get the index path, obtain the array and 
         grab the object at index zero which should be the only object in the array.
         */
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        destViewController.class_name = [[self vMenuItemNames] objectAtIndex:indexPath.row];
        destViewController.database = [self database];
        
        /*
         Check if there are any subclass names to be pulled by querying the database for subclass names.
         If the class picked doesn't have a subclass, then it'll return a count of 1.
         At that point, just fill the vMenuItemNames array with Item Names, given the Class Name.
         Else if it doesn't return a count of 1, pull the Subclass names given the Class Name.
         */
        
        if ([[[self database] getSubClassNameGivenClassName:destViewController.class_name] count] == 1) {
            destViewController.pushedView = @""; // will go towards the else part of the loop in viewdidload
            destViewController.vMenuItemNames = [[self database] getItemNamesGivenClassName:destViewController.class_name];
        } else {
            destViewController.pushedView = @"subclassItems";
            destViewController.vMenuItemNames = [[self database] getSubClassNameGivenClassName:destViewController.class_name];
        }
        
    }
    
    if ([segue.identifier isEqualToString:@"actualItemSegue"]) {
        QuickServeCollectionViewController *destViewController = segue.destinationViewController;
        /*
         If vMenuItems are actual items, there isn't a need to change anything between segues so set the values to be the same.
         Else, fill the vMenuItems array with actual items by supplying the Subclass name.
         */
        if(self.isActualItems) {
            destViewController.pushedView = [self pushedView]; // value of pushedView at this point: @""
            destViewController.class_name = [self class_name];
            destViewController.vMenuItemNames = [self vMenuItemNames];
        } else {
            NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
            destViewController.pushedView = @"";
            destViewController.class_name = [[self vMenuItemNames] objectAtIndex:indexPath.row];
            destViewController.vMenuItemNames = [[self database] getItemsGiveSubClassName:destViewController.class_name];
        }
    }
    
}


- (void)dealloc
{
    [super dealloc];
}
@end