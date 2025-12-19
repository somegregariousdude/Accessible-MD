#!/bin/bash
# ==============================================================================
# SCRIPT: update_setup.sh (LIGHTWEIGHT EDITION)
# PURPOSE: Regenerate 'setup_project.sh' capturing only ARCHITECTURE.
# EXCLUDES: Content, Git History, and Binary Assets (Images/Fonts).
# ==============================================================================

OUTPUT_FILE="setup_project.sh"

echo "--- Regenerating $OUTPUT_FILE (Lightweight Context) ---"

# 1. WRITE HEADER
cat <<'HEADER' > "$OUTPUT_FILE"
#!/bin/bash
# ==============================================================================
# SCRIPT: setup_project.sh
# PURPOSE: AI Context Reference (Architecture & Logic Only)
# EXCLUDES: Content, Images, Git Data
# ==============================================================================

echo "Restoring Architecture Context..."

HEADER

# 2. DEFINE THE PROCESSOR
process_file() {
    local filepath="$1"
    cleanpath="${filepath#./}"

    # Skip the output file and this script
    if [[ "$cleanpath" == "$OUTPUT_FILE" ]] || [[ "$cleanpath" == "update_setup.sh" ]]; then
        return
    fi

    echo "Embedding: $cleanpath"

    # Create directory structure
    dir=$(dirname "$cleanpath")
    if [[ "$dir" != "." ]]; then
        echo "mkdir -p \"$dir\"" >> "$OUTPUT_FILE"
    fi

    # Embed Content
    echo "# File: $cleanpath" >> "$OUTPUT_FILE"
    echo "cat <<'EOF' > \"$cleanpath\"" >> "$OUTPUT_FILE"
    cat "$filepath" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "EOF" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
}

export -f process_file

# 3. CRAWL & FILTER
# - Prune .git and node_modules immediately for speed
# - Exclude 'content/' folder in the root
# - Exclude Binary Extensions to save space
find . \
    \( -path "*/.git" -o -path "*/node_modules" -o -path "*/public" -o -path "*/resources" -o -path "./content" \) -prune \
    -o -type f \
    -not -name "*.jpg" \
    -not -name "*.jpeg" \
    -not -name "*.png" \
    -not -name "*.webp" \
    -not -name "*.gif" \
    -not -name "*.ico" \
    -not -name "*.woff" \
    -not -name "*.woff2" \
    -not -name "*.ttf" \
    -not -name "*.eot" \
    -not -name ".DS_Store" \
    -not -name ".hugo_build.lock" \
    -not -name "$OUTPUT_FILE" \
    -not -name "update_setup.sh" \
    -print0 | while IFS= read -r -d '' file; do
        process_file "$file"
    done

# 4. WRITE FOOTER
cat <<'FOOTER' >> "$OUTPUT_FILE"

echo "✅ Context restoration complete (Architecture Only)."
FOOTER

chmod +x "$OUTPUT_FILE"
echo "--- Done. File size optimized. ---"
