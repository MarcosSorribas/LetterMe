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
@property (nonatomic,strong) CAGradientLayer *gLayer;
@end

@implementation MSPendingTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkNewLetterStatus];
}

-(void)configureBackground{
//    UIColor *firstColor = [UIColor colorWithRed:0.845 green:0.708 blue:0.671 alpha:1.000];
//    UIColor *secondColor = [UIColor colorWithRed:0.625 green:0.444 blue:0.483 alpha:1.000];
//    UIColor *thirdColor = [UIColor colorWithRed:0.225 green:0.206 blue:0.303 alpha:1.000];
//    
//    NSArray *colors = @[(id)firstColor.CGColor,(id)secondColor.CGColor,(id)thirdColor.CGColor];
//    
//    NSArray *locations = @[@0.3,@0.6,@0.95];
//
//    self.gLayer.locations = locations;
//    self.gLayer.colors = colors;
//    
//    self.gLayer.startPoint = CGPointMake(1, 1);
//    self.gLayer.endPoint = CGPointMake(0, 0);
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
//    animation.fromValue = locations;
//    animation.toValue = @[@0.1,@0.5,@0.8];
//    animation.duration = 5;
//    [self.gLayer addAnimation:animation forKey:@"Animation"];
    
    //UIView *view = [[UIView alloc] initWithFrame:self.tableView.frame];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prueba_background"]];
    //[view.layer insertSublayer:self.gLayer above:0];
    
    
//    self.gLayer.frame = self.tableView.bounds;
//    [self.tableView.layer addSublayer:self.gLayer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

#pragma mark -
#pragma mark - Navigation methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
}

#pragma mark -
#pragma mark - Getters & Setters

-(CAGradientLayer *)gLayer{
    if (!_gLayer) {
        _gLayer = [CAGradientLayer layer];
    }
    return _gLayer;
}
@end