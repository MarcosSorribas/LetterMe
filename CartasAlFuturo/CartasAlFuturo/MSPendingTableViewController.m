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

#pragma mark -
#pragma mark - Constans

NSString * const kControllerTitle = @"Pendientes";

#pragma mark -
#pragma mark - Views Apperance

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkNewLetterStatus];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNavigationBar];
    [self configureBackground];
    
    
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

-(void)configureBackground{
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prueba_background"]];
}

-(void)configureNavigationBar{
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    NSMutableAttributedString *titleWithAtt = [[NSMutableAttributedString alloc] initWithString:kControllerTitle attributes:@{NSKernAttributeName:@2}];
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.textColor = [UIColor colorWithRed:0.845 green:0.708 blue:0.671 alpha:1.000];
    labelView.adjustsFontSizeToFitWidth = YES;
    labelView.attributedText = titleWithAtt;
    self.navigationItem.titleView = labelView;
}
#pragma mark -
#pragma mark - Navigation methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
}
@end