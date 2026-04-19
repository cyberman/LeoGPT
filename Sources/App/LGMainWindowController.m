#import "LGMainWindowController.h"
#import "../Support/LGVersion.h"
#import <float.h>

@interface LGMainWindowController ()
- (NSView *)buildContentViewForFrame:(NSRect)frame;
- (NSView *)buildSidebarWithFrame:(NSRect)frame;
- (NSView *)buildMainAreaWithFrame:(NSRect)frame;
- (NSScrollView *)buildTranscriptAreaWithFrame:(NSRect)frame;
- (NSView *)buildComposerAreaWithFrame:(NSRect)frame;
@end

@implementation LGMainWindowController

- (id)init
{
    NSRect frame;
    NSWindow *window;
    NSView *contentView;

    frame = NSMakeRect(120.0, 120.0, 920.0, 640.0);

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
        [[self window] setMinSize:NSMakeSize(720.0, 480.0)];

        contentView = [self buildContentViewForFrame:[[self window] contentRectForFrameRect:frame]];
        [[self window] setContentView:contentView];
    }

    return self;
}

- (NSView *)buildContentViewForFrame:(NSRect)frame
{
    NSView *rootView;
    NSView *sidebarView;
    NSView *mainAreaView;
    NSRect sidebarFrame;
    NSRect mainAreaFrame;
    CGFloat sidebarWidth;

    rootView = [[[NSView alloc] initWithFrame:frame] autorelease];

    sidebarWidth = 220.0;

    sidebarFrame = NSMakeRect(0.0, 0.0, sidebarWidth, frame.size.height);
    mainAreaFrame = NSMakeRect(sidebarWidth + 1.0, 0.0, frame.size.width - sidebarWidth - 1.0, frame.size.height);

    sidebarView = [self buildSidebarWithFrame:sidebarFrame];
    mainAreaView = [self buildMainAreaWithFrame:mainAreaFrame];

    [sidebarView setAutoresizingMask:NSViewHeightSizable];
    [mainAreaView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

    [rootView addSubview:sidebarView];
    [rootView addSubview:mainAreaView];

    return rootView;
}

- (NSView *)buildSidebarWithFrame:(NSRect)frame
{
    NSView *sidebarContainer;
    NSScrollView *scrollView;
    NSTableColumn *column;
    NSRect bounds;

    sidebarContainer = [[[NSView alloc] initWithFrame:frame] autorelease];
    bounds = [sidebarContainer bounds];

    scrollView = [[[NSScrollView alloc] initWithFrame:bounds] autorelease];
    [scrollView setBorderType:NSBezelBorder];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:NO];
    [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

    _conversationOutlineView = [[NSOutlineView alloc] initWithFrame:bounds];

    column = [[[NSTableColumn alloc] initWithIdentifier:@"conversation"] autorelease];
    [[column headerCell] setStringValue:@"Chats"];
    [column setWidth:bounds.size.width - 20.0];

    [_conversationOutlineView addTableColumn:column];
    [_conversationOutlineView setOutlineTableColumn:column];
    [_conversationOutlineView setHeaderView:nil];
    [_conversationOutlineView setRowHeight:20.0];
    [_conversationOutlineView setAutoresizesOutlineColumn:YES];

    [scrollView setDocumentView:_conversationOutlineView];
    [sidebarContainer addSubview:scrollView];

    return sidebarContainer;
}

- (NSView *)buildMainAreaWithFrame:(NSRect)frame
{
    NSView *mainAreaContainer;
    NSScrollView *transcriptScrollView;
    NSView *composerArea;
    NSBox *divider;
    NSRect transcriptFrame;
    NSRect composerFrame;
    CGFloat composerHeight;

    mainAreaContainer = [[[NSView alloc] initWithFrame:frame] autorelease];

    composerHeight = 128.0;

    transcriptFrame = NSMakeRect(0.0, composerHeight + 1.0, frame.size.width, frame.size.height - composerHeight - 1.0);
    composerFrame = NSMakeRect(0.0, 0.0, frame.size.width, composerHeight);

    transcriptScrollView = [self buildTranscriptAreaWithFrame:transcriptFrame];
    composerArea = [self buildComposerAreaWithFrame:composerFrame];

    divider = [[[NSBox alloc] initWithFrame:NSMakeRect(0.0, composerHeight, frame.size.width, 1.0)] autorelease];
    [divider setBoxType:NSBoxSeparator];
    [divider setAutoresizingMask:NSViewWidthSizable | NSViewMinYMargin];

    [transcriptScrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [composerArea setAutoresizingMask:NSViewWidthSizable | NSViewMaxYMargin];

    [mainAreaContainer addSubview:transcriptScrollView];
    [mainAreaContainer addSubview:divider];
    [mainAreaContainer addSubview:composerArea];

    return mainAreaContainer;
}

- (NSScrollView *)buildTranscriptAreaWithFrame:(NSRect)frame
{
    NSScrollView *scrollView;
    NSTextStorage *textStorage;
    NSLayoutManager *layoutManager;
    NSTextContainer *textContainer;

    scrollView = [[[NSScrollView alloc] initWithFrame:frame] autorelease];
    [scrollView setBorderType:NSBezelBorder];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:NO];

    textStorage = [[[NSTextStorage alloc] init] autorelease];
    layoutManager = [[[NSLayoutManager alloc] init] autorelease];
    [textStorage addLayoutManager:layoutManager];

    textContainer = [[[NSTextContainer alloc] initWithContainerSize:NSMakeSize(frame.size.width, FLT_MAX)] autorelease];
    [layoutManager addTextContainer:textContainer];

    _transcriptView = [[NSTextView alloc] initWithFrame:NSMakeRect(0.0, 0.0, frame.size.width, frame.size.height)
                                          textContainer:textContainer];

    [_transcriptView setEditable:NO];
    [_transcriptView setSelectable:YES];
    [_transcriptView setRichText:NO];
    [_transcriptView setImportsGraphics:NO];
    [_transcriptView setUsesFontPanel:NO];
    [_transcriptView setUsesFindPanel:YES];
    [_transcriptView setHorizontallyResizable:NO];
    [_transcriptView setVerticallyResizable:YES];
    [_transcriptView setAutoresizingMask:NSViewWidthSizable];
    [_transcriptView setFont:[NSFont systemFontOfSize:12.0]];

    [_transcriptView setString:@"Assistant\nWelcome to LeoGPT.\n\nThis is the first native Leopard window draft.\n"];

    [scrollView setDocumentView:_transcriptView];
    return scrollView;
}

- (NSView *)buildComposerAreaWithFrame:(NSRect)frame
{
    NSView *composerContainer;
    NSScrollView *composerScrollView;
    NSRect composerTextFrame;
    NSRect modelFrame;
    NSRect sendFrame;
    CGFloat padding;
    CGFloat controlsHeight;
    CGFloat buttonWidth;
    CGFloat popupWidth;

    composerContainer = [[[NSView alloc] initWithFrame:frame] autorelease];

    padding = 12.0;
    controlsHeight = 28.0;
    buttonWidth = 90.0;
    popupWidth = 180.0;

    composerTextFrame = NSMakeRect(padding,
                                   padding + controlsHeight + 8.0,
                                   frame.size.width - (padding * 2.0),
                                   frame.size.height - (padding * 2.0) - controlsHeight - 8.0);

    composerScrollView = [[[NSScrollView alloc] initWithFrame:composerTextFrame] autorelease];
    [composerScrollView setBorderType:NSBezelBorder];
    [composerScrollView setHasVerticalScroller:YES];
    [composerScrollView setHasHorizontalScroller:NO];
    [composerScrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

    _composerView = [[NSTextView alloc] initWithFrame:NSMakeRect(0.0, 0.0,
                                                                 composerTextFrame.size.width,
                                                                 composerTextFrame.size.height)];
    [_composerView setEditable:YES];
    [_composerView setSelectable:YES];
    [_composerView setRichText:NO];
    [_composerView setImportsGraphics:NO];
    [_composerView setUsesFontPanel:NO];
    [_composerView setFont:[NSFont systemFontOfSize:12.0]];
    [_composerView setString:@""];

    [composerScrollView setDocumentView:_composerView];
    [composerContainer addSubview:composerScrollView];

    modelFrame = NSMakeRect(padding,
                            padding,
                            popupWidth,
                            controlsHeight);

    _modelPopUpButton = [[NSPopUpButton alloc] initWithFrame:modelFrame pullsDown:NO];
    [_modelPopUpButton addItemWithTitle:@"gpt-4.1-mini"];
    [_modelPopUpButton addItemWithTitle:@"gpt-4.1"];
    [_modelPopUpButton addItemWithTitle:@"gpt-4.1-nano"];
    [_modelPopUpButton setAutoresizingMask:NSViewMaxXMargin | NSViewMaxYMargin];
    [composerContainer addSubview:_modelPopUpButton];

    sendFrame = NSMakeRect(frame.size.width - padding - buttonWidth,
                           padding,
                           buttonWidth,
                           controlsHeight);

    _sendButton = [[NSButton alloc] initWithFrame:sendFrame];
    [_sendButton setBezelStyle:NSRoundedBezelStyle];
    [_sendButton setTitle:@"Send"];
    [_sendButton setTarget:self];
    [_sendButton setAction:@selector(sendMessage:)];
    [_sendButton setAutoresizingMask:NSViewMinXMargin | NSViewMaxYMargin];
    [composerContainer addSubview:_sendButton];

    return composerContainer;
}

- (void)sendMessage:(id)sender
{
    NSString *existingText;
    NSString *inputText;
    NSString *newText;

    (void)sender;

    inputText = [_composerView string];
    if (inputText == nil || [inputText length] == 0) {
        NSBeep();
        return;
    }

    existingText = [_transcriptView string];
    if (existingText == nil) {
        existingText = @"";
    }

    newText = [NSString stringWithFormat:@"%@\nYou\n%@\n\nAssistant\n(Not connected yet — send action is wired.)\n",
                                         existingText,
                                         inputText];

    [_transcriptView setString:newText];
    [_composerView setString:@""];
}

- (void)dealloc
{
    [_conversationOutlineView release];
    [_transcriptView release];
    [_composerView release];
    [_modelPopUpButton release];
    [_sendButton release];
    [super dealloc];
}

@end
