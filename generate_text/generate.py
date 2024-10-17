# generate.py
import torch
import os  
import time 
import pickle
from bigram_model import BigramLanguageModel

vocab_path = 'vocab_size.txt'

# Load vocab size
with open(vocab_path, 'r') as f:
    vocab_size = int(f.read())

# Path to your model
model_path = 'bigram_language_model_full.pth'


with open('int_to_string.pkl', 'rb') as f:
    int_to_string = pickle.load(f)

# Load the saved model weights into the initialized model
model = torch.load(model_path)

# Generate text
context = torch.zeros((1, 1), dtype=torch.long)  # Start with an empty context
generated_indices = model.generate(context, max_new_tokens=500)

# Ensure the generated text is within the valid range
generated_text = ''.join([int_to_string[idx.item()] if idx.item() < vocab_size else '' for idx in generated_indices[0]])

print("Generated text:")
print(generated_text)

# Save the generated text to a file
with open("test_prompt.txt", "w") as file:
    file.write(generated_text)
