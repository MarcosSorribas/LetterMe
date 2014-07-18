//
//  MSReadyToOpenTableViewCell.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSReadyToOpenTableViewCell.h"

@interface MSReadyToOpenTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
@implementation MSReadyToOpenTableViewCell



-(void)setLetter:(Letter *)letter{
    _letter = letter;
    self.titelLabel.text = _letter.letterTitle;
    self.dateLabel.text = [_letter.letterOpenDate description];
    self.statusLabel.text = [_letter.letterStatus description];
}

@end