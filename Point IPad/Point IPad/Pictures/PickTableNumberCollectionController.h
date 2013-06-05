//
//  PickTableNumberCollectionController.h
//  Point IPad
//
//  Created by Developer on 6/3/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"

@interface PickTableNumberCollectionController : UICollectionViewController
@property (strong, nonatomic) DatabaseAccess *database; // database query
@property (strong, nonatomic) NSString *pushedView;
@property (nonatomic, assign, getter=isActualItems) BOOL isActualItems;
@property (nonatomic, strong) NSMutableArray *listOfTables;
@property (nonatomic, strong) NSMutableArray * currentMenuItems;
@end
