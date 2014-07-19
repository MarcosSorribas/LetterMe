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
#import "MSCreateLetterViewController.h"
#import "MSReadyToOpenTableViewCell.h"
#import "MSMailMan.h"
#import "MSFirstTimeReadLetterViewController.h"




#import "MSLetterItemProtocol.h"
#import "MSCellDrawerProtocol.h"

@implementation MSPendingTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureFetchResultController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureFetchResultController) name:UIDocumentStateChangedNotification object:self.manageDocument];
}

#pragma mark -
#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id<MSLetterItemProtocol> item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell *cell = [item.cellDrawer cellForTableView:tableView atIndexPath:indexPath];
    
    [item.cellDrawer drawCell:cell withItem:item];
    
    return cell;
    
}

#pragma mark -
#pragma mark - TableViewDelegate

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

    return indexPath;
}

#pragma mark -
#pragma mark - Private methods

-(void)configureFetchResultController{
    NSFetchedResultsController *results = [Letter pendingLettersToShowInContext:self.manageDocument.managedObjectContext];
    self.fetchedResultsController = results;
    [MSMailMan checkLettersPreparedAndUpdateThemInContext:self.manageDocument];
}

#pragma mark -
#pragma mark - Navigation methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
#warning Codigo duplicado en mis dos controladores principales - Marcos, ¿que coño haces?
    
    if ([[segue destinationViewController] isKindOfClass:[MSFirstTimeReadLetterViewController class]]) {
        MSFirstTimeReadLetterViewController *controller = [segue destinationViewController];
        controller.letter = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
    }else{
        MSCreateLetterViewController *nextView = (MSCreateLetterViewController *)[(UINavigationController*)[segue destinationViewController] topViewController];
        nextView.manageDocument = self.manageDocument;
    }
}

@end
