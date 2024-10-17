# data_prep.py
import torch
import pickle
# Load and preprocess data
with open('raw_data.txt', 'r', encoding='utf-8') as f:
    text = f.read()

# Find unique characters in the text
chars = sorted(set(text))
vocab_size = len(chars)

# Save vocab_size in the shared directory for later use
with open('vocab_size.txt', 'w') as f:
    f.write(str(vocab_size))

# Create string to integer and integer to string mappings
string_to_int = {ch: i for i, ch in enumerate(chars)}
int_to_string = {i: ch for i, ch in enumerate(chars)}

# Encode text into integer representation
encode = lambda s: [string_to_int[c] for c in s]
data = torch.tensor(encode(text), dtype=torch.long)

# Save the preprocessed data to sharedDirectory
torch.save(data, 'processed_data.pt')

# Save the dictionaries to a file
with open('string_to_int.pkl', 'wb') as f:
    pickle.dump(string_to_int, f)

with open('int_to_string.pkl', 'wb') as f:
    pickle.dump(int_to_string, f)


print("Data preparation complete. Data saved in sharedDirectory.")

