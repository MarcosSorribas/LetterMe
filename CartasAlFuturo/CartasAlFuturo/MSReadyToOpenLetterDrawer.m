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
#import "NSString+Styles.h"

@implementation MSReadyToOpenLetterDrawer

-(UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MSReadyToOpenTableViewCell class]) forIndexPath:indexPath];
}

-(void)drawCell:(MSReadyToOpenTableViewCell *)cell withItem:(Letter*)letter{
    cell.titleLetterLabel.attributedText = [letter.letterTitle addKernStyle:@1.5];
    cell.backgroundColor = [UIColor clearColor];
    
    [cell.titleLetterLabel setAlpha:1.0];

    [UIView animateWithDuration:0.9
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationCurveEaseIn
                     animations:^(void){
                         [cell.titleLetterLabel setAlpha:0.0];
                     }
                     completion:^(BOOL finished){
                            NSLog(@"Hurray. Label fadedIn & fadedOut");
                     }];
    
}

@end