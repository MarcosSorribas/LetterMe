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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        tView.textAlignment = NSTextAlignmentCenter;
    }
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:self.pickerComponents[row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:FONT_HELVETICA_NEUE_LIGHT size:22.0], NSKernAttributeName:@0.2}];
    tView.attributedText = attString;
    return tView;
}

#pragma mark -
#pragma mark - Getters & Setters

-(NSArray *)pickerComponents{
    if (!_pickerComponents) {
        _pickerComponents = @[@"Dentro de un día",@"Dentro de tres días",@"Dentro de una semana",@"Dentro de tres semanas",@"Dentro de un mes",@"Dentro de tres meses",@"Dentro de seis meses",@"Dentro de nueve meses",@"Dentro de un año",@"Dentro de tres años"];
    }
    return _pickerComponents;
}

-(NSArray *)datesPickerComponentes{
    NSInteger daySeconds = 60*60*24;
    if (!_datesPickerComponentes) {
        _datesPickerComponentes = @[[NSDate dateWithTimeIntervalSinceNow:daySeconds],[NSDate dateWithTimeIntervalSinceNow:daySeconds*3],[NSDate dateWithTimeIntervalSinceNow:daySeconds*7],[NSDate dateWithTimeIntervalSinceNow:daySeconds*7*3],[NSDate dateWithTimeIntervalSinceNow:daySeconds*30],[NSDate dateWithTimeIntervalSinceNow:daySeconds*30*3],[NSDate dateWithTimeIntervalSinceNow:daySeconds*30*6],[NSDate dateWithTimeIntervalSinceNow:daySeconds*30*9],[NSDate dateWithTimeIntervalSinceNow:daySeconds*365],[NSDate dateWithTimeIntervalSinceNow:daySeconds*365*3]];
    }
    return _datesPickerComponentes;
}

@end
