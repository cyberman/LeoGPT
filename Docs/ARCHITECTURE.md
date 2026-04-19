
# LeoGPT Architecture

## 1. Purpose

LeoGPT is a native AI client for **Mac OS X Leopard (10.5)**.

It is not intended to be a modern web application disguised as a desktop app.  
It is intended to be a **Leopard application for modern AI services**.

The project draws structural inspiration from AmigaGPT, but it does **not** attempt to reproduce AmigaOS concepts, UI patterns, or dependencies on the Mac.

Core principle:

> LeoGPT is not a modern app on an old Mac.  
> It is a Leopard app for a modern service.

---

## 2. Product Goal

LeoGPT should feel like a small, elegant Leopard-era productivity tool that happens to speak to modern AI endpoints.

It should prioritize:

- native Mac behavior
- clear typography
- low visual noise
- focused functionality
- strong separation of UI and service logic
- minimal dependency burden
- platform-appropriate persistence and credential handling

It should avoid:

- browser-style architecture
- Electron-like layering
- mobile chat aesthetics
- visible retro-port compromises
- carrying Amiga-specific UI thinking into Cocoa

---

## 3. Toolchain Baseline

LeoGPT is designed against a deliberately conservative Leopard-era toolchain.

### Baseline
- **Xcode 3.1.4**
- **Mac OS X Leopard (10.5)**
- **PowerPC target**
- **Objective-C 2.0**
- **manual memory management**
- **C-based core modules**
- **Cocoa/AppKit UI**

### Consequences
This baseline implies the following rules:

- no ARC
- no Blocks-based architecture
- no reliance on later Cocoa conveniences
- no implementation style that assumes a modern Clang toolchain
- no hidden complexity behind newer language features

### Architecture impact
This strengthens the project direction rather than weakening it.

LeoGPT should be built as:

- a classic Cocoa application shell
- a disciplined C service core
- thin Leopard-native platform bridges

### Memory management rule
All Objective-C code must follow explicit ownership rules using:

- `retain`
- `release`
- `autorelease`

Object lifetimes must remain easy to reason about.

### UI construction rule
NIB-based window construction is acceptable and historically appropriate, but application logic must remain in code.

Interface Builder may define structure.  
It must not become the primary home of behavior.

### Core rule
Core modules should remain straightforward and portable in style.

The core should prefer:
- explicit data ownership
- small functions
- low hidden state
- minimal platform assumptions

### Design intent
LeoGPT should not only look like a Leopard application.  
It should also be implemented in a style that respects its actual development era.

---

## 4. Platform Philosophy

### 4.1 Leopard is the reference
Leopard defines the UX standard.

The app should behave like a good Leopard application in terms of:

- window structure
- menu design
- toolbar behavior
- preferences handling
- text editing
- dialogs
- save/load flows
- keyboard shortcuts
- application lifecycle

### 4.2 AmigaGPT is a structural source, not a visual source
AmigaGPT is useful because it proves that a slim native AI client is feasible on resource-constrained legacy systems.

LeoGPT inherits from that idea:

- thin native client
- strong functional decomposition
- platform-integrated application
- no browser dependency

LeoGPT does **not** inherit:

- MUI design language
- requester-heavy workflows
- ARexx-based automation model
- Amiga-specific menu/dialog conventions
- Amiga dependency patterns

---

## 5. High-Level Architecture

LeoGPT is split into three layers:

1. **Cocoa shell**
2. **Core services in C**
3. **Platform bridges**

### 5.1 Cocoa shell
The Cocoa shell is responsible for all user-visible behavior.

Responsibilities:

- application lifecycle
- main window
- toolbar
- menus
- conversation list UI
- transcript rendering
- compose input
- preferences UI
- alerts and panels
- document-like save/load interactions

This layer should be written in Objective-C using AppKit.

### 5.2 Core services
The core contains application logic that should remain independent of Cocoa wherever practical.

Responsibilities:

- conversation model
- message role handling
- model catalog
- request building
- response parsing
- transcript storage format
- settings model
- non-UI error model

This layer should be written in C.

### 5.3 Platform bridges
This layer connects the platform-neutral core to Leopard-native services.

Responsibilities:

- network transport bridge
- defaults bridge
- keychain bridge
- file system integration helpers
- optional speech bridge in later versions

This layer may use Objective-C and Foundation/AppKit as needed.

---

## 6. Layer Boundaries

### 6.1 Core must not know Cocoa UI
The core must not depend on:

- `NSWindow`
- `NSTextView`
- `NSMenu`
- `NSAlert`
- view state
- toolbar state
- UI object lifecycles

The core should expose plain structures and functions.

