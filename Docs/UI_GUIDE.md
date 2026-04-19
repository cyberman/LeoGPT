
# LeoGPT UI Guide

## 1. Purpose

This document defines the visual and interaction principles for **LeoGPT**.

LeoGPT is a **native Leopard application**.  
Its interface should feel like it belongs on **Mac OS X 10.5**, not like a modern web client forced into an old desktop environment.

The UI must express:

- clarity
- restraint
- native behavior
- readable typography
- low friction
- platform dignity

It must avoid:

- browser disguise
- mobile chat aesthetics
- excessive ornament
- retro parody
- visible porting scars
- UI ideas inherited from AmigaGPT where Leopard has a better native answer

---

## 2. Core UI Principle

> LeoGPT should feel like a small, elegant Leopard productivity app.

It is not a messenger clone.  
It is not a social UI.  
It is not a browser tab pretending to be software.

It is a **text-first working tool**.

That means:

- calm layout
- strong readability
- minimal chrome
- familiar Mac controls
- predictable menu and toolbar actions
- clear separation between reading, selecting, composing, and configuring

---

## 3. Leopard as the Visual Standard

Leopard is the standard for all visible decisions.

The UI should align with Leopard-era expectations in:

- window proportions
- toolbar density
- sidebar usage
- panel behavior
- menu naming
- preferences design
- typography
- icon restraint
- keyboard shortcut conventions

The question to ask for every visible choice is:

> Would this feel normal in a good Leopard app?

If not, redesign it.

---

## 4. Visual Tone

LeoGPT should look:

- clean
- calm
- serious
- elegant
- modest
- capable

It should not look:

- playful
- loud
- toy-like
- chat-bubbly
- futuristic for its own sake
- web-native
- faux-retro

The desired impression is:

**a compact Leopard-era work tool with unusually modern service reach.**

---

## 5. Main Window

## 5.1 Layout overview

The main window is split into two primary regions:

- **left sidebar** for conversations
- **right content area** for transcript and composition

The right content area is vertically divided into:

- transcript
- composer

This creates a stable, document-like workspace.

### High-level layout

```text
+--------------------------------------------------------------+
| Toolbar                                                      |
+----------------------+---------------------------------------+
| Conversation List    | Transcript View                       |
|                      |                                       |
|                      |                                       |
|                      |                                       |
|                      +---------------------------------------+
|                      | Composer Area                         |
|                      | [multi-line input]      [Send]        |
+----------------------+---------------------------------------+
````

---

## 5.2 Sidebar

The sidebar should behave like a familiar Leopard source list.

### Responsibilities

- show existing conversations
    
- indicate current selection
    
- support rename/delete actions
    
- provide a calm overview of chat history
    

### Visual style

- narrow but comfortable
    
- no oversized row height
    
- readable titles
    
- optional subtle metadata
    
- selection should feel native, not custom-themed
    

### Grouping

Suggested groups:

- Today
    
- Yesterday
    
- Earlier
    

Do not overcomplicate grouping in V1.

### Sidebar content

Each row may show:

- conversation title
    
- optional timestamp or date
    
- optional subtle preview later, but not required in V1
    

### Sidebar behavior

The sidebar must not feel like a mail client clone with too much density, but it may borrow from:

- Mail
    
- iChat buddy/sidebar calmness
    
- iTunes source list discipline
    

---

## 5.3 Transcript view

The transcript is the main reading surface and should receive most of the visual respect.

### Design goal

It should feel more like a readable working transcript than a chat toy.

### Presentation rules

- no speech bubbles in V1
    
- no HTML rendering in V1
    
- no web-like cards
    
- no fake app-store gloss
    
- no visual clutter between entries
    

### Preferred structure

Each message should render as:

- role heading
    
- message body
    
- spacing
    
- optional divider only if needed
    

Example:

```text
You
Can you summarize this document?

