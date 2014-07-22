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

-(void)drawCell:(MSReadyToOpenTableViewCell *)cell withItem:(Letter*)letter{
    
    cell.blackBackgroundView.layer.cornerRadius = 10;
    cell.titleLetterLabel.text = letter.letterTitle;
    cell.backgroundColor = [UIColor clearColor];
}

@end