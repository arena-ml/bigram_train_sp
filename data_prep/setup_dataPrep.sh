# Run the data preparation script
echo "Running data_prep.py..."
python data_prep.py

#move output to sharedDir
echo "moving output to ${OUTPUT_DIR}/data_prep/ "

mv processed_data.pt ${OUTPUT_DIR}/data_prep/
mv vocab_size.txt ${OUTPUT_DIR}/data_prep/
mv string_to_int.pkl ${OUTPUT_DIR}/data_prep/
mv int_to_string.pkl ${OUTPUT_DIR}/data_prep/
