#!/bin/sh

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <cargo command>"
    echo "Examples: "
    echo "$0 fmt"
    echo "$0 clippy"
    exit 1
fi

CARGO_COMMAND=$1
echo "Running 'cargo $CARGO_COMMAND' in all directories containing a Cargo.toml file"

# Find all Cargo.toml files in the current directory and subdirectories
CARGO_TOML_FILES=$(find . | grep Cargo.toml)

# Run the specified Cargo command in each directory containing a Cargo.toml file
for CARGO_TOML_FILE in $CARGO_TOML_FILES; do
    CARGO_TOML_DIR=$(dirname $CARGO_TOML_FILE)
    echo "Running 'cargo $CARGO_COMMAND' in $CARGO_TOML_DIR"
    (cd $CARGO_TOML_DIR && cargo $CARGO_COMMAND)
done
