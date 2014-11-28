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

typedef enum : NSUInteger {
    customPickerView,
    normalPickerView,
    transition,
} PickerState;

@interface MSCreateLetterViewController ()<UITextFieldDelegate,UITextViewDelegate,MSCustomPickerViewDelegate,UIPickerViewDelegate>

#pragma mark - Objects properties
@property (nonatomic) ControllerState controllerState;
@property (strong, nonatomic) IBOutlet MSLetterValidator *validator;
@property (strong, nonatomic) IBOutlet MSCustomPickerView *customPicker;

#pragma mark - Oulets properties
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelView;
@property (weak, nonatomic) IBOutlet UIView *titleBlackView;


@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIView *contentBlackView;


@property (weak, nonatomic) IBOutlet UILabel *dateLabelView;
@property (weak, nonatomic) IBOutlet UIDatePicker *normalPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *dateBlackView;

#pragma mark - Picker logic
@property (weak, nonatomic) IBOutlet UILabel *titleHeader;
@property (weak, nonatomic) IBOutlet UITextField *dateHeader;
@property (weak, nonatomic) IBOutlet UILabel *contentHeader;
@property (weak, nonatomic) IBOutlet UIView *dateViewContent;
@property (weak, nonatomic) IBOutlet UIView *customPickerViewContent;
@property (weak, nonatomic) IBOutlet UIView *normalPickerViewContent;
@property (weak, nonatomic) IBOutlet UIPageControl *controlPickerState;
@property (nonatomic) PickerState actualPicker;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelNavButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendNavButton;

#pragma mark - Animatable Constrains
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateHeaderHeightConstraint;

#pragma mark - Keyboard data
@property (nonatomic) CGRect keyboardSize;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) NSInteger animationCurve;

#pragma mark - Temporal letter Data
@property (strong,nonatomic) NSString *letterTitle;
@property (strong,nonatomic) NSString *letterContent;
@property (strong,nonatomic) NSDate *letterOpenDate;
@end

@implementation MSCreateLetterViewController

#pragma mark - Constants

CGFloat const animationDuration = 0.35;
NSInteger const statusBarheight = 20;
NSInteger const navigationBarheight = 64;

#pragma mark - View methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localizeInterfaz];
    [self initialConfig];
    [self viewInEmptyState];
    [self configurePickerAndTextView];
    [self configureNavigationBar:NSLocalizedString(@"creation_viewController_title", nil)];
    [self registerKeyboardNotifications];
    [self addPickerGestureRecgonizers];
    [self configureNormalPicker];
}

-(void)addPickerGestureRecgonizers{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(presentNormalPicker)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.dateViewContent addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRigth = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(presentCustomPicker)];
    swipeRigth.direction = UISwipeGestureRecognizerDirectionRight;
    [self.dateViewContent addGestureRecognizer:swipeRigth];
}

-(void)configureNormalPicker{
    self.normalPickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60*60*22];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.pickerView selectRow:4 inComponent:0 animated:NO];
}

-(void)localizeInterfaz{
    self.titleLabelView.text = NSLocalizedString(@"creation_viewController_letter_title_description", nil);
    self.contentHeader.text = NSLocalizedString(@"creation_viewController_letter_content", nil);
    self.dateHeader.text = NSLocalizedString(@"creation_viewController_letter_date", nil);
    self.dateLabelView.text = NSLocalizedString(@"creation_viewController_letter_date_description", nil);
    self.cancelNavButton.title = NSLocalizedString(@"creation_viewController_cancel_button", nil);
    self.sendNavButton.title = NSLocalizedString(@"creation_viewController_send_button", nil);
    self.titleHeader.attributedText = [NSLocalizedString(@"creation_viewController_letter_title", nil) addKernStyle:@3];
}

#pragma mark - Initial configure methods

