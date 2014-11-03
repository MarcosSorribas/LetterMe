//
//  MSOpenedLettersTableViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 15/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSOpenedLettersTableViewController.h"
#import "Letter+myAPI.h"


#import "MSLetterItemProtocol.h"
#import "MSCellDrawerProtocol.h"

@implementation MSOpenedLettersTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [super configureNavigationBar:NSLocalizedString(@"Read_TableViewTitle", nil)];
    [super configureBackground];
    [self configureFetchResultController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureFetchResultController) name:UIDocumentStateChangedNotification object:self.manageDocument];
}


#pragma mark -
#pragma mark - Data source methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id<MSLetterItemProtocol> item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell *cell = [item.cellDrawer cellForTableView:tableView atIndexPath:indexPath];
    
    [item.cellDrawer drawCell:cell withItem:item];
    
    return cell;
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

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Delete_letter_button", nil);
}

#pragma mark -
#pragma mark - Private methods

-(void)configureFetchResultController{
    NSFetchedResultsController *results = [Letter openedLettersToShowInContext:self.manageDocument.managedObjectContext];
    self.fetchedResultsController = results;
}

#pragma mark -
#pragma mark - Navegation methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
}

@end