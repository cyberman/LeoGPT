#import <Cocoa/Cocoa.h>

@interface LGMainWindowController : NSWindowController
{
    NSOutlineView *_conversationOutlineView;
    NSTextView *_transcriptView;
    NSTextView *_composerView;
    NSPopUpButton *_modelPopUpButton;
    NSButton *_sendButton;
}

- (void)sendMessage:(id)sender;

@end
