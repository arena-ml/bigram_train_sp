# Run the training script

# Check if OUTPUT_DIR is not set or empty
if [ -z "${OUTPUT_DIR}" ]; then
  echo "Error: OUTPUT_DIR is not set."
  exit 1
fi

# Check if OUTPUT_DIR/train_bigram/ is not a valid directory
if [ ! -d "${OUTPUT_DIR}/train_bigram/" ]; then
  echo "Error: ${OUTPUT_DIR}/train_bigram/ is not a valid directory."
  exit 1
fi

# If both checks pass, proceed with the script
echo "OUTPUT_DIR/train_bigram/ is set and valid: ${OUTPUT_DIR}/train_bigram/"

echo "Running train.py..."
python train.py
 

mv bigram_language_model_full.pth ${OUTPUT_DIR}/train_bigram/