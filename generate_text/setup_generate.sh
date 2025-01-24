#!/bin/bash
set -euo pipefail  # Exit on error, treat unset variables as errors, and fail on pipeline errors

# Logging function for error messages
log_error() {
    echo "[ERROR] $1" >&2
    exit 1
}

echo "Running generate.py..."
if ! python generate.py; then
    log_error "generate.pyfailed to execute. Please check the script and inputs."
fi

if [[ ! -d ${OUTPUT_DIR}/generated_text/ ]]; then
    log_error "Directory ${OUTPUT_DIR}/generated_text/ does not exist."
fi


mv test_prompt.txt ${OUTPUT_DIR}/generated_text/ || log_error "Failed to move prompt output test_prompt.txt to ${OUTPUT_DIR}/generated_text/ "
