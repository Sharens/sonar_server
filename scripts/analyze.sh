#!/bin/bash

# Exit on error
set -e

echo "🔍 Running Go linter..."
if ! command -v golangci-lint &> /dev/null; then
    echo "❌ golangci-lint is not installed. Please install it first."
    echo "   Installation instructions: https://golangci-lint.run/usage/install/"
    exit 1
fi

# Przechodzimy do katalogu server, ponieważ tam znajduje się kod Go
echo "🔍 Running golangci-lint in server directory..."
cd server
if ! golangci-lint run --fix; then
    echo "❌ Go linting failed. Please fix the issues and try again."
    cd ..
    exit 1
fi

# Wracamy do katalogu głównego
cd ..

echo "✅ Go linting completed successfully!"

# Run Go tests with coverage if tests exist
echo "🧪 Checking for Go tests..."
cd server
if [ -n "$(find . -name '*_test.go' -type f)" ]; then
    echo "🔍 Running Go tests..."
    if ! go test -v -coverprofile=coverage.out ./...; then
        echo "❌ Go tests failed. Please fix the issues and try again."
        cd ..
        exit 1
    fi
    
    echo "📊 Generating coverage report..."
    if [ -f "coverage.out" ]; then
        go tool cover -html=coverage.out -o coverage.html
        echo "✅ Coverage report generated: server/coverage.html"
    else
        echo "⚠️  No coverage data found. Skipping coverage report generation."
    fi
    echo "✅ Go tests completed successfully!"
else
    echo "ℹ️  No Go test files found. Skipping tests."
fi

# Wracamy do katalogu głównego
cd ..

# Generate test report in JUnit format
mkdir -p test-results
GOCACHE=off go test -v -json ./... > test-results/test-report.json

cd ..

# Run client tests
echo "🧪 Running client tests..."
npm test -- --coverage --watchAll=false

echo "✅ All checks passed!"
