#!/bin/bash
set -e
set -o pipefail
echo "Running task manager..."
python3 /app/.github/scripts/todo.py | tee /tmp/tasks.txt
echo "Running unit tests..."
python3 /app/.github/scripts/todo-test.py | tee /tmp/tests.txt
echo "Updating index.html..."
bash /app/.github/scripts/update_index.sh /tmp/tasks.txt /tmp/tests.txt
echo "Pipeline complete."
