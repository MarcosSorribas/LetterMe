//
//  MSCreateLettersTableViewController.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 17/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSCreateLettersTableViewController.h"

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

@end

@implementation MSCreateLettersTableViewController

#pragma mark -
#pragma mark - Constans

NSUInteger const numberOfSections = 3;
NSUInteger const numberOfRowsInSection = 1;

NSUInteger const titleSection = 0;
NSUInteger const dateSection = 1;
NSUInteger const contentSection = 2;

NSString * const titleClassCellName = @"MSTitleTableViewCell";
NSString * const dateClassCellName = @"MSDateTableViewCell";
NSString * const contentClassCellName = @"MSContentTableViewCell";

NSString *const titleSectionViewName = @"MSTitleSectionView";
NSString *const dateSectionViewName = @"MSDateSectionView";
NSString *const contentSectionViewName = @"MSContentSectionView";

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
            cell = [tableView dequeueReusableCellWithIdentifier:titleClassCellName forIndexPath:indexPath];
            break;
        case DateCell:
            cell = [tableView dequeueReusableCellWithIdentifier:dateClassCellName forIndexPath:indexPath];
            break;
        case ContentCell:
            cell = [tableView dequeueReusableCellWithIdentifier:contentClassCellName forIndexPath:indexPath];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view;
    UITapGestureRecognizer *tapGesture;
    switch (section) {
        case titleSection:
            view = [[[NSBundle mainBundle] loadNibNamed:titleSectionViewName owner:self options:nil]firstObject];
            tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleSectionTouched)];
            break;
        case dateSection:
            view = [[[NSBundle mainBundle] loadNibNamed:dateSectionViewName owner:self options:nil] firstObject];
            tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateSectionTouched)];
            break;
        case contentSection:
            view = [[[NSBundle mainBundle] loadNibNamed:contentSectionViewName owner:self options:nil] firstObject];
            tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentSectionTouched)];
            break;
        default:
            break;
    }
    [view addGestureRecognizer:tapGesture];
    return view;
}

#pragma mark -
#pragma mark - Private methods

-(void)titleSectionTouched{
    [self.tableView beginUpdates];
    
    
    [self.tableView endUpdates];
}

-(void)dateSectionTouched{
    [self.tableView beginUpdates];
    self.titleRowHeight = 1;
    self.titleSectionHeight = 55;
    

    NSMutableIndexSet *set = [[NSMutableIndexSet alloc]initWithIndex:0];
    [set addIndex:1];
    [set addIndex:2];
    
    self.dateRowHeight = 355;
    self.dateSectionHeight = 25;

    self.contentRowHeight = 1;
    self.contentSectionHeight = 70;
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];

   // [self.tableView reloadData];
    [self resignFirstResponder];
    [self.tableView endUpdates];
}

-(void)contentSectionTouched{
    [self.tableView beginUpdates];
    
    
    [self.tableView endUpdates];
}


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
- (IBAction)cancelTouched:(id)sender {
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