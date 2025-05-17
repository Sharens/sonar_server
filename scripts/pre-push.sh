#!/bin/bash

# Exit on error
set -e

echo "🚀 Running pre-push checks..."

# Run the analyze script
./scripts/analyze.sh

echo "✅ All pre-push checks passed!"
