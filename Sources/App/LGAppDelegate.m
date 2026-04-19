#import "LGAppDelegate.h"
#import "LGMainWindowController.h"

@implementation LGAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    (void)notification;

    _mainWindowController = [[LGMainWindowController alloc] init];
    [_mainWindowController showWindow:self];
}

- (void)dealloc
{
    [_mainWindowController release];
    [super dealloc];
}

@end

