//
//  MSCreateLetterViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSCreateLetterViewController.h"

@interface MSCreateLetterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeaderHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateHeaderHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeaderHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;

@end

@implementation MSCreateLetterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpInitial];
}

#pragma mark -
#pragma mark - Touched methods

- (IBAction)titleHeaderTouched:(UITapGestureRecognizer *)sender {
    
}

- (IBAction)dateHeaderTouched:(UITapGestureRecognizer *)sender {

}

- (IBAction)contentHeaderTouched:(UITapGestureRecognizer *)sender {
    
}



#pragma mark -
#pragma mark - Private methods

-(void)setUpInitial{
    [self.titleTextField becomeFirstResponder];


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