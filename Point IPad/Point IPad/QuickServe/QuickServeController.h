//
//  QuickServeController.h
//  Point IPad
//
//  Created by Developer on 4/22/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"

@interface QuickServeController : UICollectionViewController
@property (strong, nonatomic) DatabaseAccess *database;
@property (strong, nonatomic) NSNumber *selectedItemIndex;
@property (nonatomic, strong) NSMutableArray * vMenuItemNames;
@property (retain, nonatomic) IBOutlet UICollectionView *classMenuItemsView;


@property (strong, nonatomic) NSString *pushedView;
@property (strong, nonatomic) NSString *class_name; // either class or sub class
@property (nonatomic, assign, getter=isActualItems) BOOL isActualItems;
@property (nonatomic, assign, getter=isSubclass) BOOL isSubclass;



@end
