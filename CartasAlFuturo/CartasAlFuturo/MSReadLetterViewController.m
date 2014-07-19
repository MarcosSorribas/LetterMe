//
//  MSReadLetterViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSReadLetterViewController.h"
#import "LetterStatusEnum.h"
#import "NSNumber+MSStatusLetter.h"

@interface MSReadLetterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *sendDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentLabel;

@end

@implementation MSReadLetterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadLetter];
}

-(void)loadLetter{
    self.sendDateLabel.text = [self.letter.letterSendDate description];
    self.contentLabel.text = self.letter.letterContent;
    self.navigationItem.title = self.letter.letterTitle;
}

-(void)setLetter:(Letter *)letter{
    _letter = letter;
    if ([_letter.letterStatus statusValue] == MSReadyToOpen) {
        _letter.letterStatus = [NSNumber numberWithInt:MSRead];
    }
}
@end