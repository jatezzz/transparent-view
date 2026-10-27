# transparent-view

A macOS utility that floats a semi-transparent image over any window, so you can check a UI implementation pixel by pixel against an exported design.

## Context

Built in July 2024 (3 to 10 Jul) as a personal developer tool. The README describes the use case: export a screen from a design tool, overlay it on the running app, and adjust the opacity.

## What it shows

- Window-level AppKit work: a non-opaque `NSWindow` with an `NSVisualEffectView` background, so the design can sit on top of the app you are building.
- An opacity slider that changes the image and the scroll view that holds it.
- A custom `NSView` that handles `mouseDown` and `mouseDragged`, so you can click and drag anywhere to move the window.
- The window resizes itself (animated) to the imported PNG or JPG, and large designs scroll.
- A small tool that solves one specific problem in day-to-day UI work.

## Stack

Swift, AppKit (Cocoa), Interface Builder (`MainMenu.xib`). MIT license.

## Run it

Open `Transparent.xcodeproj` in Xcode and run the app. Then use "Select Image" to load a design export.

## Looking back (2026)

Today I would add a click-through mode so the overlay does not catch mouse events, a global shortcut to toggle it, and a signed release build so people do not need Xcode to use it.