### 6.2 UI must not embed business logic
The UI layer may coordinate actions, but it should not become the permanent home of:

- request serialization
- model definitions
- transcript format rules
- configuration file structure
- endpoint logic

### 6.3 Platform bridges isolate Leopard-specific implementation
Any use of:

- `NSUserDefaults`
- Keychain
- `NSURLConnection`
- `NSString` / `NSData` conversion helpers
- save panels / open panels

should be kept out of the core wherever reasonable.

---

## 7. Main Application Structure

### 7.1 Main window
The main window is the central workspace.

Layout:

- **left sidebar**: conversation list
- **right upper area**: transcript view
- **right lower area**: composer area

This should feel closer to a document-oriented Leopard productivity tool than to a phone-style messenger.

### 7.2 Conversation list
The conversation list shows stored sessions.

Typical grouping:

- Today
- Yesterday
- Earlier

Each item should display:

- title
- optional timestamp or preview metadata

### 7.3 Transcript view
The transcript is the main reading surface.

Rules:

- text-first
- calm visual hierarchy
- no chat bubbles in V1
- no embedded HTML rendering
- minimal formatting only where useful

Suggested presentation:

- bold role headers
- comfortable spacing
- plain text by default
- optional code styling later

### 7.4 Composer area
The composer provides:

- multi-line input
- send action
- stop action
- model selector
- status text if needed

This area should be efficient, not flashy.

---

## 8. Preferences Model

LeoGPT should use a real Mac preferences window rather than multiple requester-style dialogs.

Suggested preference sections:

- General
- Connection
- Models
- Images
- Advanced

### 8.1 General
Examples:

- auto-save chats
- restore last session
- transcript font size
- default export behavior

### 8.2 Connection
Examples:

- endpoint type
- server URL
- proxy settings
- SSL behavior where relevant
- API key status

### 8.3 Models
Examples:

- default chat model
- refreshed model list
- endpoint-specific availability

### 8.4 Images
Examples:

- default image model
- default image size
- output directory

### 8.5 Advanced
Examples:

- timeout
- debug logging
- raw response capture

---

## 9. Persistence Strategy

### 9.1 Preferences
General application settings should use `NSUserDefaults`.

### 9.2 Credentials
Sensitive credentials such as API keys must use the Mac Keychain.

They must not be stored in plain configuration files.

### 9.3 Conversation storage
Conversation data should be stored in a LeoGPT-controlled application support directory.

Suggested location:

`~/Library/Application Support/LeoGPT/Chats/`

Storage goals:

- UTF-8 safe
- easy to inspect
- stable enough for export/import later
- decoupled from UI widgets

A simple JSON-based transcript format is acceptable for V1.

### 9.4 Export
V1 export targets:

- plain text
- JSON

Do not introduce HTML export complexity in V1 unless it becomes necessary.

---

## 10. Networking Strategy

LeoGPT should not reproduce Amiga networking patterns on the Mac.

Preferred direction for Leopard:

- Leopard-native HTTP transport
- Leopard-native SSL/TLS handling
- Foundation-oriented string/data conversions
- clean endpoint abstraction above transport

The service layer should support:

- OpenAI-compatible endpoints
- custom server URL
- proxy-aware routing if needed

The network layer should be replaceable without rewriting the conversation model.

---

## 11. Proposed Source Tree

