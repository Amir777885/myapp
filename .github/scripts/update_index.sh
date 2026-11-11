#!/bin/bash
set -e
TASKS_FILE="$1"
TESTS_FILE="$2"
cd /app
TODO=$(sed -n '/^ToDo Tasks:/,/^Done Tasks:/p' "$TASKS_FILE" | sed '1d;$d')
DONE=$(sed -n '/^Done Tasks:/,$p' "$TASKS_FILE" | sed '1d')
TESTS=$(cat "$TESTS_FILE")
UPDATED="$(date '+%Y-%m-%d %H:%M:%S') by $GITHUB_USER"

update_pre() {
  ID="$1" CONTENT="$2" perl -0pi -e 's/(<pre id="$ENV{ID}">).*?(<\/pre>)/${1}$ENV{CONTENT}${2}/s' "$3"
}

update_pre "todo" "$TODO" index.html
update_pre "done" "$DONE" index.html
update_pre "tests" "$TESTS" index.html
update_pre "updated" "$UPDATED" index.html

git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"
git config --global --add safe.directory /app
git add index.html
git commit -m "Update index.html with tasks and test results" || echo "No changes to commit"
git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git push origin HEAD:main
