//
//  QuickServeCollectionViewController.h
//  Login
//
//  Created by Developer on 3/25/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"

@interface QuickServeCollectionViewController : UICollectionViewController
@property (strong, nonatomic) DatabaseAccess *database;
@property (strong, nonatomic) NSNumber *selectedItemIndex;
@property (nonatomic, strong) NSMutableArray * vMenuItemNames;
@property (retain, nonatomic) IBOutlet UICollectionView *classMenuItemsView;


@property (strong, nonatomic) NSString *pushedView;
@property (strong, nonatomic) NSString *class_name; // either class or sub class
@property (nonatomic, assign, getter=isActualItems) BOOL isActualItems;
@end
