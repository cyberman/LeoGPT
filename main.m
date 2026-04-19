//
//  main.m
//  LeoGPT
//
//  Created by Administrator on 19.04.26.
//  Copyright __MyCompanyName__ 2026. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Sources/App/LGAppDelegate.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool;
    LGAppDelegate *delegate;

    pool = [[NSAutoreleasePool alloc] init];

    [NSApplication sharedApplication];

    delegate = [[LGAppDelegate alloc] init];
    [NSApp setDelegate:delegate];

    [NSBundle loadNibNamed:@"MainMenu" owner:NSApp];

    [NSApp run];

    [delegate release];
    [pool release];

    return 0;
}
