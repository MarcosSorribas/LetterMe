//
//  MSMailMan.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 17/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSMailMan : NSObject

+(void)checkLettersPreparedAndUpdateThemInContext:(UIManagedDocument*)document;

-(void)showAlertViewIfLettersArePrepared:(UIManagedDocument*)document;

@end
