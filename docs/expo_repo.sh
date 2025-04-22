#!/bin/bash

# Generate timestamped output file
timestamp=$(date +"%Y%m%d_%H%M%S")
output="repository_${timestamp}.txt"

# Define directories or files to exclude from listing
EXCLUDES=( ".git" "node_modules" "__pycache__" "venv" "dist" "build" )
IGNORE_PATTERN=$(IFS='|'; echo "${EXCLUDES[*]}")

# Clear or create the output file
> "$output"

# Header
echo "=====================================" >> "$output"
echo "Repository: $(basename "$(pwd)")" >> "$output"
echo "Date: $(date)" >> "$output"
echo "=====================================" >> "$output"
echo "" >> "$output"

# Print repository structure (tree format)
if command -v tree &>/dev/null; then
    echo "Repository structure (excluding: ${EXCLUDES[*]}):" >> "$output"
    tree -I "$IGNORE_PATTERN" >> "$output"
else
    echo "'tree' command is not installed. Please install it to list the directory structure." >> "$output"
fi

echo "" >> "$output"

# Summary
file_count=$(find . -type f \
    ! -path "./.git/*" \
    ! -name "$output" \
    ! -name "expo_repo.sh" | wc -l)

line_count=$(find . -type f \
    ! -path "./.git/*" \
    ! -name "$output" \
    ! -name "expo_repo.sh" -exec cat {} + | wc -l)

echo "Summary:" >> "$output"
echo "Total files processed: $file_count" >> "$output"
echo "Total lines: $line_count" >> "$output"
echo "" >> "$output"
echo "File contents:" >> "$output"
echo "" >> "$output"

# Process and export each file's contents
find . -type f \
    ! -path "./.git/*" \
    ! -name "$output" \
    ! -name "expo_repo.sh" | while IFS= read -r file; do
        echo "-------------------------------------" >> "$output"
        echo "File: $file" >> "$output"
        echo "-------------------------------------" >> "$output"
        
        # Detect file type for syntax hinting (basic)
        extension="${file##*.}"
        case "$extension" in
            sh) lang="bash" ;;
            py) lang="python" ;;
            tf) lang="hcl" ;;
            md) lang="markdown" ;;
            json) lang="json" ;;
            yaml|yml) lang="yaml" ;;
            *) lang="" ;;
        esac
        
        echo '```'"$lang" >> "$output"
        cat "$file" >> "$output"
        echo '```' >> "$output"
        echo "" >> "$output"
done

echo "Export completed! Output saved in: $output"
