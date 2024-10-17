# List the files in the shared directory (for debug)
echo "Contents of sharedDirectory:"
ls sharedDirectory

# Run the data preparation script
echo "Running data_prep.py..."
python data_prep.py

echo "Running data_prep.py..."

#move output to sharedDir
mv processed_data.pt sharedDirectory/
mv vocab_size.txt sharedDirectory/
mv string_to_int.pkl sharedDirectory/
mv int_to_string.pkl sharedDirectory/