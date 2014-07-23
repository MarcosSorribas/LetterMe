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

enum : NSUInteger {
    TitleState = 1,
    DateState = 2,
    ContentState = 3,
    EmptyState = 4,
}; typedef NSInteger ControllerState;

@interface MSCreateLetterViewController ()<UITextFieldDelegate,UITextViewDelegate,MSCustomPickerViewDelegate>

#pragma mark -
#pragma mark - Private properties

@property (nonatomic) ControllerState controllerState;
@property (nonatomic,strong) Letter *letter;
@property (nonatomic,strong) MSLetterValidator *validator;
@property (nonatomic,strong) MSCustomPickerView *customPicker;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelView;
@property (weak, nonatomic) IBOutlet UIView *titleBlackView;


@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIView *contentBlackView;


@property (weak, nonatomic) IBOutlet UILabel *dateLabelView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *dateBlackView;




@property (weak, nonatomic) IBOutlet UILabel *titleHeader;
@property (weak, nonatomic) IBOutlet UILabel *dateHeader;



#pragma mark -
#pragma mark - Constains

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateHeaderHeightConstraint;

@end

@implementation MSCreateLetterViewController

CGFloat const animationDuration = 0.35;

#pragma mark -
#pragma mark - View methods

-(void)configurePickerAndTextView{
    self.pickerView.dataSource = self.customPicker;
    self.pickerView.delegate = self.customPicker;
    self.customPicker.delegate = self;
    self.contentTextView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialConfig];
    [self viewInEmptyState];
    [self configurePickerAndTextView];
    [self configureNavigationBar:@"Crea tu carta"];
}

-(void)initialConfig{
    self.titleTextField.alpha = 0;
    self.titleLabelView.alpha = 0;
    self.contentTextView.alpha = 0;
    self.pickerView.alpha = 0;
    self.dateLabelView.alpha = 0;
}

-(void)configureNavigationBar:(NSString*)titleString{
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.845 green:0.708 blue:0.671 alpha:1.000]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    NSMutableAttributedString *titleWithAtt = [[NSMutableAttributedString alloc] initWithString:titleString attributes:@{NSKernAttributeName:@2}];
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.textColor = [UIColor colorWithRed:0.845 green:0.708 blue:0.671 alpha:1.000];
    labelView.adjustsFontSizeToFitWidth = YES;
    labelView.attributedText = titleWithAtt;
    self.navigationItem.titleView = labelView;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self createALetterWithoutData];
    [self.pickerView selectRow:4 inComponent:0 animated:NO];
}

#pragma mark -
#pragma mark - TextFieldDelegate methods

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.letter.letterTitle = textField.text;
    if ([self.validator isAValidLetterTitle:textField.text]) {
        self.titleHeader.text = textField.text;
    }
}

#pragma mark -
#pragma mark - TextViewDelegate methods

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.letter.letterContent = textView.text;
}

- (void)textViewDidChange:(UITextView *)textView {
    CGRect line = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height
    - ( textView.contentOffset.y + textView.bounds.size.height
       - textView.contentInset.bottom - textView.contentInset.top);
    if ( overflow > 0 ) {
        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
        // Scroll caret to visible area
        CGPoint offset = textView.contentOffset;
        offset.y += overflow; // leave 7 pixels margin
        // Cannot animate with setContentOffset:animated: or caret will not appear
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
}

-(void)dateDidSelect:(NSDate *)date andHisName:(NSString *)name{
    self.letter.letterOpenDate = date;
    self.dateHeader.text = name;
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
    [self.titleTextField becomeFirstResponder];
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.titleTextField.alpha = 1;
                         self.titleLabelView.alpha = 0.65;
                         self.contentTextView.alpha = 0;
                         self.pickerView.alpha = 0;
                         self.dateLabelView.alpha = 0;
                         
                         self.dateHeaderHeightConstraint.constant = 55;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.titleHeaderHeightConstraint.constant = 55;
                         self.titleViewHeightConstraint.constant = 125;
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
                         
                         self.dateHeaderHeightConstraint.constant = 55;
                         self.contentHeaderHeightConstraint.constant = 55;
                         self.titleHeaderHeightConstraint.constant = 55;
                         self.titleViewHeightConstraint.constant = 0;
                         self.dateViewHeightConstraint.constant = 125+214;
                         self.contentViewHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         self.controllerState = DateState;
                         
                         if ([self.pickerView selectedRowInComponent:0] == 4) {
#warning OJO ESTO HUELE MAL
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
                         self.contentViewHeightConstraint.constant = 125;
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

-(ControllerState)localizeMistakesInState{
    if (![self.validator isAValidLetterTitle:self.letter.letterTitle]) {
        return TitleState;
    }
    if (![self.validator isAValidLetterContent:self.letter.letterContent]) {
        return ContentState;
    }
    if (![self.validator isAValidLetterOpenDate:self.letter.letterOpenDate]) {
        return DateState;
    }
    return EmptyState;
}

#pragma mark -
#pragma mark - IBAction

- (IBAction)createLetter:(id)sender {
    [self viewInEmptyState];
    if ([self.validator isAValidLetter:self.letter]) {
        [self.manageDocument.undoManager endUndoGrouping];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        switch ([self localizeMistakesInState]) {
            case TitleState:{
                [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.titleBlackView setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.19]];
                    
                    [self.titleBlackView setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.150]];
                } completion:^(BOOL finished) {
                }];
                break;
            }
            case ContentState:{
                [UIView animateWithDuration:0.45 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [self.contentBlackView setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.19]];
                    [self.contentBlackView setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.150]];
                } completion:^(BOOL finished) {
                    [self viewInContentState];
                    
                }];
                break;
            }
            case DateState:{
                [UIView animateWithDuration:0.45 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [self.dateBlackView setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.19]];
                    [self.dateBlackView setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.150]];
                } completion:^(BOOL finished) {
                    [self viewInDateState];
                }];
                break;
            }
            default:
                break;
        }
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

-(MSCustomPickerView *)customPicker{
    if (!_customPicker) {
        _customPicker = [[MSCustomPickerView alloc]init];
    }
    return _customPicker;
}
@end