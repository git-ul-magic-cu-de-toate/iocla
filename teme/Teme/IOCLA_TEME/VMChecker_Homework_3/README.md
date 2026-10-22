_Sava Victor 311CA_

---

# Cosminel cel Pasionat - Overview

After enjoying the long May 1st-2nd break, it's time for something even
more exciting... **IOCLA Assignment 3!**

To keep the spirits high and the exercises more engaging, we've introduced
a new fictional character: **Cosminel**, a passionate and quirky individual
with a flair for logic, structure, and, of course, Assembly.

This assignment revolves around helping Cosminel pursue his interests through
four unique and challenging tasks, each exploring a different aspect
of low-level programming.

---

## Objectives

This homework reinforces concepts from the IOCLA labs:

- Stack operations
- Function calling conventions
- C-Assembly interaction

---

## Development Approach

Most of the functions in this assignment were initially implemented in **C**, then
carefully translated to **Assembly**.

This workflow was chosen to deepen my
understanding of **C-to-Assembly interaction**, allowing me to clearly
see how high-level constructs (like loops, conditionals, and function calls)
map to low-level instructions.

---

## Task Breakdown

## Task 1 – Sorting

### Implementation Details

In my implementation, I follow a **selection-sort-like strategy** based on the known
properties of the values (1 to n, unique). Here's how it's done:

1. **Find the head** of the list:

   - Loop through all nodes to locate the node with `val == 1`.
   - This node becomes the new head (`edi`) and the current pointer (`esi`).

2. **Link nodes in ascending order:**

   - Iterate from `val = 2` up to `n`.
   - For each value, scan the array to find the corresponding node.
   - Once found, update the `next` pointer of the current node to this new node
     and advance the current pointer.

3. **Finalize the list:**

   - After the last value, set the `next` field of the last node to `NULL`.

---

## Task 2 – Operations

The implementation is split into three key functions:

- `get_words`
- `compare`
- `sort`

### `get_words`

**Implementation details:**

- The input string (`s`) is split using `strtok`.
- Words are stored in the output array `words`, using the count `esi` to track the index.

---

### `compare`

**Implementation details:**

- Extract the actual strings pointed to by `a` and `b`.
- Call `strlen` on both and compare the lengths.
- If lengths are equal, call `strcmp`.
- The result (`eax`) follows the expected `qsort` comparator convention.

---

### `sort`

**Implementation details:**

- Pushes the required arguments to `qsort` in reverse order:

  1. Pointer to the word array
  2. Number of elements
  3. Size of each element (which is `4` for `char *`)
  4. Address of the comparator function

- Cleans up the stack after the call.

---

## Task 3 – KFib

### Implementation details

1. **Base Cases**

   - If `n < K`, return `0`.
   - If `n == K`, return `1`.

2. **Recursive Case**

   - Initialize `esi` to `0` (sum).
   - Loop from `i = 1` to `K`.
   - For each `i`, recursively call `kfib(n - i, K)` and add the result to `sum`.

3. **Final Result**

   - After the loop, move the sum (`esi`) into `eax` as the final result.

#### Parameter mapping

- `ebx` - `n`
- `ecx` - `K`
- `edx` - loop counter (`i`)
- `esi` - sum accumulator
- `edi` - temporary value for calculating `n - i`
- `eax` - return value

---

## Task 4 – Composite Palindrome

This function determines whether the input string of length `len` is a palindrome.

### Implementation Details

- Subtask 1 - Palindrome Check

  - Repeatedly compare characters at positions `i` and `j`.
  - If characters mismatch: return `0` (not a palindrome).
  - If they match: increment `i`, decrement `j`, and continue.
  - If `i >= j`, the function exits the loop and returns `1` (confirmed palindrome).

- Subtask 2 - Composite Palindrome
  The `composite_palindrome` function was not implemented.
