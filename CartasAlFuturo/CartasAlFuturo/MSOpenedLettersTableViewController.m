//
//  MSOpenedLettersTableViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 15/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSOpenedLettersTableViewController.h"
#import "Letter+myAPI.h"
#import "MSOpenedTableViewCell.h"
#import "MSCreateLetterViewController.h"



#import "MSLetterItemProtocol.h"
#import "MSCellDrawerProtocol.h"
@implementation MSOpenedLettersTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureFetchResultController) name:UIDocumentStateChangedNotification object:self.manageDocument];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureFetchResultController];
}

#pragma mark -
#pragma mark - Data source methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id<MSLetterItemProtocol> item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell *cell = [item.cellDrawer cellForTableView:tableView atIndexPath:indexPath];
    
    [item.cellDrawer drawCell:cell withItem:item];
    
    return cell;
}

#pragma mark -
#pragma mark - Private methods

-(void)configureFetchResultController{
    NSFetchedResultsController *results = [Letter openedLettersToShowInContext:self.manageDocument.managedObjectContext];
    self.fetchedResultsController = results;
}

- (IBAction)addOpenedLetter:(id)sender {
    [self.manageDocument.managedObjectContext.undoManager beginUndoGrouping];
    Letter *newLetter = [Letter createLetterInContext:self.manageDocument.managedObjectContext];
    newLetter.letterOpenDate = [NSDate dateWithTimeIntervalSinceNow:[self randomFloatBetween:0 and:100000000.00]];
    newLetter.letterStatus = [NSNumber numberWithInteger:MSRead];
    int random = arc4random()%100;
    NSLog(@"Soy %d",random);
    newLetter.letterTitle = [NSString stringWithFormat:@"Soy %d",random];
    [self.manageDocument.managedObjectContext.undoManager endUndoGrouping];
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (editingStyle) {
        case UITableViewCellEditingStyleNone:
            break;
        case UITableViewCellEditingStyleDelete:
            [self.manageDocument.managedObjectContext.undoManager beginUndoGrouping];
            [self.manageDocument.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            [self.manageDocument.managedObjectContext.undoManager endUndoGrouping];
            break;
        case UITableViewCellEditingStyleInsert:
            break;
        default:
            break;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
#warning Codigo duplicado en mis dos controladores principales - Marcos, ¿que coño haces?
    MSCreateLetterViewController *nextView = (MSCreateLetterViewController *)[(UINavigationController*)[segue destinationViewController] topViewController];
    nextView.manageDocument = self.manageDocument;
}

@end