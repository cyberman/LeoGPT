

# Porting Notes from AmigaGPT

## 1. Purpose

This document explains how the **AmigaGPT** codebase should be used as a source for **LeoGPT**.

It does **not** define a traditional porting effort.

LeoGPT is not intended to be an AmigaGPT clone on Mac OS X.  
It is intended to be a **Leopard-native application** that reuses useful structure and logic where appropriate.

Therefore, the correct mindset is:

- extract
- reinterpret
- replace
- simplify

Not:

- copy UI
- preserve platform habits
- reproduce dependency chains
- mimic Amiga application behavior on the Mac

---

## 2. Strategic Position

AmigaGPT is valuable for LeoGPT because it proves several important things:

1. A slim native AI client is feasible on a legacy platform.
2. A browser is not required.
3. A focused desktop application can cover useful modern AI workflows.
4. Platform integration matters more than visual novelty.

However, AmigaGPT is still an **Amiga application**.  
Its visible structure, dependency choices, automation model, and UI composition are deeply shaped by AmigaOS.

LeoGPT must preserve the first four lessons while discarding the platform-specific shape.

---

## 3. Reuse Model

The AmigaGPT source tree should be treated using four categories:

1. **Reuse**
2. **Extract**
3. **Replace**
4. **Solve natively on Leopard**

### 3.1 Reuse
Small pieces that can be adapted with minimal conceptual change.

### 3.2 Extract
Logic and structure that are useful, but should be rewritten into LeoGPT-native modules.

### 3.3 Replace
Amiga-specific implementation that should not be carried forward.

### 3.4 Solve natively on Leopard
Areas where Leopard offers a cleaner system-level answer than the original Amiga dependency path.

---

## 4. File Classification

## 4.1 Reuse

These parts are useful as direct reference material and may partially survive with modest cleanup.

- `LICENSE.md`
- `src/version.h`
- selected enum and structure concepts from `src/openai.h`
- selected static model/voice/image definitions from `src/openai.c`

### Notes
These should still be normalized into LeoGPT naming and data style.

Typical cleanup tasks:

- remove Amiga-specific integer/string assumptions
- replace platform typedefs with LeoGPT-owned types
- reduce global coupling
- keep only the semantic value

---

## 4.2 Extract

These files contain major functional value, but should not be ported directly.

- `src/openai.c`
- `src/openai.h`
- `src/config.c`
- `src/config.h`
- parts of `src/speech.c`

### Why extract instead of port?
Because these files mix:

- transport logic
- service logic
- product rules
- model definitions
- error reporting
- platform assumptions
- direct UI callbacks

The goal is to preserve the useful decisions while removing platform entanglement.

### Expected LeoGPT targets
Useful material from these files should be redistributed into:

- `LGConversation`
- `LGModelCatalog`
- `LGSettings`
- `LGService`
- `LGTranscriptStore`
- optional future speech abstractions

---

## 4.3 Replace

These files should be fully replaced with Leopard-native Cocoa implementations.

- `src/main.c`
- `src/MainWindow.c`
- `src/MainWindow.h`
- `src/menu.c`
- `src/menu.h`
- `src/gui.c`
- `src/gui.h`
- `src/AmigaGPTTextEditor.c`
- `src/AmigaGPTTextEditor.h`
- all requester window files
- all Amiga UI glue

### Reason
These parts express Amiga application identity through:

- MUI structure
- requester-based settings flows
- custom text widget strategy
- Amiga menu conventions
- global GUI object assumptions
- Amiga interaction patterns

LeoGPT must not inherit those visible patterns.

---

## 4.4 Solve Natively on Leopard

These areas should not merely be replaced.  
They should be redesigned around Leopard-native services.

- `src/ARexx.c`
- much of `src/speech.c`
- credential storage inside configuration handling
- requester-driven preference editing
- custom editor mechanics where `NSTextView` already solves the problem

### Native Leopard answers
Use Leopard facilities instead:

- AppleScript later instead of ARexx
- `NSSpeechSynthesizer` later where local speech is useful
- Keychain for secrets
- `NSUserDefaults` for preferences
- `NSTextView` for transcript/composer text
- `NSAlert`, `NSPanel`, `NSOpenPanel`, `NSSavePanel` for dialogs

---

## 5. Detailed Porting Guidance

## 5.1 `openai.h`

### Keep
- role model concepts
- conversation structure ideas
- endpoint categorization
- model/image/voice enumerations as design input

### Change
- detach from Amiga list and memory idioms
- define LeoGPT-owned structures
- remove UI awareness
- normalize names to LeoGPT conventions

### Result
This file should inspire:

- `LGConversation.h`
- `LGModelCatalog.h`
- portions of `LGService.h`

---

## 5.2 `openai.c`

### Keep conceptually
- request-building logic
- response parsing logic
- endpoint variation handling
- model selection logic
- error interpretation
- image/chat feature boundaries
- service-oriented product scope

### Do not keep directly
- direct UI status updates
- direct GUI error dispatch
- Amiga transport assumptions
- global application object access
- intertwined network/UI state

### Rewrite into
- `LGService.c`
- maybe helper units for model and payload formatting

### Porting rule
If a function both talks to the network and updates visible UI state, split it.

LeoGPT should separate:

- service action
- result object
- UI rendering of the result

---

## 5.3 `config.h` / `config.c`

### Keep conceptually
- settings inventory
- useful defaults
- endpoint/proxy-related configuration ideas
- image and model preference categories

### Replace implementation
Do not preserve the original persistence strategy mechanically.

