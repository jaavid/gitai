#!/bin/bash
# Demonstrates a basic workflow with GitAI.

set -euo pipefail

# Create a temporary file and modify it
TMP_FILE="example.txt"
echo "example" > "$TMP_FILE"

git add "$TMP_FILE"

# Run GitAI (assumes GITAI_API_KEY is configured)
../gitai

# Clean up
rm "$TMP_FILE"

git reset --hard HEAD
