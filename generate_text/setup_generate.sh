mv  ${OUTPUT_DIR}/data_prep/int_to_string.pkl ${INPUT_DIR}/generate_text/
mv  ${OUTPUT_DIR}/data_prep/vocab_size.txt ${INPUT_DIR}/generate_text/

# Run the generate script
echo "Running generate.py..."
python generate.py

move test_prompt.txt ${OUTPUT_DIR}/generate_text/test_prompt.txt
