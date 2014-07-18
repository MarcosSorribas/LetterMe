//
//  MSFirstTimeReadLetterViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSFirstTimeReadLetterViewController.h"

@interface MSFirstTimeReadLetterViewController ()

@end

@implementation MSFirstTimeReadLetterViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
