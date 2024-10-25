# Run the generate script
echo "Running generate.py..."
python generate.py

mv test_prompt.txt ${OUTPUT_DIR}/generated_text/
