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
#import "NSDate+CustomizableDate.h"

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
    self.blackBackgroundView.layer.cornerRadius = 15;
    
}

-(void)loadLetter{
    self.titleLetterLabel.text = self.letter.letterTitle;
    
    self.sendDateLabel.text = [NSString stringWithFormat:@"Creada el: %@",[self.letter.letterSendDate dateWithMyFormat]];
    self.openDateLabel.text = [NSString stringWithFormat:@"Abierta el: %@",[self.letter.letterOpenDate dateWithMyFormat]];
    
    
    
    self.contentTextView.text = self.letter.letterContent;
    [self.contentTextView setTextColor:[UIColor whiteColor]];
    [self.contentTextView setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0]];
}

-(void)setLetter:(Letter *)letter{
    _letter = letter;
    if ([_letter.letterStatus statusValue] == MSReadyToOpen) {
        _letter.letterStatus = [NSNumber numberWithInt:MSRead];
    }
}
@end