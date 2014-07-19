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
#import "NSDate+CustomizableDate.h"

@implementation MSOpenedLetterDrawer

-(UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MSOpenedTableViewCell class]) forIndexPath:indexPath];
}

-(void)drawCell:(MSOpenedTableViewCell *)cell withItem:(Letter*)item{
    
    cell.sendDateLabel.text = [NSString stringWithFormat:@"Creada el dia %@",[item.letterSendDate dateWithMyFormat]];
    cell.openDateLabel.text = [NSString stringWithFormat:@"Abierta el dia %@",[item.letterOpenDate dateWithMyFormat]];
    
    cell.titleLabel.text = item.letterTitle;
    
}

@end