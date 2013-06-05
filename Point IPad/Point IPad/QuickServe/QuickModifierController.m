//
//  QuickModifierController.m
//  Point IPad
//
//  Created by Developer on 5/13/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "QuickModifierController.h"
#import "QuickModifierCell.h"
#import "QuickServeController.h"

@interface QuickModifierController () <UITableViewDataSource, UITableViewDelegate>

@end


@implementation QuickModifierController
@synthesize modsToShow;
@synthesize database;
@synthesize selectedItemId;
@synthesize modOptionKeys;
@synthesize selectedModifier;
@synthesize modifiersToReturnToParent;
@synthesize delegate;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    modsToShow = [[NSMutableArray alloc] init];
    modOptionKeys = [[NSMutableArray alloc] init];
    NSString *optionKey = [[NSString alloc] init];
    
    modifiersToReturnToParent = [[NSMutableArray alloc] init];
    
    NSMutableArray *hotnessMods = [database hotnessOptionsModifierOne:selectedItemId];
    NSMutableArray *quantityMods = [database quantityOptionsModifierTwo:selectedItemId];
    NSMutableArray *extraMods = [database extraOptionsModifierThree:selectedItemId];
    NSMutableArray *optionMods = [database optionOptionsModifierFour:selectedItemId];
    
    if (![[hotnessMods objectAtIndex:0] isEqualToString:@"null"]) {
        //NSLog(@"%@", [hotnessMods objectAtIndex:0]);
        optionKey = @"Modifier 1";
        NSDictionary *hotnessDict = [NSDictionary dictionaryWithObject:[self getDelimitedModNames:hotnessMods] forKey:optionKey];
        [modsToShow addObject:hotnessDict];
        [modOptionKeys addObject:optionKey];
    }
    
    if (![[quantityMods objectAtIndex:0] isEqualToString:@"null"]) {
        //NSLog(@"%@", [quantityMods objectAtIndex:0]);
        optionKey = @"Modifier 2";
        NSDictionary *quantityDict = [NSDictionary dictionaryWithObject:[self getDelimitedModNames:quantityMods] forKey:optionKey];
        [modsToShow addObject:quantityDict];
        [modOptionKeys addObject:optionKey];
    }
    
    if (![[extraMods objectAtIndex:0] isEqualToString:@"null"]) {
        //NSLog(@"%@", [extraMods objectAtIndex:0]);
        optionKey = @"Modifier 3";
        NSDictionary *extrasDict = [NSDictionary dictionaryWithObject:[self getDelimitedModNames:extraMods] forKey:optionKey];
        [modsToShow addObject:extrasDict];
        [modOptionKeys addObject:optionKey];
    }
    
    if (![[optionMods objectAtIndex:0] isEqualToString:@"null"]) {
        //NSLog(@"%@", [optionMods objectAtIndex:0]);
        optionKey = @"Modifier 4";
        NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:[self getDelimitedModNames:optionMods] forKey:optionKey];
        [modsToShow addObject:optionsDict];
        [modOptionKeys addObject:optionKey];
    }
    
    // Create the button to finish the modifier choices.
    //UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelecting:)];
    //self.navigationItem.rightBarButtonItem = anotherButton;
    //[anotherButton release];
    
}

- (NSArray *)getDelimitedModNames:(NSMutableArray *)modArray
{
    // Some mods in the database are in this format M1:M1A:M2, split them up.
    NSArray *modNames = [[modArray objectAtIndex:0] componentsSeparatedByString:@":"];
    //NSLog(@"%@", [modNames objectAtIndex:0]);
    return modNames;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Number of sections in the table view is equal to the amount of available mods to show.
    return [[self modsToShow] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSDictionary *dictionary = [modsToShow objectAtIndex:section];
    NSArray *modNames = [dictionary objectForKey:[modOptionKeys objectAtIndex:section]];
    return [modNames count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //The key for the dictionary is also the header of the group.
    return [modOptionKeys objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"quickModifier";
    QuickModifierCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dictionary = [modsToShow objectAtIndex:indexPath.section];
    NSArray *modNames = [dictionary objectForKey:[modOptionKeys objectAtIndex:indexPath.section]];
    NSString *cellValue = [modNames objectAtIndex:indexPath.row];
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell.accessoryView = switchView;
    cell.textLabel.text = cellValue;
    //[switchView setOn:NO animated:NO];
    [self determineSwitchStartState:switchView withString:cellValue];
    [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [switchView release];
    return cell;
}

- (void)determineSwitchStartState:(UISwitch *)switchView withString:(NSString *)cellValue
{
    if ([[self delegate] modTrueInDictionary:selectedItemId withCellValue:cellValue]) {
        //modifier was turned on to YES before, so set it as ON by default
        [switchView setOn:YES animated:NO];
    } else {
        //modifier was either turned to off or has not been selected yet, so set it to OFF by defaultj
        [switchView setOn:NO animated:NO];
    }
    
}

- (void)switchChanged:(UISwitch *)sender
{
    QuickModifierCell *parentCell = (QuickModifierCell *)sender.superview;
    
    //NSLog( @"The switch is %@", sender.on ? @"ON" : @"OFF" );
    
    // index of cell
    NSString *titleOfCell = parentCell.textLabel.text;
    NSIndexPath *indexPathOfCell = [self.tableView indexPathForCell:parentCell];
    NSInteger sectionIndex = indexPathOfCell.section;
    
    NSString *titleOfSection = [self tableView:self.tableView titleForHeaderInSection:sectionIndex];
    
    NSMutableString *stringModOption = [[NSMutableString alloc] initWithFormat:@"%@:%@:", titleOfSection, titleOfCell];
    
    if(sender.on) {
        [stringModOption appendString:@"1"];
    } else {
        [stringModOption appendString:@"0"];
    }
    
    [self addStringModOptionToArray:stringModOption];
    
    [[self delegate] changedModiferStringArray:modifiersToReturnToParent withItemId:selectedItemId];
}

- (void)addStringModOptionToArray:(NSString *)modStringToAdd
{
    NSArray *selectedModOptionFromStringToAdd = [modStringToAdd componentsSeparatedByString:@":"];
    
    for (int i=0; i<[modifiersToReturnToParent count]; i++) {
        NSString *oneModifierString = [modifiersToReturnToParent objectAtIndex:i];
        
        NSArray *selectedModOptions = [oneModifierString componentsSeparatedByString:@":"];
        if ([[selectedModOptionFromStringToAdd objectAtIndex:0] isEqual:[selectedModOptions objectAtIndex:0]]) {
            if ([[selectedModOptionFromStringToAdd objectAtIndex:1] isEqual:[selectedModOptions objectAtIndex:1]]) {
                [modifiersToReturnToParent replaceObjectAtIndex:i withObject:modStringToAdd];
                [self printArray];
                return;
            }
        }
    }
    [modifiersToReturnToParent addObject:modStringToAdd];
    
}

- (void)printArray
{
    //testing
    NSLog(@"PRINTING ARRAY");
    for (int i=0; i<[modifiersToReturnToParent count]; i++) {
        NSLog(@"%@", [modifiersToReturnToParent objectAtIndex:i]);
    }
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
    NSDictionary *dictionary = [modsToShow objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:[modOptionKeys objectAtIndex:indexPath.section]];
    //NSString *selected = [array objectAtIndex:indexPath.row];
    selectedModifier = [array objectAtIndex:indexPath.row];
    //NSLog(selectedModifier);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
