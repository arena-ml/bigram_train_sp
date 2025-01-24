#!/bin/bash
set -euo pipefail  # Exit on error, treat unset variables as errors, and fail on pipeline errors

# Logging function for error messages
log_error() {
    echo "[ERROR] $1" >&2
    exit 1
}

# Run the data preparation script
echo "Running data_prep.py..."
if ! python data_prep.py; then
    log_error "data_prep.py failed to execute. Please check the script and inputs."
fi

# Ensure files exist before moving
for file in processed_data.pt vocab_size.txt string_to_int.pkl int_to_string.pkl; do
    if [[ ! -f $file ]]; then
        log_error "Missing file: $file. Data preparation might have failed."
    fi
done

# Ensure the target directories exist
if [[ ! -d ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/ ]]; then
    log_error "Directory ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/ does not exist."
fi

if [[ ! -d ${INPUT_DIR}/model_repo/bigram_entity_data/generate_text/ ]]; then
    log_error "Directory ${INPUT_DIR}/model_repo/bigram_entity_data/generate_text/ does not exist."
fi

if [[ ! -d ${OUTPUT_DIR}/pre_processed_data/ ]]; then
    log_error "Directory ${OUTPUT_DIR}/pre_processed_data/ does not exist."
fi


mv processed_data.pt ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/ || log_error "Failed to move processed_data.pt"
mv vocab_size.txt ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/ || log_error "Failed to move vocab_size.txt"
mv string_to_int.pkl ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/ || log_error "Failed to move string_to_int.pkl"
mv int_to_string.pkl ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/ || log_error "Failed to move int_to_string.pkl"

# Move relevant parts to the next stage
mv ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/ ${OUTPUT_DIR}/pre_processed_data/ || log_error "Failed to move train_bigram/ directory"
mv ${INPUT_DIR}/model_repo/bigram_entity_data/generate_text/ ${OUTPUT_DIR}/pre_processed_data/ || log_error "Failed to move generate_text/ directory"

# Final message
echo "Script completed successfully"

