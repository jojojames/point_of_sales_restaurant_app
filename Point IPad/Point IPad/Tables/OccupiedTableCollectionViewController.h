//
//  OccupiedTableCollectionViewController.h
//  Point IPad
//
//  Created by Developer on 6/3/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"

@interface OccupiedTableCollectionViewController : UICollectionViewController
@property (strong, nonatomic) DatabaseAccess *database; // database query
@property (strong, nonatomic) NSString *pushedView;
@property (nonatomic, assign, getter=isActualItems) BOOL isActualItems;

// Dictionary that holds QuickServe controllers by table numbers.
@property (nonatomic, strong) NSMutableDictionary *quickServeDictionary;


// Contains the keys of quickServeDictionary for display in the collection view.
@property (nonatomic, strong) NSMutableArray *quickServeArrayOfKeys;

@end
