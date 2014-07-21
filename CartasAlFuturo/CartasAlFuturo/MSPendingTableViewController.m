//
//  MSPendingTableViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSPendingTableViewController.h"
#import "Letter+myAPI.h"

#import "MSMailMan.h"

#import "MSLetterItemProtocol.h"
#import "MSCellDrawerProtocol.h"

@interface MSPendingTableViewController ()
@end

@implementation MSPendingTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkNewLetterStatus];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prueba_background"]];
    
    [self.tableView setBackgroundView:imageView];
    
    [self configureFetchResultController];
    
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
}

-(void)checkNewLetterStatus{
    [MSMailMan checkLettersPreparedAndUpdateThemInContext:self.manageDocument];
}

#pragma mark -
#pragma mark - Navigation methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];    
}
@end