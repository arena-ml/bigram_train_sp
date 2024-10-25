# echo "environment setup"
# # Install system dependencies (if necessary)
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     build-essential \
#     && rm -rf /var/lib/apt/lists/*

# # Install PyTorch and NumPy at build time
# RUN pip install --no-cache-dir torch numpy

# Run the data preparation script
echo "Running data_prep.py..."
python data_prep.py

#move output to sharedDir
echo "moving output to ${OUTPUT_DIR}/preprocess_raw_data/ "

mv processed_data.pt ${OUTPUT_DIR}/pre_processed_data/
mv vocab_size.txt ${OUTPUT_DIR}/pre_processed_data/
mv string_to_int.pkl ${OUTPUT_DIR}/pre_processed_data/
mv int_to_string.pkl ${OUTPUT_DIR}/pre_processed_data/
