//
//  Employee.h
//  Login
//
//  Created by Developer on 3/12/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject
@property (nonatomic, strong) NSString *fname;
@property (nonatomic, strong) NSString *lname;
@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *empId;
@property (nonatomic, strong) NSString *clockInTime;
@end
