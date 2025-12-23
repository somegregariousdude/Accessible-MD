#!/bin/bash
# ==============================================================================
# SCRIPT: generate_icons.sh (LOCAL ASSET BUILDER - REFINED)
# PURPOSE: Fetch SVGs at build time.
# SAFETY: Wipes 'icons/' dir first to remove orphaned files.
# ==============================================================================

ICON_DIR="layouts/partials/icons"

# 1. CLEANUP
echo "--- Cleaning Icon Directory ---"
if [ -d "$ICON_DIR" ]; then
    rm -f "$ICON_DIR"/*.svg
    echo "✓ Removed old SVGs."
fi
mkdir -p "$ICON_DIR"

# 2. SYSTEM ICONS (Material Symbols)
declare -A SYSTEM_ICONS=(
    ["search"]="search"
    ["menu"]="menu"
    ["close"]="close"
    ["home"]="home"
    ["articles"]="article"
    ["photos"]="photo_camera"
    ["status"]="chat_bubble"
    ["replies"]="reply"
    ["reposts"]="repeat"
    ["likes"]="favorite"
    ["bookmarks"]="bookmark"
    ["rsvps"]="event"
    ["guestbook"]="import_contacts"
    ["contact"]="mail"
    ["about"]="info"
    ["pages"]="description"
    ["categories"]="category" 
    ["tags"]="label"
    ["content_copy"]="content_copy"
    ["check"]="check"
    ["share"]="share"
    ["event"]="event"
    ["schedule"]="schedule"
    ["styleguide"]="palette"
)

echo "--- Fetching System Icons ---"
for NAME in "${!SYSTEM_ICONS[@]}"; do
    MATERIAL_NAME="${SYSTEM_ICONS[$NAME]}"
    TARGET="$ICON_DIR/$NAME.svg"
    
    URL="https://raw.githubusercontent.com/google/material-design-icons/master/symbols/web/${MATERIAL_NAME}/materialsymbolsoutlined/${MATERIAL_NAME}_24px.svg"
    if curl -s -L -f "$URL" -o "$TARGET"; then
        echo "  ✓ $NAME"
    else
        echo "  X Failed to fetch $NAME"
    fi
done

# 3. SOCIAL ICONS (Simple Icons) - Updated to include PeerTube
declare -A SOCIAL_ICONS=(
    ["bluesky"]="bluesky"
    ["github"]="github"
    ["lemmy"]="lemmy"
    ["mastodon"]="mastodon"
    ["peertube"]="peertube"
    ["signal"]="signal"
    ["xmpp"]="xmpp"
    ["youtube"]="youtube"
)

echo "--- Fetching Social Icons ---"
for NAME in "${!SOCIAL_ICONS[@]}"; do
    TARGET="$ICON_DIR/$NAME.svg"
    URL="https://cdn.simpleicons.org/$NAME"
    
    if curl -s -L -f "$URL" -o "$TARGET"; then
         echo "  ✓ $NAME"
    else
         echo "  X Failed: $NAME (Creating fallback)"
         # Create a generic fallback (square)
         echo '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect></svg>' > "$TARGET"
    fi
done

# 4. SPECIAL PROVISIONS (Icons not in Simple Icons or needing overrides)

# Friendica must be fetched from their development repository
TARGET="$ICON_DIR/friendica.svg"
URL="https://raw.githubusercontent.com/friendica/friendica/develop/images/friendica.svg"
if curl -s -L -f "$URL" -o "$TARGET"; then 
    echo "  ✓ friendica"
else 
    echo "  X Failed friendica"
fi

# XMPP (Jabber) - Check if Simple Icons fetch succeeded (it often lacks XMPP). 
# If the file is the generic fallback (contains "rect"), try fetching the official logo.
TARGET="$ICON_DIR/xmpp.svg"
if grep -q "rect" "$TARGET"; then
    echo "  ! Simple Icons missing XMPP. Attempting official source..."
    URL="https://raw.githubusercontent.com/xmpp/xmpp-brand/master/logo-and-icon/icon/xmpp-icon.svg"
    if curl -s -L -f "$URL" -o "$TARGET"; then
        echo "  ✓ xmpp (Official)"
    else
        echo "  X Failed XMPP official fetch (Kept fallback)"
    fi
fi

echo "Icon generation complete."