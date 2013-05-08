//
//  ModPickerViewController.m
//  Point IPad
//
//  Created by Developer on 5/8/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "ModPickerViewController.h"

@interface ModPickerViewController ()

@end

@implementation ModPickerViewController
@synthesize modNames;

- (id)initWithStyle:(UITableViewStyle)style 
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    //Make row selections persist.
    self.clearsSelectionOnViewWillAppear = NO;
    
    //Calculate how tall the view should be by multiplying the individual row height by the total number of rows.
    NSInteger rowsCount = [modNames count];
    NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSInteger totalRowsHeight = rowsCount * singleRowHeight;
    
    //Calculate how wide the view should be by finding how wide each string is expected to be
    CGFloat largestLabelWidth = 0;
    
    for( NSString *modName in modNames) {
        //Checks size of text using the default font for UITableViewCell's textLabel.
        CGSize labelSize = [modName sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
        if (labelSize.width > largestLabelWidth) {
            largestLabelWidth = labelSize.width;
        }
    }
    
    //Add a little padding to the width
    CGFloat popoverWidth = largestLabelWidth + 100;
    
    //Set the property to tell the popover container how big this view will be.
    self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style withDB:(DatabaseAccess *)db usingItem:(NSNumber *)itemId
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    modNames = [[NSMutableArray alloc] init];
    [modNames addObject:@"Hotness"];
    [modNames addObject:@"Quantity"];
    [modNames addObject:@"Extras"];
    [modNames addObject:@"Options"];
    
    //***************** REFERENCE ***********************//
    // modNames = [db hotnessOptionsModifierOne:itemId];
    // CAN GET MOD NAMES USING [db modifireoptionsasdfasdf: usingItemId
    // mods = [[hotnessOption objectAtIndex:0] componentsSeparatedByString:@":"];
    //***************** THIS LINE ***********************//
    
    //Register the identifier
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    //Make row selections persist.
    self.clearsSelectionOnViewWillAppear = NO;
    
    //Calculate how tall the view should be by multiplying the individual row height by the total number of rows.
    NSInteger rowsCount = [modNames count];
    NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSInteger totalRowsHeight = rowsCount * singleRowHeight;
    
    //Calculate how wide the view should be by finding how wide each string is expected to be
    CGFloat largestLabelWidth = 0;
    
    for( NSString *modName in modNames) {
        //Checks size of text using the default font for UITableViewCell's textLabel.
        CGSize labelSize = [modName sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
        if (labelSize.width > largestLabelWidth) {
            largestLabelWidth = labelSize.width;
        }
    }
    
    //Add a little padding to the width
    CGFloat popoverWidth = largestLabelWidth + 100;
    
    //Set the property to tell the popover container how big this view will be.
    self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [modNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [modNames objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

/*
 #pragma mark - Table view delegate
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 NSString *selectedColorName = [_colorNames objectAtIndex:indexPath.row];
 
 //Create a variable to hold the color, making its default color
 //something annoying and obvious so you can see if you've missed
 //a case here.
 UIColor *color = [UIColor orangeColor];
 
 //Set the color object based on the selected color name.
 if ([selectedColorName isEqualToString:@"Red"]) {
 color = [UIColor redColor];
 } else if ([selectedColorName isEqualToString:@"Green"]){
 color = [UIColor greenColor];
 } else if ([selectedColorName isEqualToString:@"Blue"]) {
 color = [UIColor blueColor];
 }
 
 //Notify the delegate if it exists.
 if (_delegate != nil) {
 [_delegate selectedColor:color];
 }
 }
 */

@end
