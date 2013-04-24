//
//  HomeCollectionFlow.m
//  Point IPad
//
//  Created by Developer on 4/24/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "HomeCollectionFlow.h"

@implementation HomeCollectionFlow

- (id)init
{
    if (!(self = [super init])) return nil;
    
    //self.itemSize = CGSizeMake(900, 130);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //self.minimumInteritemSpacing = 10.0f;
    //self.minimumLineSpacing = 10.0f;
    return self;
}

@end
