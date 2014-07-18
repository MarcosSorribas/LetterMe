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

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (nonatomic) ControllerState controllerState;

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
    [self setUpTitleState];
}

- (IBAction)dateHeaderTouched:(UITapGestureRecognizer *)sender {
    [self setUpDateState];

}

- (IBAction)contentHeaderTouched:(UITapGestureRecognizer *)sender {
    [self setUpContentState];
}

#pragma mark -
#pragma mark - Private methods

-(void)setUpTitleState{
    self.controllerState = TitleState;
    [self.titleTextField becomeFirstResponder];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1
                     animations:^{
                         self.titleHeaderHeightConstraint.constant = 25;
                         self.titleViewHeightConstraint.constant = 155;
                         self.dateHeaderHeightConstraint.constant = 55;
                         self.dateViewHeightConstraint.constant = 0;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.contentViewHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];

}

-(void)setUpDateState{
    self.controllerState = DateState;
    [self.view endEditing:YES];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1
                     animations:^{
                         self.titleHeaderHeightConstraint.constant = 55;
                         self.titleViewHeightConstraint.constant = 0;
                         self.dateHeaderHeightConstraint.constant = 25;
                         self.dateViewHeightConstraint.constant = 155+214;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.contentViewHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
    
}

-(void)setUpContentState{
    self.controllerState = ContentState;
    [UIView animateWithDuration:1
                     animations:^{
                         self.titleHeaderHeightConstraint.constant = 55;
                         self.titleViewHeightConstraint.constant = 0;
                         self.dateHeaderHeightConstraint.constant = 55;
                         self.dateViewHeightConstraint.constant = 0;
                         self.contentHeaderHeightConstraint.constant = 25;
                         self.contentViewHeightConstraint.constant = 155;
                         [self.view layoutIfNeeded]; // Called on parent view
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