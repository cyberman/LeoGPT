# LeoGPT

LeoGPT is a native AI client for **Mac OS X Leopard (10.5)**.

It is not a modern web application disguised as a desktop app.  
It is a **Leopard application for modern AI services**.

## Philosophy

LeoGPT follows one core idea:

> LeoGPT is not a modern app on an old Mac.  
> It is a Leopard app for a modern service.

This means:

- native Cocoa/AppKit user interface
- text-first workflow
- clear separation between UI and service logic
- no browser dependency
- no Electron-style layering
- no visible foreign-platform carryover

LeoGPT is structurally informed by **AmigaGPT**, but it is **not** an AmigaOS-style port.  
It is designed as a **maximally native Leopard application**.

## Goals

LeoGPT aims to provide:

- a calm, Leopard-native main window
- conversation history in a sidebar
- transcript reading in a text-first layout
- a simple multi-line composer
- model selection
- endpoint and proxy configuration
- transcript save/load/export
- native Mac preferences and credential handling

## Non-Goals

LeoGPT does **not** aim to be:

- a browser wrapper
- a messenger clone
- a mobile-style chat UI
- a full-feature parity port of another client
- an Amiga application recreated on the Mac

## Architecture

LeoGPT is split into three layers:

### 1. Cocoa shell
Responsible for:

- app lifecycle
- main window
- toolbar
- menus
- preferences
- transcript UI
- conversation list UI
- composer UI
- alerts and panels

### 2. Core services in C
Responsible for:

- conversation model
- settings model
- model catalog
- request building
- response parsing
- transcript storage
- internal error handling

### 3. Platform bridges
Responsible for:

- defaults integration
- keychain integration
- network bridge
- later optional platform services

## Toolchain Baseline

LeoGPT is planned against a Leopard-era development baseline:

- Xcode 3.1.4
- Mac OS X 10.5
- PowerPC target
- Objective-C 2.0
- manual retain/release memory management
- Cocoa/AppKit for UI
- C for core logic

This is intentional.

LeoGPT should not be a modern codebase awkwardly forced backward.  
It should be a native Leopard project in both product form and implementation style.

## Project Structure

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
    ├── PORTING_NOTES_FROM_AMIGAGPT.md
    └── UI_GUIDE.md
````

## User Experience Direction

LeoGPT should feel like a small, elegant Leopard productivity tool.

UI principles:

- calm layout
    
- native menu structure
    
- Leopard-style toolbar
    
- sidebar plus transcript layout
    
- no chat bubbles in V1
    
- no HTML renderer in V1
    
- no unnecessary visual noise
    

Leopard is the visible standard.

## Planned V1 Scope

LeoGPT V1 should support:

- create conversation
    
- send prompt
    
- receive response
    
- save and load transcripts
    
- export transcript
    
- select model
    
- configure endpoint
    
- configure proxy if needed
    
- store credentials safely
    
- show clear error messages
    

## Deferred Features

Not part of V1 unless clearly justified:

- AppleScript automation
    
- speech synthesis
    
- advanced rich transcript rendering
    
- drag and drop uploads
    
- plugin architecture
    
- local LLM execution on PPC hardware
    

## Source Relationship to AmigaGPT

AmigaGPT is used as:

- proof of feasibility
    
- structural reference
    
- feature-scope reference
    
- service/core inspiration
    

It is **not** used as:

- UI template
    
- UX template
    
- dependency model
    
- direct platform pattern to imitate
    

The intended relationship is:

- extract useful logic
    
- rebuild natively
    
- preserve dignity of the destination platform
    

## Build Direction

Preferred direction:

- Cocoa/AppKit UI
    
- C core
    
- Leopard-native platform services where appropriate
    

General rule:

- visible form belongs to Leopard
    
- reusable logic belongs to the core
    
- secrets belong in Keychain
    
- settings belong in native Mac preferences
    

## Status

Early architecture and planning stage.

Current priorities:

1. repository structure
    
2. core module skeleton
    
3. minimal Cocoa main window
    
4. conversation model
    
5. service abstraction
    
6. settings and preferences integration
    

## Design Standard

The standard is simple:

> LeoGPT should look and behave like a real Leopard application.

If it feels like a browser app, a messenger clone, or a foreign client wearing a Mac costume, it has failed.

## License

TBD