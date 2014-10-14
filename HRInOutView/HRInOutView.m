//
//  HRInOutView.m
//  HRInOutView
//
//  Created by 0xFF on 10/14/14.
//  Copyright (c) 2014 0xFF. All rights reserved.
//

#import "HRInOutView.h"

@interface HRInOutView ()

@property (nonatomic,assign) NSInteger currentInIndex;
@property (nonatomic,assign) NSInteger currentOutIndex;
@property (nonatomic,strong) NSTimer * timer;
@end

@implementation HRInOutView
@synthesize timer = _timer;
@synthesize totalPeices = _totalPeices;
@synthesize inState = _inState;
@synthesize outState = _outState;
@synthesize currentInIndex = _currentInIndex;
@synthesize currentOutIndex = _currentOutIndex;
@synthesize hPadding = _hPadding;
@synthesize vPadding = _vPadding;

-(id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if(self)
    {
        _currentInIndex = 0;
        _currentOutIndex = 0;
        _totalPeices = 5;
        _hPadding = 2.5f;
        _vPadding = 1.2f;
    }
    return self;
}
-(void)setInState:(BOOL)inState
{
    if(_inState != inState)
    {
        _inState = inState;
        [self start];
    }
}
-(void)setOutState:(BOOL)outState
{
    if(_outState != outState)
    {
        _outState = outState;
        [self start];
    }
}
-(void)start
{
    if(!self.inState && !self.outState)
    {
        // Stop timer
        if(self.timer)
        {
            @try {
                [self.timer invalidate];
                self.timer = nil;
                self.currentInIndex = 0;
                self.currentOutIndex = 0;
                [self setNeedsDisplay:YES];
            }
            @catch (NSException *exception) {
                NSLog(@"Exception: %@",exception.reason);
            }
            
        }
        // Reset off state
        return;
    }
    if(!self.timer)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeElapse:) userInfo:nil repeats:YES];
    }
}

-(void)timeElapse:(id)sender
{
    if(self.inState)
    {
        [self setNeedsDisplay:YES];
        self.currentInIndex ++;
        if(self.currentInIndex >= self.totalPeices)
            self.currentInIndex = 0;
    }
    if(self.outState)
    {
        [self setNeedsDisplay:YES];
        self.currentOutIndex ++;
        if(self.currentOutIndex >= self.totalPeices)
            self.currentOutIndex = 0;
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Background
    [[NSColor clearColor] setFill];
    CGSize size = self.bounds.size;
    
    CGFloat x = self.hPadding;
    CGFloat startY = 1.0f;
    CGFloat yo = startY + 1.0f;
    CGFloat w = (size.width - self.hPadding*3)/2.0f;
    CGFloat h = size.height - startY*2.0f;
    
    CGFloat tinyH = (h-4 * self.vPadding) / (self.totalPeices+1);
    
    CGFloat yi = h-tinyH;


    NSColor * offStateColor = [NSColor lightGrayColor];
    NSColor * inStateColor = [NSColor colorWithSRGBRed:46.0/255.0 green:139.0/255.0 blue:85.0/255.0 alpha:1.0];
    NSColor * outStateColor = [NSColor redColor];
    // In: Top -> Bottom Out: Bottom -> Top
    for(int i = 0 ; i < self.totalPeices; ++ i)
    {
        // Draw line by line (Bottom to Up)
        if(i == 0) // First
        {
            // Draw in -> rectangle
            //[NSGraphicsContext saveGraphicsState];
            if(self.inState)
            {
                if(i <= self.currentInIndex)
                    [inStateColor setFill];
                else
                    [offStateColor setFill];
            }
            else [offStateColor setFill];
            NSRect rectI = NSMakeRect(x, yi, w, tinyH);
            [[NSBezierPath bezierPathWithRoundedRect:rectI xRadius:0 yRadius:0] fill];
            //[NSGraphicsContext restoreGraphicsState];
            // Draw out -> rectangle
           // [NSGraphicsContext saveGraphicsState];
            if(self.outState)
            {
                if(i <= self.currentOutIndex)
                    [outStateColor setFill];
                else
                    [offStateColor setFill];
            }
            else [offStateColor setFill];

            NSRect rectO = NSMakeRect(x+w+self.hPadding, yo, w, tinyH);
            [[NSBezierPath bezierPathWithRoundedRect:rectO xRadius:0 yRadius:0] fill];
            //[NSGraphicsContext restoreGraphicsState];
        }
        else if(i == self.totalPeices -1) // End
        {
            // Draw in -> triangle
            NSBezierPath *pathI = [NSBezierPath bezierPath];
            [pathI moveToPoint:NSMakePoint(x+w/2.0f, yi)];
            [pathI lineToPoint:NSMakePoint(x, yi+tinyH*2.0f)];
            [pathI lineToPoint:NSMakePoint(x+w, yi+tinyH*2.0f)];
            [pathI closePath];
            if(self.inState)
            {
                if(i <= self.currentInIndex)
                    [inStateColor set];
                else
                    [offStateColor set];
            }
            else [offStateColor set];
            [pathI fill];
            // Draw out -> triangle
            NSBezierPath *pathO = [NSBezierPath bezierPath];
            [pathO moveToPoint:NSMakePoint(x+w+self.hPadding+w/2.0, yo + tinyH*2)];
            [pathO lineToPoint:NSMakePoint(x+w+self.hPadding, yo)];
            [pathO lineToPoint:NSMakePoint(x+w+self.hPadding+w, yo)];
            [pathO closePath];
            if(self.outState)
            {
                if(i <= self.currentOutIndex)
                    [outStateColor set];
                else
                    [offStateColor set];
            }
            else [offStateColor set];
            [pathO fill];
        }
        else
        {
            // Draw both as rectangle
            // In
            //[NSGraphicsContext saveGraphicsState];
            if(self.inState)
            {
                if(i <= self.currentInIndex)
                    [inStateColor setFill];
                else
                    [offStateColor setFill];
            }
            else [offStateColor setFill];
            
            NSRect rectI = NSMakeRect(x, yi, w, tinyH);
            [[NSBezierPath bezierPathWithRoundedRect:rectI xRadius:0 yRadius:0] fill];
            //[NSGraphicsContext restoreGraphicsState];
            
            // Out
            if(self.outState)
            {
                if(i <= self.currentOutIndex)
                    [outStateColor setFill];
                else
                    [offStateColor setFill];
            }
            else [offStateColor setFill];
            NSRect rectO = NSMakeRect(x+w+self.hPadding, yo, w, tinyH);
            [[NSBezierPath bezierPathWithRoundedRect:rectO xRadius:0 yRadius:0] fill];
        }
        if(i == self.totalPeices-2)
        {
            yi = yi - self.vPadding  - tinyH * 2.0f;
        }
        else
        {
            yi = yi - self.vPadding - tinyH;
        }
        yo += tinyH + self.vPadding;
    }
}
@end
