//
//  MSCreateLetterViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSCreateLetterViewController.h"

 enum : NSUInteger {
    TitleState = 0,
    DateState = 1,
    ContentState = 2,
    UnknowState = -1,
 }; typedef NSInteger ControllerState;

@interface MSCreateLetterViewController ()

#pragma mark -
#pragma mark - Private properties
@property (nonatomic) ControllerState controllerState;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;


#pragma mark -
#pragma mark - Constains

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;

@end

@implementation MSCreateLetterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpTitleState];
}

#pragma mark -
#pragma mark - Touched methods

- (IBAction)titleHeaderTouched:(UITapGestureRecognizer *)sender {
    if (self.controllerState != TitleState) {
        [self setUpTitleState];
    }
}

- (IBAction)dateHeaderTouched:(UITapGestureRecognizer *)sender {
    if (self.controllerState != DateState) {
        [self setUpDateState];
    }
}

- (IBAction)contentHeaderTouched:(UITapGestureRecognizer *)sender {
    if (self.controllerState != ContentState) {
        [self setUpContentState];
    }
}

#pragma mark -
#pragma mark - Private methods

-(void)setUpTitleState{
    self.controllerState = TitleState;
    [self.titleTextField becomeFirstResponder];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1
                     animations:^{
                         self.navigationItem.title = @"Escriba un titulo";
                         self.titleHeaderHeightConstraint.constant = 25;
                         self.titleViewHeightConstraint.constant = 155;
                         self.dateHeaderHeightConstraint.constant = 55;
                         self.dateViewHeightConstraint.constant = 0;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.contentViewHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                     }];

}

-(void)setUpDateState{
    self.controllerState = DateState;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1
                     animations:^{
                         [self.view endEditing:YES];
                         self.navigationItem.title = @"Elija fecha de entrega";
                         self.titleHeaderHeightConstraint.constant = 55;
                         self.titleViewHeightConstraint.constant = 0;
                         self.dateHeaderHeightConstraint.constant = 25;
                         self.dateViewHeightConstraint.constant = 155+214;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.contentViewHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                     }];
    
}

-(void)setUpContentState{
    self.controllerState = ContentState;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1
                     animations:^{
                         [self.contentTextView becomeFirstResponder];
                         self.navigationItem.title = @"Escriba una carta";
                         self.titleHeaderHeightConstraint.constant = 45;
                         self.titleViewHeightConstraint.constant = 0;
                         self.dateHeaderHeightConstraint.constant = 45;
                         self.dateViewHeightConstraint.constant = 0;
                         self.contentHeaderHeightConstraint.constant = 25;
                         self.contentViewHeightConstraint.constant = 155+20;
                         [self.view layoutIfNeeded]; 
                     }];
}

#pragma mark -
#pragma mark - IBAction

- (IBAction)createLetter:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelLetter:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end