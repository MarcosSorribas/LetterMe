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
#import "MSCustomPickerView.h"
#import "NSString+Styles.h"

#import "UIView+Animations.h"

enum : NSUInteger {
    TitleState = 1,
    DateState = 2,
    ContentState = 3,
    EmptyState = 4,
    CorrectState = 5,
}; typedef NSInteger ControllerState;

@interface MSCreateLetterViewController ()<UITextFieldDelegate,UITextViewDelegate,MSCustomPickerViewDelegate>

#pragma mark -
#pragma mark - Objects properties

@property (nonatomic) ControllerState controllerState;
@property (nonatomic,strong) MSLetterValidator *validator;
@property (nonatomic,strong) MSCustomPickerView *customPicker;


#pragma mark -
#pragma mark - Oulets properties

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelView;
@property (weak, nonatomic) IBOutlet UIView *titleBlackView;
@property (weak, nonatomic) IBOutlet UILabel *titleWarningCharactersLabel;


@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIView *contentBlackView;


@property (weak, nonatomic) IBOutlet UILabel *dateLabelView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *dateBlackView;




@property (weak, nonatomic) IBOutlet UITextField *titleHeader;
@property (weak, nonatomic) IBOutlet UITextField *dateHeader;
@property (weak, nonatomic) IBOutlet UILabel *contentHeader;



#pragma mark -
#pragma mark - Animatable Constrains

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateHeaderHeightConstraint;



#pragma mark -
#pragma mark - Temporal letter Data

@property (strong,nonatomic) NSString *letterTitle;
@property (strong,nonatomic) NSString *letterContent;
@property (strong,nonatomic) NSDate *letterOpenDate;

@end

@implementation MSCreateLetterViewController

#pragma mark -
#pragma mark - Constants

CGFloat const animationDuration = 0.35;
NSString *const navBarTitle = @"Crea tu carta";

#pragma mark -
#pragma mark - View methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialConfig];
    [self viewInEmptyState];
    [self configurePickerAndTextView];
    [self configureNavigationBar:navBarTitle];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.pickerView selectRow:4 inComponent:0 animated:NO];
}

#pragma mark -
#pragma mark - Initial configure methods 

-(void)initialConfig{
    self.titleTextField.alpha = 0;
    self.titleLabelView.alpha = 0;
    self.contentTextView.alpha = 0;
    self.pickerView.alpha = 0;
    self.dateLabelView.alpha = 0;
    [self labelsHeaderConfig];
}

-(void)configurePickerAndTextView{
    self.pickerView.dataSource = self.customPicker;
    self.pickerView.delegate = self.customPicker;
    self.customPicker.delegate = self;
    self.contentTextView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
}


-(void)labelsHeaderConfig{
    NSNumber * const kern = @3;
    self.titleHeader.attributedText = [self.titleHeader.text addKernStyle:kern];
    self.dateHeader.attributedText = [self.dateHeader.text addKernStyle:kern];
    self.contentHeader.attributedText = [self.contentHeader.text addKernStyle:kern];
    
    self.titleHeader.adjustsFontSizeToFitWidth = YES;
    self.dateHeader.adjustsFontSizeToFitWidth = YES;
    self.contentHeader.adjustsFontSizeToFitWidth = YES;
}

-(void)configureNavigationBar:(NSString*)titleString{
    [[UINavigationBar appearance] setTintColor:MAIN_COLOR];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    NSMutableAttributedString *titleWithAtt = [[NSMutableAttributedString alloc] initWithString:titleString attributes:@{NSKernAttributeName:@0.5,NSFontAttributeName:[UIFont fontWithName:FONT_HELVETICA_NEUE_LIGHT size:19.0]}];
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.textColor = MAIN_COLOR;
    labelView.adjustsFontSizeToFitWidth = YES;
    labelView.attributedText = titleWithAtt;
    self.navigationItem.titleView = labelView;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:FONT_HELVETICA_NEUE_LIGHT size:19.0]};
    NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont fontWithName:FONT_HELVETICA_NEUE_LIGHT size:18.0]};
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attributes2 forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
}


#pragma mark -
#pragma mark - TextFieldDelegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > maxCharactersTitle) ? NO : YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.letterTitle = textField.text;
    if ([self.validator isAValidLetterTitle:textField.text]) {
        self.titleHeader.text = textField.text;
    }
}

#pragma mark -
#pragma mark - TextViewDelegate methods

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.letterContent = textView.text;
}

