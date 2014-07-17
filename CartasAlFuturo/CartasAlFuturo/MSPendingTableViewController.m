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
    [self configureFetchResultController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureFetchResultController) name:UIDocumentStateChangedNotification object:self.manageDocument];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
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
    [self.manageDocument.managedObjectContext.undoManager beginUndoGrouping];
    Letter *newLetter = [Letter createLetterInContext:self.manageDocument.managedObjectContext];
    newLetter.letterOpenDate = [NSDate dateWithTimeIntervalSinceNow:[self randomFloatBetween:0 and:100000000.00]];
    int random = arc4random()%100;
    NSLog(@"Soy %d",random);
    newLetter.letterTitle = [NSString stringWithFormat:@"Soy %d",random];
    [self.manageDocument.managedObjectContext.undoManager endUndoGrouping];
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

#pragma mark -
#pragma mark - Private methods

-(void)configureFetchResultController{
    NSFetchedResultsController *results = [Letter pendingLettersToShowInContext:self.manageDocument.managedObjectContext];
    self.fetchedResultsController = results;
}

-(void)setUpNextController:(UITableViewController*)myController{
    //Oculto la tabBar
    myController.hidesBottomBarWhenPushed = YES;
    //Cambio el titulo del boton back
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:nil
                                                                     action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
}

#pragma mark -
#pragma mark - Navigation methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
#warning Codigo duplicado en mis dos controladores principales - Marcos, ¿que coño haces?
    [self setUpNextController:[segue destinationViewController]];
}

@end
