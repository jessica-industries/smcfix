#!/bin/bash

set -e  # Exit on any error

# Trap to catch errors and print them
trap 'print_error "Build failed at line $LINENO"' ERR

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO   ]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR  ]${NC} $1"
}

# Main execution
main() {
    print_status "SMCFix Local Build Script"
    print_status "========================="
    
    print_status "Downloading dependencies..."
    go mod download
    go mod tidy

    print_status "Installing Fyne..."
    go install fyne.io/tools/cmd/fyne@latest

    print_status "Building app..."
    fyne package -icon assets/icon.png -name "SMCFix" -release
    
    print_success "Done!"
}

# Run main function
main "$@"
