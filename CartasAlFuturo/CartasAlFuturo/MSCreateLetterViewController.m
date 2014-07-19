//
//  MSCreateLetterViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSCreateLetterViewController.h"
#import "Letter+myAPI.h"
#import "MSLetterValidator.h"

enum : NSUInteger {
    TitleState = 1,
    DateState = 2,
    ContentState = 3,
    EmptyState = 4,
}; typedef NSInteger ControllerState;

@interface MSCreateLetterViewController ()<UITextFieldDelegate,UITextViewDelegate>

#pragma mark -
#pragma mark - Private properties

@property (nonatomic) ControllerState controllerState;
@property (nonatomic,strong) Letter *letter;
@property (nonatomic,strong) MSLetterValidator *validator;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UILabel *titleHeader;
@property (weak, nonatomic) IBOutlet UILabel *dateHeader;
@property (weak, nonatomic) IBOutlet UILabel *contentHeader;


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

NSInteger const oneDayInSeconds = 60*60*24;
CGFloat const animationDuration = 0.3;

#pragma mark -
#pragma mark - View methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self viewInEmptyState];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:oneDayInSeconds];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self createALetterWithoutData];
}

#pragma mark -
#pragma mark - TextFieldDelegate methods

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.letter.letterTitle = textField.text;
    self.titleHeader.text = textField.text;
}

#pragma mark -
#pragma mark - TextViewDelegate methods

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.letter.letterContent = textView.text;
}

- (IBAction)createOpenDate:(UIDatePicker *)sender {
    self.letter.letterOpenDate =  sender.date;
}

#pragma mark -
#pragma mark - Touched methods

- (IBAction)titleHeaderTouched:(UITapGestureRecognizer *)sender {
    switch (self.controllerState) {
        case TitleState:
            //Volvemos al estado vacio, se cierra el titulo
            [self viewInEmptyState];
            break;
        default:
            [self viewInTitleState];
            break;
    }
}

- (IBAction)dateHeaderTouched:(UITapGestureRecognizer *)sender {
    switch (self.controllerState) {
        case DateState:
            [self viewInEmptyState];
            break;
        default:
            [self viewInDateState];
            break;
    }
}

- (IBAction)contentHeaderTouched:(UITapGestureRecognizer *)sender {
    switch (self.controllerState) {
        case ContentState:
             [self viewInEmptyState];
            break;
        default:
            [self viewInContentState];
            break;
    }
}

#pragma mark -
#pragma mark - Private methods

-(void)createALetterWithoutData{
    [self.manageDocument.undoManager beginUndoGrouping];
    self.letter = [Letter createLetterInContext:self.manageDocument.managedObjectContext];
    
}

-(void)viewInTitleState{
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         [self.titleTextField becomeFirstResponder];
                         self.navigationItem.title = @"Escriba un titulo";
                         self.titleHeaderHeightConstraint.constant = 55;
                         self.titleViewHeightConstraint.constant = 125;
                         self.dateHeaderHeightConstraint.constant = 55;
                         self.dateViewHeightConstraint.constant = 0;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.contentViewHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         self.controllerState = TitleState;
                         [self temporalValidate];
                     }];
}

-(void)viewInDateState{
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         [self.view endEditing:YES];
                         self.navigationItem.title = @"Elija fecha de entrega";
                         self.titleHeaderHeightConstraint.constant = 55;
                         self.titleViewHeightConstraint.constant = 0;
                         self.dateHeaderHeightConstraint.constant = 55;
                         self.dateViewHeightConstraint.constant = 125+214;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.contentViewHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [self temporalValidate];
                         self.controllerState = DateState;
                     }];
}

-(void)viewInContentState{
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         [self.contentTextView becomeFirstResponder];
                         self.navigationItem.title = @"Escriba una carta";
                         self.titleHeaderHeightConstraint.constant = 55;
                         self.titleViewHeightConstraint.constant = 0;
                         self.dateHeaderHeightConstraint.constant = 55;
                         self.dateViewHeightConstraint.constant = 0;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.contentViewHeightConstraint.constant = 125;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [self temporalValidate];
                         self.controllerState = ContentState;
                     }];
}

-(void)viewInEmptyState{
    [self.view endEditing:YES];
    [UIView animateWithDuration:animationDuration
                     animations:^{
        self.titleHeaderHeightConstraint.constant = (self.view.bounds.size.height-64)/3;
        self.titleViewHeightConstraint.constant = 0;
        
        self.dateHeaderHeightConstraint.constant = (self.view.bounds.size.height-64)/3;
        self.dateViewHeightConstraint.constant = 0;
        
        self.contentHeaderHeightConstraint.constant = (self.view.bounds.size.height-64)/3;
        self.contentViewHeightConstraint.constant = 0;
        
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.controllerState = EmptyState;
    }];
}



-(void)temporalValidate{
    switch (self.controllerState) {
        case TitleState:
            if (![self.validator isAValidLetterTitle:self.letter.letterTitle]) {
                NSLog(@"Errores en el titulo");
            }
            break;
        case DateState:
            if (![self.validator isAValidLetterOpenDate:self.letter.letterOpenDate]) {
                NSLog(@"Errores en la fecha");
            }
            break;
        case ContentState:
            if (![self.validator isAValidLetterContent:self.letter.letterContent]) {
                NSLog(@"Errores en el contenido");
            }
            break;
        default:
            break;
    }

}

#pragma mark -
#pragma mark - IBAction

- (IBAction)createLetter:(id)sender {
    if ([self.validator isAValidLetter:self.letter]) {
        [self.manageDocument.undoManager endUndoGrouping];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        NSLog(@"Tiene algun fallo, no podemos crearla");
    }
}

- (IBAction)cancelLetter:(id)sender {
    [self.manageDocument.undoManager endUndoGrouping];
    [self.manageDocument.undoManager undo];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - Getters & Setters

-(MSLetterValidator *)validator{
    if (_validator == nil) {
        _validator = [[MSLetterValidator alloc]init];
    }
    return _validator;
}
@end