//
//  MSOpenedLetterDrawer.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 19/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSOpenedLetterDrawer.h"
#import "MSOpenedTableViewCell.h"
#import "Letter.h"

@implementation MSOpenedLetterDrawer

-(UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MSOpenedTableViewCell class]) forIndexPath:indexPath];
}

-(void)drawCell:(MSOpenedTableViewCell *)cell withItem:(Letter*)item{
    
    cell.openedLetterStatus.text = item.letterStatus.description;
    cell.openedLetterDate.text = item.letterOpenDate.description;
    cell.openedLetterTitle.text = item.letterTitle;
    
}

@end