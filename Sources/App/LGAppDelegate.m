#import "LGAppDelegate.h"
#import "LGMainWindowController.h"

@implementation LGAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    (void)notification;

    _mainWindowController = [[LGMainWindowController alloc] init];
    [_mainWindowController showWindow:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    (void)sender;
    return YES;
}

- (void)dealloc
{
    [_mainWindowController release];
    [super dealloc];
}

@end
