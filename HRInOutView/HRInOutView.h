//
//  HRInOutView.h
//  HRInOutView
//
//  Created by 0xFF on 10/14/14.
//  Copyright (c) 2014 0xFF. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HRInOutView : NSView
@property (nonatomic,assign) NSInteger totalPeices;
@property (nonatomic,assign) BOOL inState;
@property (nonatomic,assign) BOOL outState;
@property (nonatomic,assign) CGFloat hPadding;
@property (nonatomic,assign) CGFloat vPadding;
@end
