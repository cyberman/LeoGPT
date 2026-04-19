#import "LGMainWindowController.h"
#import "../Support/LGVersion.h"

@implementation LGMainWindowController

- (id)init
{
    NSRect frame;
    NSWindow *window;

    frame = NSMakeRect(100.0, 100.0, 900.0, 600.0);

    window = [[NSWindow alloc] initWithContentRect:frame
                                         styleMask:(NSTitledWindowMask |
                                                    NSClosableWindowMask |
                                                    NSMiniaturizableWindowMask |
                                                    NSResizableWindowMask)
                                           backing:NSBackingStoreBuffered
                                             defer:NO];

    self = [super initWithWindow:window];
    [window release];

    if (self != nil) {
        [[self window] setTitle:[NSString stringWithUTF8String:LG_APP_NAME]];
    }

    return self;
}

@end

