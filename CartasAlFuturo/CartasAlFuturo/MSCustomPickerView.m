//
//  MSCustomPickerView.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 19/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSCustomPickerView.h"

@interface MSCustomPickerView ()
@property (copy,nonatomic) NSArray *pickerComponents;
@property (copy,nonatomic) NSArray *datesPickerComponentes;
@end

@implementation MSCustomPickerView

#pragma mark -
#pragma mark - UIPickerView Datasource methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerComponents.count;
}

#pragma mark -
#pragma mark - UIPickerView Delegate methods 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.delegate dateDidSelect:self.datesPickerComponentes[row] andHisName:self.pickerComponents[row]];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = self.pickerComponents[row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
    
}

#pragma mark -
#pragma mark - Getters & Setters

-(NSArray *)pickerComponents{
    if (!_pickerComponents) {
        _pickerComponents = @[@"Dentro de un dia",@"Dentro de tres dias",@"Dentro de una semana",@"Dentro de tres semanas",@"Dentro de un mes",@"Dentro de tres meses",@"Dentro de seis meses",@"Dentro de nueve meses",@"Dentro de un año",@"Dentro de tres años"];
    }
    return _pickerComponents;
}
-(NSArray *)datesPickerComponentes{
    if (!_datesPickerComponentes) {
        _datesPickerComponentes = @[[NSDate dateWithTimeIntervalSinceNow:60*60*24],[NSDate dateWithTimeIntervalSinceNow:60*60*24*3],[NSDate dateWithTimeIntervalSinceNow:60*60*24*7],[NSDate dateWithTimeIntervalSinceNow:60*60*24*7*3],[NSDate dateWithTimeIntervalSinceNow:60*60*24*30],[NSDate dateWithTimeIntervalSinceNow:60*60*24*30*3],[NSDate dateWithTimeIntervalSinceNow:60*60*24*30*6],[NSDate dateWithTimeIntervalSinceNow:60*60*24*30*9],[NSDate dateWithTimeIntervalSinceNow:60*60*24*365],[NSDate dateWithTimeIntervalSinceNow:60*60*24*30*365*3]];
    }
    return _datesPickerComponentes;
}
@end
