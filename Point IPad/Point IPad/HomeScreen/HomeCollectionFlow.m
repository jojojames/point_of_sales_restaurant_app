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
    
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return self;
}

@end
