//
//  HomeViewController.h
//  Point IPad
//
//  Created by Developer on 4/8/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"
#import "Employee.h"

@interface HomeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) DatabaseAccess *database; // the main database that the whole program draws from
@property (nonatomic, strong) NSArray *homeOptions;
// clocked in employees
@property (nonatomic, strong) NSMutableArray *clockedInEmployees;
@property (nonatomic, strong) NSMutableArray *loggedInEmployee; // only one will be logged in a time
@property (nonatomic, assign, getter=isLoggedIn) BOOL isLoggedIn;


// Dictionary that holds QuickServe controllers by table numbers.
@property (nonatomic, strong) NSMutableDictionary *quickServeDictionary;

// Available table numbers.
@property (nonatomic, strong) NSMutableArray *listOfTables;

@end
