# Run the training script
echo "Running train.py..."
python train.py
 

mv bigram_language_model_full.pth ${INPUT_DIR}/train_bigram/pre_processed_data/generate_text/
mv vocab_size.txt  ${INPUT_DIR}/train_bigram/pre_processed_data/generate_text/
mv int_to_string.pkl  ${INPUT_DIR}/train_bigram/pre_processed_data/generate_text/

# moving repo to output
mv ${INPUT_DIR}/train_bigram/pre_processed_data/generate_text/ ${OUTPUT_DIR}/trained_bigram/