-(void)initialConfig{
    self.titleTextField.alpha = 0;
    self.titleLabelView.alpha = 0;
    self.contentTextView.alpha = 0;
    self.pickerView.alpha = 0;
    self.normalPickerView.alpha =0;

    self.dateLabelView.alpha = 0;
    self.controlPickerState.alpha = 0;
    [self labelsHeaderConfig];
}

-(void)registerKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calculateKeyboardSize:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calculateKeyboardSize:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)calculateKeyboardSize:(NSNotification*)notification{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameEnd = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardSize = [keyboardFrameEnd CGRectValue];
    self.animationDuration = [[keyboardInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.animationCurve = [[keyboardInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    switch (self.controllerState) {
        case ContentState:
            [self viewInContentState];
            break;
        case TitleState:
            [self viewInTitleState];
            break;
        default:
            break;
    }
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
    
    if (([UIScreen mainScreen].bounds.size.height == 480)){
        //iPhone 3,5"
        UIFont *headerFont = [UIFont fontWithName:FONT_HELVETICA_NEUE_ULTRALIGHT size:35];
        self.titleHeader.font = headerFont;
        self.dateHeader.font = headerFont;
        self.contentHeader.font = headerFont;
    }
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

#pragma mark - TextFieldDelegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > maxCharactersTitle) ? NO : YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.letterTitle = textField.text;
    if ([self.validator isAValidLetterTitle:textField.text]) {
        self.titleHeader.text = textField.text;
    }else{
        NSString *failText = NSLocalizedString(@"creation_viewController_letter_title", nil);
        self.titleHeader.attributedText = [failText addKernStyle:@3];
    }
}

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

#pragma mark - DatePickerDelegate methods

-(void)dateDidSelect:(NSDate *)date andHisName:(NSString *)name{
    self.letterOpenDate = date;
    self.dateHeader.text = name;
}

- (IBAction)didSelectDate:(UIDatePicker*)sender {
    NSDateComponents* components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit|NSSecondCalendarUnit|NSMinuteCalendarUnit fromDate:[NSDate date]];
    NSUInteger secondsToday = components.second+(components.minute*60)+(components.hour*60*60);
    NSDate *openDate = [[sender date] dateByAddingTimeInterval:secondsToday];
    self.letterOpenDate = openDate;
    self.dateHeader.text = [NSDateFormatter localizedStringFromDate:[sender date]
                                                          dateStyle:NSDateFormatterLongStyle
                                                          timeStyle:NSDateFormatterNoStyle];
}

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

#pragma mark - Logic view methods

-(void)viewInTitleState{
    
    [self.titleTextField becomeFirstResponder];
    [UIView animateWithDuration:self.animationDuration == 0?animationDuration:self.animationDuration
                          delay:0 options:self.animationCurve animations:^{
                              NSInteger screenHeight = self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height;
                              screenHeight = screenHeight - self.keyboardSize.size.height; //Keyboard
                              
                              self.titleTextField.alpha = 1;
                              self.titleLabelView.alpha = 0.65;
                              self.contentTextView.alpha = 0;
                              self.pickerView.alpha = 0;
                              self.normalPickerView.alpha = 0;

                              self.dateLabelView.alpha = 0;
                              self.controlPickerState.alpha = 0;
                              
                              NSInteger dataSectionHeight = ceil(screenHeight/5);
                              
                              self.dateHeaderHeightConstraint.constant = dataSectionHeight;
                              screenHeight = screenHeight - dataSectionHeight;
                              self.contentHeaderHeightConstraint.constant = dataSectionHeight;
                              screenHeight = screenHeight - dataSectionHeight;
                              
                              self.titleHeaderHeightConstraint.constant = dataSectionHeight;
                              screenHeight = screenHeight - dataSectionHeight;
                              
                              self.titleViewHeightConstraint.constant = screenHeight;
                              
                              self.dateViewHeightConstraint.constant = 0;
                              self.contentViewHeightConstraint.constant = 0;
                              
                              [self.view layoutIfNeeded];
                          } completion:^(BOOL finished) {
                              self.controllerState = TitleState;
                          }];
}

-(void)viewInDateState{
    [UIView animateWithDuration:self.animationDuration == 0?animationDuration:self.animationDuration
                          delay:0 options:self.animationCurve animations:^{
                              [self.view endEditing:YES];
                              NSInteger screenHeight = self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height;
                              self.titleTextField.alpha = 0;
                              self.titleLabelView.alpha = 0;
                              self.contentTextView.alpha = 0;
                              self.dateLabelView.alpha = 0.65;
                              self.pickerView.alpha = 1;
                              self.normalPickerView.alpha = 1;
                              self.controlPickerState.alpha = 1;
                              self.titleViewHeightConstraint.constant = 0;
                              self.dateViewHeightConstraint.constant = screenHeight*0.7;
                              self.contentViewHeightConstraint.constant = 0;
                              
                              NSInteger dataSectionHeight = ceil((screenHeight*(1-0.7))/3);
                              
                              self.dateHeaderHeightConstraint.constant = dataSectionHeight;
                              self.contentHeaderHeightConstraint.constant = dataSectionHeight;
                              self.titleHeaderHeightConstraint.constant = dataSectionHeight;
                              
                              [self.view layoutIfNeeded];
                              [self setUpCorrectPicker];

                          } completion:^(BOOL finished) {
                              self.controllerState = DateState;
                              if ([self.pickerView selectedRowInComponent:0] == 4) {
                                  [self dateDidSelect:[NSDate dateWithTimeIntervalSinceNow:60*60*24*30] andHisName:NSLocalizedString(@"datePicker_1_month", nil)];
                              }
                          }];
}

-(void)setUpCorrectPicker{
    switch (self.actualPicker) {
        case normalPickerView:{
            CGRect actualPickerFrame = self.customPickerViewContent.frame;
            CGRect newPickerRect = CGRectMake(-actualPickerFrame.size.width, actualPickerFrame.origin.y, actualPickerFrame.size.width, actualPickerFrame.size.height);
            
            self.customPickerViewContent.frame = newPickerRect;
            self.normalPickerViewContent.frame = actualPickerFrame;
            self.controlPickerState.currentPage = normalPickerView;
            self.actualPicker = normalPickerView;
        }break;
        case customPickerView:
        case transition:
            self.controlPickerState.currentPage = customPickerView;
            self.actualPicker = customPickerView;
            break;
    }
}

-(void)viewInContentState{
    [self.contentTextView becomeFirstResponder];
    [UIView animateWithDuration:self.animationDuration == 0?animationDuration:self.animationDuration
                          delay:0 options:self.animationCurve animations:^{
                              
                              self.titleTextField.alpha = 0;
                              self.titleLabelView.alpha = 0;
                              self.contentTextView.alpha = 1;
                              self.pickerView.alpha = 0;
                              self.normalPickerView.alpha = 0;
                              self.dateLabelView.alpha = 0;
                              self.controlPickerState.alpha = 0;
                              self.titleViewHeightConstraint.constant = 0;
                              self.dateViewHeightConstraint.constant = 0;
                            
                              NSInteger screenHeight = self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height;
                              screenHeight = screenHeight - self.keyboardSize.size.height; //Keyboard
                              NSInteger dataSectionHeight = ceil(screenHeight/5);
                              
                              self.dateHeaderHeightConstraint.constant = dataSectionHeight;
                              screenHeight = screenHeight - dataSectionHeight;
                              self.contentHeaderHeightConstraint.constant = dataSectionHeight;
                              screenHeight = screenHeight - dataSectionHeight;
                              self.titleHeaderHeightConstraint.constant = dataSectionHeight;
                              screenHeight = screenHeight - dataSectionHeight;
                              self.contentViewHeightConstraint.constant = screenHeight;
                
                              [self.view layoutIfNeeded];
                              
                          } completion:^(BOOL finished) {
                              self.controllerState = ContentState;
                          }];
}
-(void)viewInEmptyState{
    [self.view endEditing:YES];
    NSInteger headersHeight =  ceil((self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height)/3);
    [UIView animateWithDuration:self.animationDuration == 0?animationDuration:self.animationDuration
                          delay:0 options:self.animationCurve animations:^{
                              self.titleTextField.alpha = 0;
                              self.titleLabelView.alpha = 0;
                              self.contentTextView.alpha = 0;
                              self.pickerView.alpha = 0;
                              self.normalPickerView.alpha =0;

                              self.dateLabelView.alpha = 0;
                              self.controlPickerState.alpha = 0;
                              
                              self.titleHeaderHeightConstraint.constant = headersHeight;
                              self.titleViewHeightConstraint.constant = 0;
                              
                              self.dateHeaderHeightConstraint.constant = headersHeight;
                              self.dateViewHeightConstraint.constant = 0;
                              
                              self.contentHeaderHeightConstraint.constant = headersHeight;
                              self.contentViewHeightConstraint.constant = 0;
                              
                              [self.view layoutIfNeeded];
                          }completion:^(BOOL finished) {
                              self.controllerState = EmptyState;
                          }];
}
-(void)presentNormalPicker{
    if (self.actualPicker == customPickerView) {
        self.actualPicker = transition;
        CGRect actualPickerFrame = self.customPickerViewContent.frame;
        CGRect newPickerRect = CGRectMake(-actualPickerFrame.size.width, actualPickerFrame.origin.y, actualPickerFrame.size.width, actualPickerFrame.size.height);
        [UIView animateWithDuration:0.45 animations:^{
            self.customPickerViewContent.frame = newPickerRect;
            self.normalPickerViewContent.frame = actualPickerFrame;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.actualPicker = normalPickerView;
            self.controlPickerState.currentPage = normalPickerView;
        }];
    }
}
-(void)presentCustomPicker{
    if (self.actualPicker == normalPickerView) {
        self.actualPicker = transition;
        CGRect actualPickerFrame = self.normalPickerViewContent.frame;
        CGRect newVisiblePickerRect = CGRectMake(10, actualPickerFrame.origin.y, actualPickerFrame.size.width, actualPickerFrame.size.height);
        CGRect newInvisiblePickerRect = CGRectMake(self.dateViewContent.frame.size.width, actualPickerFrame.origin.y, actualPickerFrame.size.width, actualPickerFrame.size.height);
        [UIView animateWithDuration:0.45 animations:^{
            self.normalPickerViewContent.frame = newInvisiblePickerRect;
            self.customPickerViewContent.frame = newVisiblePickerRect;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.actualPicker = customPickerView;
            self.controlPickerState.currentPage = customPickerView;
        }];
    }
}

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
    [self createLocalNotification:letter.letterOpenDate];
}

-(void)createLocalNotification:(NSDate*)openDate{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = openDate;
    notification.alertBody = NSLocalizedString(@"letter_received_notification_body", nil);
    
    NSNumber *actualBadge = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppBadge"];
    actualBadge = [NSNumber numberWithInteger:(actualBadge.integerValue+1)];
    notification.applicationIconBadgeNumber = actualBadge.integerValue;
    [[NSUserDefaults standardUserDefaults] setObject:actualBadge forKey:@"AppBadge"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)animateMistakeIn:(UIView*)view{
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [view setBackgroundColor:RED_MISTAKE_COLOR];
        [view setBackgroundColor:BLACK_LIGHT_COLOR];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - IBAction

- (IBAction)createLetter:(id)sender {
    [self viewInEmptyState];
    if ([self localizeMistakesInState] == CorrectState) {
        [self createLetterWithUserData];
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"Carta creada correctamente! 👏");
        }];
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end