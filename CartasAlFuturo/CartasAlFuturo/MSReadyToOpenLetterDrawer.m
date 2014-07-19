//
//  MSReadyToOpenLetterDrawer.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 19/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSReadyToOpenLetterDrawer.h"
#import "Letter.h"
#import "MSReadyToOpenTableViewCell.h"

@implementation MSReadyToOpenLetterDrawer

-(UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MSReadyToOpenTableViewCell class]) forIndexPath:indexPath];
}

-(void)drawCell:(MSReadyToOpenTableViewCell *)cell withItem:(Letter*)item{
    
    cell.titelLabel.text = item.letterTitle;
    cell.dateLabel.text = [item.letterOpenDate description];
    cell.statusLabel.text = [item.letterStatus description];
    
}

@end