//
//  AppDelegate.m
//  HRInOutView
//
//  Created by 0xFF on 10/14/14.
//  Copyright (c) 2014 0xFF. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
-(void)awakeFromNib
{
    [super awakeFromNib];
    stateView.totalPeices = 5;
    stateView.vPadding = 1.5f;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
-(IBAction)inClicked:(id)sender
{
    stateView.inState = !stateView.inState;
}
-(IBAction)outClicked:(id)sender
{
    stateView.outState = !stateView.outState;
}
@end
