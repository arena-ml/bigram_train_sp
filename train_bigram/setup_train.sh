#!/bin/bash
set -euo pipefail  # Exit on error, treat unset variables as errors, and fail on pipeline errors

# Logging function for error messages
log_error() {
    echo "[ERROR] $1" >&2
    exit 1
}

# Run the data preparation script
echo "Running train.py..."
if ! python train.py; then
    log_error "train.py failed to execute. Please check the script and inputs."
fi

# Ensure files exist before moving
for file in bigram_language_model_full.pth vocab_size.txt int_to_string.pkl; do
    if [[ ! -f $file ]]; then
        log_error "Missing file: $file. training might have failed."
    fi
done

# Ensure the target directories exist
if [[ ! -d ${INPUT_DIR}/train_bigram/pre_processed_data/generate_text/ ]]; then
    log_error "Directory ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/ does not exist."
fi

if [[ ! -d ${OUTPUT_DIR}/trained_bigram/ ]]; then
    log_error "Directory ${OUTPUT_DIR}/trained_bigram/ does not exist."
fi

mv bigram_language_model_full.pth ${INPUT_DIR}/train_bigram/pre_processed_data/generate_text/ || log_error "Failed to move bigramModel "
mv vocab_size.txt  ${INPUT_DIR}/train_bigram/pre_processed_data/generate_text/ || log_error "Failed to move vocab size file"
mv int_to_string.pkl  ${INPUT_DIR}/train_bigram/pre_processed_data/generate_text/ || log_error "Failed to move int_to_string"

# moving repo to output
mv ${INPUT_DIR}/train_bigram/pre_processed_data/generate_text/ ${OUTPUT_DIR}/trained_bigram/