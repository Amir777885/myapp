#!/bin/bash
set -e
echo "Starting vowel frequency analyzer..."
FREQ_RESULT=$(python3 /app/.github/scripts/frequency.py /app/data.txt)
echo "Result: $FREQ_RESULT"
bash /app/.github/scripts/update_readme.sh "$FREQ_RESULT" "$GITHUB_USER"
echo "Analysis complete."
