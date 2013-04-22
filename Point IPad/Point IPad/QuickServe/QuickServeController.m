//
//  QuickServeController.m
//  Point IPad
//
//  Created by Developer on 4/22/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "QuickServeController.h"
#import "QuickServeCell.h"
#import "ItemProperties.h"
#import "ItemColorProperties.h"

@interface QuickServeController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (retain, nonatomic) IBOutlet UITapGestureRecognizer *oneFingerOneTap;

@end

@implementation QuickServeController
@synthesize vMenuItemNames;
@synthesize selectedItemIndex;
@synthesize isActualItems;
@synthesize isSubclass;

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
    UITapGestureRecognizer *oneFingerOneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerOneTap:)];
    [oneFingerOneTap setNumberOfTapsRequired:1];
    [oneFingerOneTap setNumberOfTouchesRequired:1];
    [[self collectionView] addGestureRecognizer:oneFingerOneTap];
    [self setIsSubclass:FALSE];
    [self setIsActualItems:FALSE];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // test on itemproperties
    NSString *itemTestid = [[NSString alloc] initWithFormat:@"%d", 74];
    ItemProperties *itemProperties = [[ItemProperties alloc] initWithItemId:itemTestid];
    
    // The vMenuItemNames are always Class Names first.
    self.vMenuItemNames = [[self database] getClassNames];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)oneFingerOneTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:[self view]];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    NSString *classNameOfSelected = [[self vMenuItemNames] objectAtIndex:indexPath.row];
    
    
    /*
     When the QuickServe is first selected, the collection view only displays Class Names.
     if (subclass == false) AND (actualItems == false) do
     After clicking a Class, check to see if that class has a Subclass.
     To check if a Class has a Subclass, query the database and if the array returned is a 1, it means it doesn't have a subclass.
     If the selected Class doesn't have a subclass, go ahead and display the items.
     If it does have a Subclass, set the subclass variable to True and display Subclasses.
     else
     The else statement takes care of when Subclass is true, but actualItems aren't. It displays the Items
     by querying the database using the Subclass name as a parameter instead of a Classname. At this point, set the actualItems to true.
     Then refresh the view for the changes to take effect.
     */
    
    if (![self isSubclass] && ![self isActualItems]) {
        if ([[[self database] getSubClassNameGivenClassName:classNameOfSelected] count] == 1) {
            [self setIsActualItems:TRUE];
            [self setIsSubclass:TRUE];
            [self setVMenuItemNames:[[self database] getItemNamesGivenClassName:classNameOfSelected]];
        } else {
            [self setIsSubclass:TRUE];
            [self setVMenuItemNames:[[self database] getSubClassNameGivenClassName:classNameOfSelected]];
        }
    } else if ([self isSubclass] && ![self isActualItems]) {
        [self setVMenuItemNames:[[self database] getItemsGiveSubClassName:classNameOfSelected]];
        [self setIsActualItems:TRUE];
    }
    [[self collectionView] reloadData];
    
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self vMenuItemNames] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    /* The collection view cells get filled with names of classes like 'LUNCH'. */
    static NSString *CellIdentifier = @"quickServe";
    QuickServeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)dealloc
{
    [super dealloc];
}


@end
