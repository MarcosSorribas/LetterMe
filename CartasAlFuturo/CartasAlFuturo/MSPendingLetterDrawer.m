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

@implementation MSPendingLetterDrawer

-(UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MSPendingLetterTableViewCell class]) forIndexPath:indexPath];
}

-(void)drawCell:(MSPendingLetterTableViewCell *)cell withItem:(Letter*)item{
    
    NSString *countdown = [self calculateCountdown:item];
    cell.countdownLabel.text = countdown;
    
    if (item.letterTitle) {
        NSMutableAttributedString *titleAttributed = [[NSMutableAttributedString alloc] initWithString:[item.letterTitle uppercaseString]];
        
        [titleAttributed addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:2.0] range:NSMakeRange(0, item.letterTitle.length)];
        
        cell.titleLabel.attributedText = titleAttributed;
    }
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    cell.blackView.layer.cornerRadius = 15;
    
//    CALayer *layer = [CALayer layer];
//    layer.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.45].CGColor;
//    layer.frame = CGRectInset(cell.bounds, 10, 10);
//    layer.cornerRadius = 15;
//    [cell.layer insertSublayer:layer above:0];

  
    
}

-(NSString*)calculateCountdown:(Letter *)letter{
    NSInteger days = [letter.letterOpenDate countdownInDays];
    if (days == 0) {
        return [NSString stringWithFormat:@"Solo quedan unas horas."];
    }else{
        if (days == 1) {
            return [NSString stringWithFormat:@"Mañana podrás abrirla."];
        }else{
            return [NSString stringWithFormat:@"%ld días restantes.",days];
        }
    }
}
@end