- (void)textViewDidChange:(UITextView *)textView {
    CGRect line = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height
    - ( textView.contentOffset.y + textView.bounds.size.height
       - textView.contentInset.bottom - textView.contentInset.top);
    if ( overflow > 0 ) {
        CGPoint offset = textView.contentOffset;
        offset.y += overflow;
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
}

#pragma mark -
#pragma mark - DatePickerDelegate methods

-(void)dateDidSelect:(NSDate *)date andHisName:(NSString *)name{
    self.letterOpenDate = date;
    self.dateHeader.text = name;
}

#pragma mark -
#pragma mark - Touched Cicle methods

- (IBAction)titleHeaderTouched:(UITapGestureRecognizer *)sender {
    switch (self.controllerState) {
        case TitleState:
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
#pragma mark - Logic view methods

//TODO: Refactor whithout harcode numbers and compatibility with iPhone4

-(void)viewInTitleState{
    [self.titleTextField becomeFirstResponder];
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.titleTextField.alpha = 1;
                         self.titleLabelView.alpha = 0.65;
                         self.contentTextView.alpha = 0;
                         self.pickerView.alpha = 0;
                         self.dateLabelView.alpha = 0;
                         
                         self.dateHeaderHeightConstraint.constant = 60;
                         self.contentHeaderHeightConstraint.constant = 60;
                         self.titleHeaderHeightConstraint.constant = 60;
                         self.titleViewHeightConstraint.constant = 130;
                         self.dateViewHeightConstraint.constant = 0;
                         self.contentViewHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         self.controllerState = TitleState;
                     }];
}

-(void)viewInDateState{
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         [self.view endEditing:YES];
                         self.titleTextField.alpha = 0;
                         self.titleLabelView.alpha = 0;
                         self.contentTextView.alpha = 0;
                         self.pickerView.alpha = 1;
                         self.dateLabelView.alpha = 0.65;
                         
                         self.dateHeaderHeightConstraint.constant = 60;
                         self.contentHeaderHeightConstraint.constant = 60;
                         self.titleHeaderHeightConstraint.constant = 60;
                         self.titleViewHeightConstraint.constant = 0;
                         self.dateViewHeightConstraint.constant = 125+214+5;
                         self.contentViewHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         self.controllerState = DateState;
                         if ([self.pickerView selectedRowInComponent:0] == 4) {
                             [self dateDidSelect:[NSDate dateWithTimeIntervalSinceNow:60*60*24*30] andHisName:@"Dentro de un mes"];
                         }
                     }];
}

-(void)viewInContentState{
    [self.contentTextView becomeFirstResponder];
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.titleTextField.alpha = 0;
                         self.titleLabelView.alpha = 0;
                         self.contentTextView.alpha = 1;
                         self.pickerView.alpha = 0;
                         self.dateLabelView.alpha = 0;
                         
                         self.titleViewHeightConstraint.constant = 0;
                         self.dateViewHeightConstraint.constant = 0;
                         self.contentViewHeightConstraint.constant = 125+20;
                         self.dateHeaderHeightConstraint.constant = 55;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.titleHeaderHeightConstraint.constant = 55;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         self.controllerState = ContentState;
                     }];
}

-(void)viewInEmptyState{
    [self.view endEditing:YES];
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.titleTextField.alpha = 0;
                         self.titleLabelView.alpha = 0;
                         self.contentTextView.alpha = 0;
                         self.pickerView.alpha = 0;
                         self.dateLabelView.alpha = 0;
                         
                         self.titleHeaderHeightConstraint.constant = (self.view.bounds.size.height-64+20)/3;
                         self.titleViewHeightConstraint.constant = 0;
                         
                         self.dateHeaderHeightConstraint.constant = (self.view.bounds.size.height-64+20)/3;
                         self.dateViewHeightConstraint.constant = 0;
                         
                         self.contentHeaderHeightConstraint.constant = (self.view.bounds.size.height-64+20)/3;
                         self.contentViewHeightConstraint.constant = 0;
                         
                         [self.view layoutIfNeeded];
                     }completion:^(BOOL finished) {
                         self.controllerState = EmptyState;
                     }];
}

#pragma mark -
#pragma mark - Private methods

-(ControllerState)localizeMistakesInState{
    if (![self.validator isAValidLetterTitle:self.letterTitle]) {
        return TitleState;
    }
    if (![self.validator isAValidLetterContent:self.letterContent]) {
        return ContentState;
    }
    if (![self.validator isAValidLetterOpenDate:self.letterOpenDate]) {
        return DateState;
    }
    return CorrectState;
}

-(void)createLetterWithUserData{
    [self.manageDocument.managedObjectContext.undoManager beginUndoGrouping];
    Letter *letter = [Letter createLetterInContext:self.manageDocument.managedObjectContext];
    letter.letterTitle = self.letterTitle;
    letter.letterContent = self.letterContent;
    letter.letterOpenDate = self.letterOpenDate;
    [self.manageDocument.managedObjectContext.undoManager endUndoGrouping];
}

-(void)animateMistakeIn:(UIView*)view{
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [view setBackgroundColor:RED_MISTAKE_COLOR];
        [view setBackgroundColor:BLACK_LIGHT_COLOR];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark -
#pragma mark - IBAction

- (IBAction)createLetter:(id)sender {
    [self viewInEmptyState];
    if ([self localizeMistakesInState] == CorrectState) {
        [self createLetterWithUserData];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        switch ([self localizeMistakesInState]) {
            case TitleState:{
                [self.titleBlackView shakeAnimate];
                [self animateMistakeIn:self.titleBlackView];
                break;
            }
            case ContentState:{
                [self.contentBlackView shakeAnimate];
                [self animateMistakeIn:self.contentBlackView];
                break;
            }
            case DateState:{
                [self.dateBlackView shakeAnimate];
                [self animateMistakeIn:self.dateBlackView];
                break;
            }
            default:
                break;
        }
    }
}

- (IBAction)cancelLetter:(id)sender {
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

-(MSCustomPickerView *)customPicker{
    if (!_customPicker) {
        _customPicker = [[MSCustomPickerView alloc]init];
    }
    return _customPicker;
}
@end