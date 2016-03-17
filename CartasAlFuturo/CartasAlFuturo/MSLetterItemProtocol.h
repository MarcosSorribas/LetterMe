//
//  MSLetterItemProtocol.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 19/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MSCellDrawerProtocol;

@protocol MSLetterItemProtocol <NSObject>
@property (strong,nonatomic) id<MSCellDrawerProtocol> cellDrawer;

@end
