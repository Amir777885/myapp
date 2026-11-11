#!/bin/bash
set -e
FREQ_RESULT="$1"
GITHUB_USER="$2"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
cd /app
echo -e "\n### Vowel Frequency Analysis\n- Contributor: $GITHUB_USER\n- Timestamp: $TIMESTAMP\n- Result: $FREQ_RESULT" >> README.md
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"
git config --global --add safe.directory /app
git add README.md
git commit -m "Update README with vowel frequency analysis by $GITHUB_USER" || echo "No changes to commit"
git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git push origin HEAD:main
