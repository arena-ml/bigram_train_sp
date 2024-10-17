# train.py
import torch
import torch.nn as nn
import torch.optim as optim
from torch.nn import functional as F
from bigram_model import BigramLanguageModel

import os  # Import os module
import time 

# Path to your data
data_path = '/app/sharedDirectory/processed_data.pt'

# Load preprocessed data
data = torch.load(data_path, weights_only=True)

# Train/validation split
n = int(0.8 * len(data))
train_data = data[:n]
val_data = data[n:]

# Load vocab size
with open('/app/sharedDirectory/vocab_size.txt', 'r') as f:
    vocab_size = int(f.read())

# Define function to get batches of data
block_size = 8
batch_size = 4
device = 'mps' if torch.backends.mps.is_available() else 'cpu'

def get_batch(split):
    data = train_data if split == 'train' else val_data
    ix = torch.randint(len(data) - block_size, (batch_size,))
    x = torch.stack([data[i:i + block_size] for i in ix])
    y = torch.stack([data[i + 1:i + block_size + 1] for i in ix])
    return x.to(device), y.to(device)

# Initialize the model
model = BigramLanguageModel(vocab_size)

model = model.to(device)

# Set up optimizer
optimizer = optim.AdamW(model.parameters(), lr=3e-4)

# Training loop
max_iters = 100000
eval_interval = 250

for iter in range(max_iters):
    if iter % eval_interval == 0:
        model.eval()
        X, Y = get_batch('val')
        logits, val_loss = model(X, Y)
        print(f"step: {iter}, val_loss: {val_loss.item():.3f}")
        model.train()

    X, Y = get_batch('train')
    logits, loss = model(X, Y)

    optimizer.zero_grad(set_to_none=True)
    loss.backward()
    optimizer.step()

# Save the entire model (architecture + weights)
torch.save(model, '/app/sharedDirectory/bigram_language_model_full.pth')
print("Model training complete. Model saved in sharedDirectory.")

