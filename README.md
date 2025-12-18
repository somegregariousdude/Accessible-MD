# Accessible-MD

**An IndieWeb-focused, accessibility-first Hugo theme built with Material Design 3.**

Accessible-MD is designed for the modern independent web. It prioritizes privacy, readability, and standards compliance (WCAG 2.2 AA) while offering rich interactions through "Static Facades" for social media embeds.

## 1. Key Features
* **Privacy by Design:** Zero third-party requests on page load. YouTube, PeerTube, Bluesky, and Mastodon embeds use static facades that only load external scripts upon user interaction.
* **Accessibility First (WCAG 2.2 AA):**
    * **Navigation Drawer:** Traps focus (Inert), supports Escape key.
    * **Touch Targets:** Minimum 48x48px sizing for all interactive elements.
    * **Toast Notifications:** ARIA-live regions for status updates.
* **Material Design 3:**
    * **5 Built-in Color Schemes:** Sound (Blue), Market (Red/Brown), Mountain (Slate), Forest (Green), Sunset (Purple).
    * **Adaptive Theming:** Supports both Light and Dark modes automatically.
* **IndieWeb Native:** Built-in support for Webmentions, Microformats (h-card, h-entry), and POSSE workflows.

## 2. Installation

Add the theme as a submodule to your Hugo site:

```bash
git submodule add [https://github.com/somegregariousdude/accessible-md.git](https://github.com/somegregariousdude/accessible-md.git) themes/accessible-md