```text
LeoGPT/
├── LICENSE
├── README.md
├── LeoGPT.xcodeproj
├── Resources/
│   ├── Info.plist
│   ├── LeoGPT.icns
│   └── Localizable.strings
├── Sources/
│   ├── App/
│   │   ├── LGAppDelegate.h
│   │   ├── LGAppDelegate.m
│   │   ├── LGMainWindowController.h
│   │   ├── LGMainWindowController.m
│   │   ├── LGPreferencesWindowController.h
│   │   └── LGPreferencesWindowController.m
│   ├── UI/
│   │   ├── LGConversationListController.h
│   │   ├── LGConversationListController.m
│   │   ├── LGTranscriptViewController.h
│   │   ├── LGTranscriptViewController.m
│   │   ├── LGComposerViewController.h
│   │   └── LGComposerViewController.m
│   ├── Core/
│   │   ├── LGConversation.h
│   │   ├── LGConversation.c
│   │   ├── LGModelCatalog.h
│   │   ├── LGModelCatalog.c
│   │   ├── LGSettings.h
│   │   ├── LGSettings.c
│   │   ├── LGService.h
│   │   ├── LGService.c
│   │   ├── LGTranscriptStore.h
│   │   ├── LGTranscriptStore.c
│   │   ├── LGError.h
│   │   └── LGError.c
│   ├── Platform/
│   │   ├── LGKeychain.h
│   │   ├── LGKeychain.m
│   │   ├── LGNetworkBridge.h
│   │   ├── LGNetworkBridge.m
│   │   ├── LGDefaultsBridge.h
│   │   └── LGDefaultsBridge.m
│   └── Support/
│       ├── LGTypes.h
│       ├── LGVersion.h
│       └── LGUtilities.h
└── Docs/
    ├── ARCHITECTURE.md
    ├── UI_GUIDE.md
    └── PORTING_NOTES_FROM_AMIGAGPT.md
````

---

## 12. Core Modules

### 12.1 `LGConversation`

Responsibilities:

- message list
    
- role assignment
    
- timestamps
    
- chat title metadata
    
- append/remove/update operations
    

This is the canonical conversation data model.

### 12.2 `LGModelCatalog`

Responsibilities:

- known model identifiers
    
- endpoint-dependent availability
    
- display names
    
- default selections
    

This module should keep model logic out of the UI.

### 12.3 `LGSettings`

Responsibilities:

- in-memory settings model
    
- default values
    
- validation
    
- conversion to and from bridge formats
    

This module should not directly call `NSUserDefaults`.

### 12.4 `LGService`

Responsibilities:

- request construction
    
- endpoint abstraction
    
- response parsing
    
- service-level errors
    
- chat/image request dispatch interface
    

This is the main functional descendant of the useful parts of `openai.c`.

### 12.5 `LGTranscriptStore`

Responsibilities:

- save conversation to file
    
- load conversation from file
    
- export plain text
    
- maintain stable transcript schema
    

### 12.6 `LGError`

Responsibilities:

- internal error categories
    
- user-safe error messages
    
- service and persistence error domains
    

---

## 13. Cocoa Components

### 13.1 `LGAppDelegate`

Responsibilities:

- app startup
    
- menu-level app actions
    
- initialization flow
    
- main window creation
    
- preferences window access
    

### 13.2 `LGMainWindowController`

Responsibilities:

- manage overall main window state
    
- connect sidebar, transcript, and composer
    
- route user actions into the core layer
    

### 13.3 `LGConversationListController`

Responsibilities:

- display conversation list
    
- grouping and selection
    
- rename/delete actions
    
- reload list from store
    

### 13.4 `LGTranscriptViewController`

Responsibilities:

- render transcript text
    
- update visible conversation
    
- support copy/select/find behavior
    
- remain text-first in V1
    

### 13.5 `LGComposerViewController`

Responsibilities:

- input capture
    
- send/stop actions
    
- model popup state
    
- status feedback
    

### 13.6 `LGPreferencesWindowController`

Responsibilities:

- display preferences sections
    
- sync UI values to platform bridges
    
- request credential changes via keychain bridge
    

---

## 14. Porting Guidance from AmigaGPT

The AmigaGPT codebase should be treated as follows:

### 14.1 Reuse as design input

Useful sources of structure:

- conversation and role concepts
    
- model catalog concepts
    
- endpoint abstraction concepts
    
- settings inventory
    
- feature scoping discipline
    

### 14.2 Extract, do not port directly

Files such as:

- `openai.c`
    
- `openai.h`
    
- `config.c`
    
- `config.h`
    

should be mined for logic and data structures, then rewritten into LeoGPT-native modules.

### 14.3 Replace entirely

Files such as:

- main window code
    
- menu code
    
- requester windows
    
- custom text editor code
    
- ARexx integration
    
- Amiga UI glue
    

must be replaced with Cocoa-native implementations.

---

## 15. V1 Scope

### 15.1 Included

- create conversation
    
- send message
    
- receive response
    
- save/load chats
    
- select model
    
- configure endpoint
    
- configure proxy if needed
    
- copy/export transcript
    
- basic error reporting
    

### 15.2 Deferred

- AppleScript automation
    
- local speech synthesis
    
- remote TTS
    
- advanced transcript formatting
    
- drag and drop uploads
    
- plug-in architecture
    
- HTML transcript rendering
    
- local LLM execution on PPC hardware
    

The architecture should allow later expansion, but V1 must remain disciplined.

---

## 16. Design Rules

1. **Leopard decides the visible form.**
    
2. **The core remains UI-agnostic.**
    
3. **Credentials belong in Keychain, not plain files.**
    
4. **Text-first beats feature noise.**
    
5. **V1 must stay smaller than the temptation.**
    
6. **AmigaGPT informs structure, not appearance.**
    
7. **Do not solve Mac problems with Amiga habits.**
    

---

## 17. Final Statement

LeoGPT should not feel like a rescued project from another platform.

It should feel like a real Leopard application:  
small, clear, native, and dignified.

That is the architectural standard.

