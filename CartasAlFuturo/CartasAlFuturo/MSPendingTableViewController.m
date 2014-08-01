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


#import "MSReadyToOpenTableViewCell.h"
#import "UIView+Animations.h"
#import "MSCreateLetterViewController.h"

@interface MSPendingTableViewController ()
@property (nonatomic,strong) UIView *emptyView;
@end

@implementation MSPendingTableViewController

#pragma mark -
#pragma mark - Constans

NSString * const kPendingControllerTitle = @"Pendientes";

#pragma mark -
#pragma mark - Views Apperance

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self initialReadyToOpenAnimation];
    [self configureEmptyView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkNewLetterStatus];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super configureNavigationBar:kPendingControllerTitle];
    [super configureBackground];
    
    [self configureFetchResultController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureFetchResultController) name:UIDocumentStateChangedNotification object:self.manageDocument];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backgroundBack) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

//TODO: Fixed bug -> BackBackground animate lost 
-(void)backgroundBack{
    [self.tableView reloadData];
    [self initialReadyToOpenAnimation];
}

#pragma mark -
#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger items = [super tableView:tableView numberOfRowsInSection:section];
    if (items == 0) {
        [self.view bringSubviewToFront:self.emptyView];
        self.emptyView.hidden = NO;
    }else{
        self.emptyView.hidden = YES;
    }
    return items;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id<MSLetterItemProtocol> letter = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell *cell = [letter.cellDrawer cellForTableView:tableView atIndexPath:indexPath];
    
    [letter.cellDrawer drawCell:cell withItem:letter];
    
    return cell;
    
}

#pragma mark -
#pragma mark - TableViewDelegate


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] shakeAnimate];
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

-(void)initialReadyToOpenAnimation{
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        if ([cell isKindOfClass:[MSReadyToOpenTableViewCell class]]) {
            [(MSReadyToOpenTableViewCell*)cell animate];
        }
    }
}
-(void)configureEmptyView{
    if (!self.emptyView.superview) {
        [self.tableView addSubview:self.emptyView];
    }
}

#pragma mark -
#pragma mark - Navigation methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
}

-(void)createFirstLetter{
    [self performSegueWithIdentifier:@"MSCreateLetterViewController" sender:self];
}

#pragma mark -
#pragma mark - Getters & Setters

-(UIView *)emptyView{
    if (_emptyView == nil) {
        _emptyView = [[[NSBundle mainBundle] loadNibNamed:@"MSEmptyTableViewController" owner:self options:nil] firstObject];
        _emptyView.frame = CGRectMake(self.tableView.bounds.origin.x, self.tableView.bounds.origin.y, self.tableView.bounds.size.width, self.tableView.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-self.navigationController.navigationBar.bounds.size.height);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createFirstLetter)];
        [_emptyView addGestureRecognizer:tap];
    }
    return _emptyView;
}

@end