### LeoGPT-native split
- `LGSettings` for in-memory validated settings
- `LGDefaultsBridge` for `NSUserDefaults`
- `LGKeychain` for API secrets

### Porting rule
Settings and credentials are separate concerns.

Do not store API keys in general config files.

---

## 5.4 `MainWindow.*`

### Keep only as functional inventory
This code is useful to answer:

- what actions exist
- what the user can do
- what state transitions the app needs
- what visible workflows exist

### Do not port directly
The file is too UI-bound and too MUI-shaped.

### LeoGPT-native replacement
Split responsibilities across Cocoa controllers:

- `LGMainWindowController`
- `LGConversationListController`
- `LGTranscriptViewController`
- `LGComposerViewController`

### Porting rule
If a source file is huge because it owns all visible behavior, divide it by user-facing responsibility.

---

## 5.5 `menu.*`

### Keep conceptually
- action inventory
- command grouping
- feature exposure hints

### Replace entirely
Mac menus must follow Mac expectations.

### LeoGPT-native replacement
Move actions into:

- App delegate actions
- window controller actions
- first responder-compatible edit actions where practical

### Porting rule
Do not recreate Amiga menu habits in AppKit.

---

## 5.6 `gui.*`

### Keep conceptually
Only as a map of application behavior.

### Replace entirely
Leopard UI should be expressed through AppKit, not translated from MUI vocabulary.

### LeoGPT-native replacement
AppKit controller/view structure.

---

## 5.7 Requester windows

### Keep conceptually
They show which configuration tasks matter:

- API key entry
- proxy settings
- custom server settings
- voice or service settings
- about box content

### Replace implementation
These should become:

- a proper Preferences window
- normal About panel
- standard alerts
- standard save/open panels

### Porting rule
A cluster of requester windows usually means the destination platform wants a settings architecture.

---

## 5.8 `ARexx.*`

### Keep conceptually
Only the idea that automation may later matter.

### Replace completely
Do not emulate ARexx thinking on the Mac.

### LeoGPT direction
For V1: omit.  
For later:
- AppleScript
- URL scheme
- Services
- maybe Automator-friendly hooks

---

## 5.9 `speech.*`

### Keep conceptually
The idea that local and remote speech are distinct capabilities.

### Replace mostly
Leopard-native local speech should use Mac facilities if speech is added later.

### LeoGPT direction
For V1:
- omit speech entirely
or
- support remote speech in a very narrow form only if truly needed

### Later options
- local: `NSSpeechSynthesizer`
- remote: AI service TTS endpoint

### Porting rule
Do not import a speech feature zoo into V1.

---

## 6. Leopard Advantages Over the Original Dependency Situation

One of the main reasons LeoGPT should not be a literal port is that Leopard already provides better system-level answers for several dependency classes.

## 6.1 Text handling
AmigaGPT needs custom UI/editor considerations.

Leopard answer:
- `NSTextView`
- Foundation string handling
- native UTF-8 support paths

## 6.2 Preferences
AmigaGPT uses app-defined configuration flow.

Leopard answer:
- `NSUserDefaults`
- Preferences window
- panel and toolbar conventions

## 6.3 Credentials
AmigaGPT configuration can carry secret-like values.

Leopard answer:
- Keychain

## 6.4 Networking
AmigaGPT must solve this through legacy-platform means.

Leopard answer:
- system networking APIs
- system SSL/TLS paths
- Foundation data conversion support

## 6.5 Dialogs
Amiga requester logic is not the desired UX model on the Mac.

Leopard answer:
- `NSAlert`
- `NSOpenPanel`
- `NSSavePanel`
- standard document-like behavior

---

## 7. Recommended Extraction Plan

## Phase 1: inventory extraction
Read and document:

- conversation structures
- settings list
- model list
- endpoint categories
- user actions
- save/load actions

No code migration yet.

## Phase 2: core reconstruction
Create new C modules:

- `LGConversation`
- `LGModelCatalog`
- `LGSettings`
- `LGService`
- `LGTranscriptStore`
- `LGError`

Populate them with clean LeoGPT-native data contracts.

## Phase 3: platform bridges
Implement:

- defaults bridge
- keychain bridge
- network bridge

These should isolate Leopard-specific service usage from the core.

## Phase 4: Cocoa shell
Build:

- main window
- conversation sidebar
- transcript view
- composer
- preferences window
- standard menus and toolbar

## Phase 5: cleanup and reduction
Before adding features, remove anything that feels like carried-over foreign shape.

Question to ask repeatedly:

> Would Leopard itself solve this this way?

If the answer is no, redesign.

---

## 8. Explicit Non-Goals

The LeoGPT project should not try to preserve the following from AmigaGPT:

- MUI interaction patterns
- requester-heavy configuration design
- ARexx integration model
- visible Amiga application behavior
- Amiga-specific dependency structure
- feature parity for its own sake
- UI organization inherited from source file size

The goal is not Amiga compatibility.  
The goal is Leopard-native dignity.

---

## 9. V1 Reduction Rules

When uncertain, prefer deletion over porting.

V1 should keep only what supports the primary workflow:

- create or open a conversation
- enter prompt
- send request
- read response
- save/export transcript
- choose model
- configure endpoint

Everything else must justify its existence.

Especially avoid early complexity in:

- speech
- automation
- HTML rendering
- advanced transcript styling
- plugin behavior
- settings sprawl

---

## 10. Final Porting Rule

The most important rule in this document is simple:

> Do not port AmigaGPT as an Amiga application.  
> Rebuild LeoGPT as a Leopard application using AmigaGPT as a structural source.

That is the correct relationship between the two projects.