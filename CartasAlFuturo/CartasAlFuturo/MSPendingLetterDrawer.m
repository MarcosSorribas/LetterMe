//
//  MSPendingLetterDrawer.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 19/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSPendingLetterDrawer.h"
#import "Letter.h"
#import "MSPendingLetterTableViewCell.h"
#import "NSDate+CustomizableDate.h"
#import "NSString+Styles.h"

@implementation MSPendingLetterDrawer

-(UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MSPendingLetterTableViewCell class]) forIndexPath:indexPath];
}

-(void)drawCell:(MSPendingLetterTableViewCell *)cell withItem:(Letter*)letter{
    NSString *countdown = [self calculateCountdown:letter];
    cell.countdownLabel.text = countdown;
    if (letter.letterTitle) {
        cell.titleLabel.attributedText = [letter.letterTitle addKernStyle:@1.5];
        cell.backgroundColor = [UIColor clearColor];
    }
}

-(NSString*)calculateCountdown:(Letter *)letter{
    NSInteger days = [NSDate daysBetweenDate:letter.letterOpenDate andDate:[NSDate date]];
    if (days == 0) {
        return [NSString stringWithFormat:NSLocalizedString(@"calculateCountdown_hours", nil)];
    }else{
        if (days == 1) {
            return [NSString stringWithFormat:NSLocalizedString(@"calculateCountdown_tomorrow", nil)];
        }else{
            return [NSString stringWithFormat:NSLocalizedString(@"calculateCountdown_days", nil),days];
        }
    }
}
@end