Assistant
Yes. Here is a concise summary...
```

### Typography

The transcript should prioritize:

- readability
    
- line stability
    
- comfortable spacing
    
- long-form reading comfort
    

### Code handling

For V1:

- code may appear in the same transcript view
    
- a monospaced styling treatment may be added later
    
- full rich formatting is not required initially
    

### Scrolling behavior

- standard Cocoa scrolling
    
- predictable selection/copy behavior
    
- transcript should not fight the user
    

---

## 5.4 Composer area

The composer is the input region at the bottom of the main window.

### Contents

- multi-line text input
    
- Send button
    
- optional Stop button
    
- model selector
    
- optional subtle status text
    

### Style

- modest
    
- efficient
    
- not oversized
    
- not “message bubble composer” themed
    

### Interaction goal

The composer should feel closer to a writing tool than to an instant messenger box.

### Button emphasis

- Send should be clear but not dramatic
    
- Stop should be available when needed
    
- controls should feel integrated, not panel-heavy
    

---

## 6. Toolbar

The toolbar should follow Leopard-era Mac application conventions.

## 6.1 V1 toolbar items

Recommended items:

- **New**
    
- **Save**
    
- **Copy**
    
- **Stop**
    
- **Model**
    
- **Preferences**
    

Optional later:

- **Image**
    
- **Export**
    

## 6.2 Toolbar behavior

- use standard Leopard toolbar behavior
    
- allow labels where appropriate
    
- do not overload the toolbar
    
- every item should justify its space
    

## 6.3 What the toolbar should not become

The toolbar must not become:

- a debug console
    
- a model laboratory
    
- a token monitor wall
    
- a developer control strip
    

LeoGPT is an application first, not a dashboard.

---

## 7. Menus

Menus must be fully Mac-native.

They should feel ordinary to a Leopard user.

## 7.1 App menu

Include:

- About LeoGPT
    
- Preferences…
    
- Services
    
- Hide LeoGPT
    
- Hide Others
    
- Show All
    
- Quit LeoGPT
    

## 7.2 File menu

Include:

- New Chat
    
- Open Transcript…
    
- Save
    
- Save As…
    
- Export Transcript…
    
- Close
    

## 7.3 Edit menu

Include:

- Undo
    
- Redo
    
- Cut
    
- Copy
    
- Paste
    
- Select All
    
- Find…
    

## 7.4 Chat menu

Include:

- Send Message
    
- Stop Response
    
- Rename Chat
    
- Delete Chat
    
- Duplicate Chat
    
- Clear Transcript
    

## 7.5 Model menu

Include:

- Default Model
    
- Refresh Models
    
- Endpoint Preset
    

## 7.6 Window menu

Include:

- Minimize
    
- Bring All to Front
    

## 7.7 Help menu

Include:

- LeoGPT Help
    
- Connection Guide
    

### Menu rule

Do not carry over Amiga command grouping logic if it conflicts with Mac expectations.

---

## 8. Preferences Window

LeoGPT should use a proper Leopard-style Preferences window rather than multiple small requester-style dialogs.

## 8.1 Preferences structure

Recommended sections:

- General
    
- Connection
    
- Models
    
- Images
    
- Advanced
    

## 8.2 Preferences style

- toolbar-based section switching
    
- stable window size where practical
    
- clear labels
    
- calm spacing
    
- no crowded admin-panel feeling
    

## 8.3 Section goals

### General

For user comfort and session behavior.

Examples:

- auto-save chats
    
- restore last session
    
- default font size
    

### Connection

For service and endpoint configuration.

Examples:

- endpoint URL
    
- proxy settings
    
- SSL-related options if needed
    
- API key management state
    

### Models

For model defaults and refresh behavior.

### Images

For image model and output location.

### Advanced

Only for settings that should not clutter common use.

---

## 9. Dialogs and Panels

LeoGPT should use standard Mac dialog behavior.

Use:

- `NSAlert` for confirmations/errors
    
- `NSOpenPanel` for loading files
    
- `NSSavePanel` for export/save-as flows
    
- standard About panel or a restrained custom About window
    

Do not use dialog behavior that feels like a transplanted foreign platform.

### Error dialogs

Errors should be:

- concise
    
- specific
    
- polite
    
- useful
    

Avoid:

- raw internal terminology unless in advanced/debug mode
    
- giant technical dumps in normal flow
    

---

## 10. Typography

Typography is one of the strongest tools LeoGPT has on Leopard.

## 10.1 General guidance

Text should feel:

- calm
    
- balanced
    
- readable over longer sessions
    

## 10.2 Transcript typography

The transcript should have:

- clear role labels
    
- comfortable paragraph spacing
    
- sensible line length
    
- no artificially compressed presentation
    

## 10.3 Sidebar typography

The sidebar should prioritize:

- fast scanning
    
- title clarity
    
- low noise
    

## 10.4 Composer typography

The composer should feel like a real text entry field, not a decorative message widget.

### Rule

Text quality matters more than decoration.

---

## 11. Icons

Icons should be used with restraint.

## 11.1 Toolbar icons

Toolbar icons should:

- follow Leopard-era visual expectations
    
- be simple and clear
    
- support the action, not dominate it
    

## 11.2 App icon

The app icon may have stronger identity, but the in-app UI should remain disciplined.

## 11.3 Avoid

- hyper-modern flat-only visual language if it clashes with Leopard
    
- novelty icon overload
    
- cartooning the UI
    

---

## 12. Color and Contrast

LeoGPT should not depend on aggressive color coding.

### Use color sparingly for:

- focus
    
- selected state
    
- role emphasis if subtle
    
- status feedback when necessary
    

### Avoid:

- bright message-color systems
    
- social-chat color coding
    
- neon accents
    
- visually noisy backgrounds
    

The transcript must remain the primary focus, not the chrome.

---

## 13. Message Presentation Rules

For V1, the transcript should remain intentionally modest.

## 13.1 Role display

Display roles clearly:

- You
    
- Assistant
    
- optionally System only when relevant
    

## 13.2 Message body

Render message text simply and cleanly.

## 13.3 Message spacing

Use spacing to create structure rather than boxes and heavy separators.

## 13.4 Long messages

The UI must handle long messages gracefully without becoming visually exhausting.

---

## 14. Interaction Philosophy

LeoGPT should be pleasant because it is predictable.

### Key interaction goals

- obvious where to type
    
- obvious where to read
    
- obvious how to save/export
    
- obvious how to change model or endpoint
    
- obvious how to recover from an error
    

### Non-goals

Do not chase novelty interactions for their own sake.

No:

- hidden mode systems
    
- overloaded contextual tricks
    
- unnecessarily animated behaviors
    
- “modern chat app” mimicry
    

---

## 15. Keyboard Behavior

Keyboard interaction should feel like a normal Mac text application.

### Expected behavior

- standard text editing shortcuts
    
- clear send shortcut
    
- predictable copy/select behavior
    
- working focus traversal
    
- menu command consistency
    

### Rule

If a Leopard user can reasonably expect a shortcut, LeoGPT should honor that expectation.

---

## 16. Window Behavior

Window behavior should follow standard Mac norms.

### Requirements

- proper resizing
    
- sensible minimum size
    
- stable layout during resize
    
- normal close/minimize/zoom behavior
    
- no custom chrome experiments
    

### Rule

Do not make the window itself a design statement.  
Let the content carry the application.

---

## 17. What LeoGPT Must Avoid

LeoGPT must not visually drift into any of the following:

### 17.1 Web app disguise

Symptoms:

- card-heavy layout
    
- browser-like content zones
    
- awkward faux-tab UI
    
- HTML-style rendering assumptions
    

### 17.2 Mobile chat imitation

Symptoms:

- bubble chat aesthetic
    
- oversized input area
    
- social app visual language
    
- loud role colors
    

### 17.3 Amiga carryover

Symptoms:

- requester-driven UX where Preferences should exist
    
- menu or dialog logic shaped by source platform habits
    
- visible ported-app behavior
    

### 17.4 Overdesigned nostalgia

Symptoms:

- trying too hard to “look retro”
    
- parodying Leopard instead of belonging to it
    

---

## 18. V1 Visual Reduction Rules

When uncertain, reduce.

Prefer:

- simpler transcript styling
    
- fewer controls
    
- one good Preferences window
    
- one strong main workflow
    
- clean spacing over extra decoration
    

The interface should earn trust through discipline.

---

## 19. Final UI Standard

The final visual test is simple:

> LeoGPT should look like a real Leopard application that happens to speak to modern AI services.

If the interface feels like:

- a browser app trapped in a window,
    
- a messenger clone,
    
- an Amiga app wearing a Mac costume,
    
- or a retro joke,
    

then the design has failed.

If it feels like:

- a compact,
    
- thoughtful,
    
- native,
    
- text-first Leopard tool,
    

then the design is on the right path.

