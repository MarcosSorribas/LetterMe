//
//  MSReadLetterViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSReadLetterViewController.h"
#import "NSNumber+MSStatusLetter.h"
#import "NSDate+CustomizableDate.h"
#import "NSString+Styles.h"

@interface MSReadLetterViewController ()

@property (weak, nonatomic) IBOutlet UIView *blackBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLetterLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *openDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation MSReadLetterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadLetter];
}

-(void)loadLetter{
    NSNumber *const kernAttribute = @1.2;

    self.titleLetterLabel.attributedText = [self.letter.letterTitle addKernStyle:kernAttribute];
    self.sendDateLabel.text = [NSString stringWithFormat:@"Escrita el %@",[self.letter.letterSendDate dateWithMyFormat]];
    NSInteger days = [NSDate daysBetweenDate:self.letter.letterSendDate andDate:self.letter.letterOpenDate];
    NSString *dateLabel;
    if (days == 1) {
        dateLabel = [NSString stringWithFormat:@"Abierta %ld día después",days];
    }else{
        dateLabel = [NSString stringWithFormat:@"Abierta %ld días después",days];
    }
    self.openDateLabel.text = dateLabel;
    self.contentTextView.attributedText = [self.letter.letterContent addKernStyle:kernAttribute];
    [self.contentTextView setTextColor:[UIColor whiteColor]];
    [self.contentTextView setFont:[UIFont fontWithName:FONT_BASKERVILLE_ITALIC size:22]];
}

#pragma mark -
#pragma mark - Getters & Setters

-(void)setLetter:(Letter *)letter{
    _letter = letter;
    if ([_letter.letterStatus statusValue] == MSReadyToOpen) {
        _letter.letterStatus = [NSNumber numberWithInt:MSRead];
    }
}
@end