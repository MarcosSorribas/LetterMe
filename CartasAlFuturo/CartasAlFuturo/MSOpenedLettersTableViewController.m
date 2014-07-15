//
//  MSOpenedLettersTableViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 15/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSOpenedLettersTableViewController.h"
#import "Letter+myAPI.h"

@interface MSOpenedLettersTableViewController ()

@end

@implementation MSOpenedLettersTableViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //Configure fetch
    NSFetchedResultsController *results = [Letter openedLettersToShowInContext:self.manageDocument.managedObjectContext];
    self.fetchedResultsController = results;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    Letter *letter = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Pintar la carta
    
    return cell;
}

@end
