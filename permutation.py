#!/usr/bin/env python3

import numpy as np
from itertools import permutations
import pandas as pd

# Define the grid
t = np.array([
    [0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0],
    [0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0],
    [0,0,1,0,1,0,0,0,0,0,1,0,1,0,0,0],
    [0,1,0,0,0,0,0,1,0,0,0,0,1,0,0,0],
    [0,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0],
    [1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0],
    [1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0],
    [0,0,0,0,0,1,0,0,0,0,1,1,1,0,0,0],
    [0,0,1,0,1,0,0,0,0,0,1,0,1,0,0,0],
    [0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1],
    [1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0]
])

# Columns where the second condition is ignored
exclude_columns = {0, 4, 8, 12}

# Check if a permutation is valid
def is_valid(arr):
    rows, cols = arr.shape

    for i in range(1, rows):
        # Rule 1: No consecutive 1s in the same column
        if np.any((arr[i] == 1) & (arr[i - 1] == 1)):
            return False

        # Rule 2: No pattern 1-0-0-1 except in excluded columns
        if i > 2:  # Check only when there are at least 4 rows to look back
            for j in range(cols):
                if j not in exclude_columns:  # Apply the rule only outside excluded columns
                    if (arr[i][j] == 1 and arr[i - 1][j] == 0 and
                        arr[i - 2][j] == 0 and arr[i - 3][j] == 1):
                        return False

        # Rule 3: No 3 consecutive rows with 0s in the same column
        if i > 1 and np.any((arr[i] == 0) & (arr[i - 1] == 0) & (arr[i - 2] == 0)):
            return False

    return True

# File path to save permutations
file_path = 'PossibleCombination.csv'

# Clear the file initially (if it already exists)
open(file_path, 'w').close()

# Generate permutations and validate them
valid = 0
batch = []  # Store batches of valid permutations
batch_size = 100  # Write every 100 valid permutations

for perm in permutations(t):
    perm = np.array(perm)  # Convert tuple back to NumPy array
    valid += 1

    # Show progress
    if valid % 5000 == 0:
        print(f"Checked {valid} permutations so far...")

    # Check validity of permutation
    if is_valid(perm):
        print(f"Valid Permutation: {valid}")
        batch.append(pd.DataFrame(perm))

        # Write in batches
        if len(batch) >= batch_size:
            pd.concat(batch).to_csv(file_path, mode='a', index=False, header=False)
            batch = []

# Write remaining batch
if batch:
    pd.concat(batch).to_csv(file_path, mode='a', index=False, header=False)

