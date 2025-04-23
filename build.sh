#!/usr/bin/env bash
set -euo pipefail
# Build script for the portfolio site
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="$ROOT_DIR/dist"
DOCS_SRC="$ROOT_DIR/../documentations"
PROJECTS_SRC="$ROOT_DIR/../../zp/data-platform-terraform/terraform/data-platform-stg"

# Clean up
rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR" "$DIST_DIR/assets" "$DIST_DIR/forms" "$DIST_DIR/docs" "$DIST_DIR/projects"

# Copy assets and forms
cp -r "$ROOT_DIR/assets" "$DIST_DIR/"
cp -r "$ROOT_DIR/forms" "$DIST_DIR/"

# Ensure partials exist
mkdir -p "$ROOT_DIR/partials"

# Extract header (up to <main)
# Match line containing <main at start of indentation
sed -n '1,/^[[:space:]]*<main /p' "$ROOT_DIR/index.html" > "$ROOT_DIR/partials/header.html"

# Extract Hero section
sed -n '/<section id="hero"/,/<!-- \/Hero Section -->/p' "$ROOT_DIR/index.html" > "$ROOT_DIR/partials/hero.html"

# Extract footer (from </main> to end)
# Match closing </main> with optional indentation
sed -n '/^[[:space:]]*<\/main>/,$p' "$ROOT_DIR/index.html" > "$ROOT_DIR/partials/footer.html"

# Assemble index.html
cat \
  "$ROOT_DIR/partials/header.html" \
  "$ROOT_DIR/partials/hero.html" \
  "$ROOT_DIR/partials/about.html" \
  "$ROOT_DIR/partials/docs.html" \
  "$ROOT_DIR/partials/projects.html" \
  "$ROOT_DIR/partials/footer.html" \
  > "$DIST_DIR/index.html"

echo "Built index.html"

# Build documentation pages (markdown -> HTML)
for md in "$DOCS_SRC"/*.md; do
  name="$(basename "$md" .md)"
  out_html="$DIST_DIR/docs/${name}.html"
  {
    echo '<!DOCTYPE html>'
    echo '<html lang="en"><head><meta charset="UTF-8"><title>'"$name"'</title>'
    echo '<link rel="stylesheet" href="../assets/css/main.css">'
    echo '</head><body>'
    echo "<h1>${name}</h1><pre>"
    sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g' "$md"
    echo '</pre></body></html>'
  } > "$out_html"
  echo "Built doc: $name"
done

# Build docs index
{
  echo '<!DOCTYPE html>'
  echo '<html lang="en"><head><meta charset="UTF-8"><title>Documentation Index</title>'
  echo '<link rel="stylesheet" href="../assets/css/main.css">'
  echo '</head><body><h1>Documentation</h1><ul>'
  for html in "$DIST_DIR/docs"/*.html; do
    fname="$(basename "$html")"
    echo "<li><a href=\"$fname\">$fname</a></li>"
  done
  echo '</ul></body></html>'
} > "$DIST_DIR/docs/index.html"
echo "Built docs index"

# Build project pages (TF -> HTML)
for tf in "$PROJECTS_SRC"/*.tf; do
  name="$(basename "$tf" .tf)"
  out_html="$DIST_DIR/projects/${name}.html"
  {
    echo '<!DOCTYPE html>'
    echo '<html lang="en"><head><meta charset="UTF-8"><title>'"$name"'</title>'
    echo '<link rel="stylesheet" href="../assets/css/main.css">'
    echo '</head><body>'
    echo "<h1>${name}</h1><pre>"
    sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g' "$tf"
    echo '</pre></body></html>'
  } > "$out_html"
  echo "Built project: $name"
done

# Build projects index
{
  echo '<!DOCTYPE html>'
  echo '<html lang="en"><head><meta charset="UTF-8"><title>Projects Index</title>'
  echo '<link rel="stylesheet" href="../assets/css/main.css">'
  echo '</head><body><h1>Projects</h1><ul>'
  for html in "$DIST_DIR/projects"/*.html; do
    fname="$(basename "$html")"
    echo "<li><a href=\"$fname\">$fname</a></li>"
  done
  echo '</ul></body></html>'
} > "$DIST_DIR/projects/index.html"
echo "Built projects index"
# Publish built site to project root (overwrite old template)
# Remove legacy template pages
rm -f "$ROOT_DIR/index.html" "$ROOT_DIR/portfolio-details.html" "$ROOT_DIR/service-details.html" "$ROOT_DIR/starter-page.html"
# Replace assets and forms
rm -rf "$ROOT_DIR/assets" "$ROOT_DIR/forms"
cp -r "$DIST_DIR/assets" "$ROOT_DIR/assets"
cp -r "$DIST_DIR/forms" "$ROOT_DIR/forms"
# Copy built pages to root
cp "$DIST_DIR/index.html" "$ROOT_DIR/index.html"
rm -rf "$ROOT_DIR/docs" "$ROOT_DIR/projects"
cp -r "$DIST_DIR/docs" "$ROOT_DIR/docs"
cp -r "$DIST_DIR/projects" "$ROOT_DIR/projects"
# Cleanup dist directory
rm -rf "$DIST_DIR"

echo "Build and publish complete. Open $ROOT_DIR/index.html in a browser."