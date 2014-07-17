//
//  MSCreateLettersTableViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 17/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSCreateLettersTableViewController.h"
#import "MSTitleTableViewCell.h"

enum : NSUInteger {
    TitleCell = 0,
    DateCell = 1,
    ContentCell = 2,
    UnknowCell = -1
};
typedef NSInteger cellIdentificator;

@interface MSCreateLettersTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) CGFloat titleRowHeight;
@property (nonatomic) CGFloat dateRowHeight;
@property (nonatomic) CGFloat contentRowHeight;

@property (nonatomic) CGFloat titleSectionHeight;
@property (nonatomic) CGFloat dateSectionHeight;
@property (nonatomic) CGFloat contentSectionHeight;

@property (nonatomic,strong) NSIndexPath *titlePath;
@property (nonatomic,strong) NSIndexPath *datePath;
@property (nonatomic,strong) NSIndexPath *contentPath;

@property (nonatomic,strong) MSTitleTableViewCell *cell;

@end

@implementation MSCreateLettersTableViewController

#pragma mark -
#pragma mark - Constans

NSUInteger const numberOfSections = 3;
NSUInteger const numberOfRowsInSection = 1;

NSUInteger const titleSection = 0;
NSUInteger const dateSection = 1;
NSUInteger const contentSection = 2;

#pragma mark -
#pragma mark - DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return numberOfSections;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return numberOfRowsInSection;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    switch ([self compareIndexPath:indexPath]) {
        case TitleCell:
            cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
            self.cell = (MSTitleTableViewCell*)cell;
            break;
        case DateCell:
            cell = [tableView dequeueReusableCellWithIdentifier:@"dateCell" forIndexPath:indexPath];
            break;
        case ContentCell:
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
#pragma mark - TableViewDelegate methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView beginUpdates];
    
    switch ([self compareIndexPath:indexPath]) {
        case TitleCell:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case DateCell:
            
            break;
        case ContentCell:
            
            break;
        default:
            break;
    }
    [self.tableView endUpdates];
    return indexPath;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ([self compareIndexPath:indexPath]) {
        case TitleCell:
            return self.titleRowHeight;
            break;
        case DateCell:
            return self.dateRowHeight;
            break;
        case ContentCell:
            return self.contentRowHeight;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case titleSection:
            return self.titleSectionHeight;
            break;
        case dateSection:
            return self.dateSectionHeight;
            break;
        case contentSection:
            return self.contentSectionHeight;
            break;
        default:
            break;
    }
    return 0;
}
#pragma mark -
#pragma mark - Private methods

-(cellIdentificator)compareIndexPath:(NSIndexPath*)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                return TitleCell;
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                return DateCell;
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                return ContentCell;
            }
            break;
        default:
            break;
    }
    return UnknowCell;
}


#pragma mark -
#pragma mark - IBActions

- (IBAction)doneTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - Getters & Setters

#warning Relativizar todos los numeros

-(CGFloat)titleRowHeight{
    if (!_titleRowHeight) {
        _titleRowHeight = 155;
    }
    return _titleRowHeight;
}
-(CGFloat)dateRowHeight{
    if (!_dateRowHeight) {
        _dateRowHeight = 0;
    }
    return _dateRowHeight;
}
-(CGFloat)contentRowHeight{
    if (!_contentRowHeight) {
        _contentRowHeight = 0;
    }
    return _contentRowHeight;
}

-(CGFloat)titleSectionHeight{
    if (!_titleSectionHeight) {
        _titleSectionHeight = 25;
    }
    return _titleSectionHeight;
}

-(CGFloat)dateSectionHeight{
    if (!_dateSectionHeight) {
        _dateSectionHeight = 55;
    }
    return _dateSectionHeight;
}
-(CGFloat)contentSectionHeight{
    if (!_contentSectionHeight) {
        _contentSectionHeight = 55;
    }
    return _contentSectionHeight;
}

-(NSIndexPath *)titlePath{
    if (!_titlePath) {
        _titlePath = [NSIndexPath indexPathForRow:0 inSection:1];
    }
    return _titlePath;
}
-(NSIndexPath *)datePath{
    if (!_datePath) {
        _datePath = [NSIndexPath indexPathForRow:0 inSection:2];
    }
   return _datePath;
}
-(NSIndexPath *)contentPath{
    if (!_contentPath) {
        _contentPath = [NSIndexPath indexPathForRow:0 inSection:3];
    }
    return _contentPath;
}
@end