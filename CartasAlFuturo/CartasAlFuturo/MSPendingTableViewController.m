//
//  MSPendingTableViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSPendingTableViewController.h"
#import "Letter+myAPI.h"
#import "MSPendingLetterTableViewCell.h"
@implementation MSPendingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //Configure fetch
    NSFetchedResultsController *results = [Letter pendingLettersToShowInContext:self.manageDocument.managedObjectContext];
    self.fetchedResultsController = results;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSPendingLetterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pendingLetterCell" forIndexPath:indexPath];
    Letter *letter = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.letter = letter;
    return cell;
}

#pragma mark -
#pragma mark - IBAction

- (IBAction)addletterButtonTouched:(UIBarButtonItem*)sender {
    Letter *newLetter = [Letter createLetterInContext:self.manageDocument.managedObjectContext];
    newLetter.letterOpenDate = [NSDate dateWithTimeIntervalSinceNow:[self randomFloatBetween:0 and:100000000.00]];
    int random = arc4random()%100;
    NSLog(@"Soy %d",random);
    newLetter.letterTitle = [NSString stringWithFormat:@"Soy %d",random];
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}
@end
