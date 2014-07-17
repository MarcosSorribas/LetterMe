//
//  MSCreateLettersTableViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 17/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSCreateLettersTableViewController.h"

@interface MSCreateLettersTableViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) CGFloat titleRowHeight;
@property (nonatomic) CGFloat dateRowHeight;
@property (nonatomic) CGFloat contentRowHeight;
@end

@implementation MSCreateLettersTableViewController


#pragma mark -
#pragma mark - SetUp view methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            // Titulo
            return self.titleRowHeight;
            break;
        case 1:
            // Fecha
            return self.dateRowHeight;
            break;
        case 2:
            // Contenido
            return self.contentRowHeight;
            break;
        default:
            break;
    }
    return 0;
}

#pragma mark -
#pragma mark - DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            // Titulo
            cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
            break;
        case 1:
            // Fecha
            cell = [tableView dequeueReusableCellWithIdentifier:@"dateCell" forIndexPath:indexPath];
            break;
        case 2:
            // Contenido
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Titulo";
        case 1:
            return @"Fecha";
        case 2:
            return @"Contenido";
        default:
            return nil;
    }
}

#pragma mark -
#pragma mark - TextFieldDelegate methods


#pragma mark -
#pragma mark - Private methods


#pragma mark -
#pragma mark - IBActions

- (IBAction)doneTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - Getters & Setters
-(CGFloat)titleRowHeight{
    if (!_titleRowHeight) {
        _titleRowHeight = 120;
    }
    return _titleRowHeight;
}
-(CGFloat)dateRowHeight{
    if (!_dateRowHeight) {
        _dateRowHeight = 44;
    }
    return _dateRowHeight;
}
-(CGFloat)contentRowHeight{
    if (!_contentRowHeight) {
        _contentRowHeight = 20;
    }
    return _contentRowHeight;
}

@end