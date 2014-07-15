//
//  MSOpenedTableViewCell.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 15/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSOpenedTableViewCell.h"

@interface MSOpenedTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *openedLetterStatus;
@property (weak, nonatomic) IBOutlet UILabel *openedLetterTitle;
@property (weak, nonatomic) IBOutlet UILabel *openedLetterDate;

@end

@implementation MSOpenedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLetter:(Letter *)letter{
    _letter = letter;
    self.openedLetterStatus.text = letter.letterStatus.description;
    self.openedLetterDate.text = letter.letterOpenDate.description;
    self.openedLetterTitle.text = letter.letterTitle;
}

@end
