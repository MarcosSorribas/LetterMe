//
//  MSCustomPickerView.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 19/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSCustomPickerViewDelegate <NSObject>

-(void)dateDidSelect:(NSDate*)date andHisName:(NSString*)name;

@end
@interface MSCustomPickerView : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,weak) id<MSCustomPickerViewDelegate> delegate;
@end
