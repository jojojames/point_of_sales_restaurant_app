//
//  PasswordViewController.h
//  Login
//
//  Created by Developer on 3/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@interface PasswordViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) Employee *currentEmployee; // the current employee chosen
@property (nonatomic, assign, getter=goingIn) BOOL goingIn; // logging/clocking in || logging/clocking out
@property (strong, nonatomic) NSString *goingInOrOut;
@end
