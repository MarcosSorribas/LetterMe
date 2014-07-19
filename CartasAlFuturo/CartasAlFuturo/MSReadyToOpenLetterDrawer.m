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
#import "NSDate+CustomizableDate.h"

@implementation MSReadyToOpenLetterDrawer

-(UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MSReadyToOpenTableViewCell class]) forIndexPath:indexPath];
}

-(void)drawCell:(MSReadyToOpenTableViewCell *)cell withItem:(Letter*)item{
    cell.sendDate.text = [NSString stringWithFormat:@"Creada el %@",[item.letterSendDate dateWithMyFormat]];
    cell.titleLabel.text = item.letterTitle;
}

@end