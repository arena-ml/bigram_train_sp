# Run the data preparation script
echo "Running data_prep.py..."
python data_prep.py

#move output to sharedDir
echo "moving output to ${OUTPUT_DIR}/pre_processed_data/ "

mv processed_data.pt ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/
mv vocab_size.txt ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/
mv string_to_int.pkl ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/
mv int_to_string.pkl ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/

#moving only relevant part to next stage
mv ${INPUT_DIR}/model_repo/bigram_entity_data/train_bigram/ ${OUTPUT_DIR}/pre_processed_data/
mv ${INPUT_DIR}/model_repo/bigram_entity_data/generate_text/ ${OUTPUT_DIR}/pre_processed_data/
