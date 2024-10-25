# Run the generate script
echo "Running generate.py..."
python generate.py

move test_prompt.txt ${OUTPUT_DIR}/generated_text/test_prompt.txt
