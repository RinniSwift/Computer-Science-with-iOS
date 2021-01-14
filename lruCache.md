
# LRU Cache

1. What is an LRU cache
2. API — interface of an LRU cache
3. Understand the different implementations
4. Understand the different types of an LRU cache
5. Implemention using Swift


## What is an LRU cache

LRU - **L**east **R**ecently **U**sed Cache obtains a finite amount of data. Where there must be a priority of the most accessed element at the front, and the least accessed element at the back most, being removed as the cache hits it's capacity.

## APIs

**Key functionalities of LRU caches are**:

- `setObject`: adding the element to the LRU cache.
- `retrieveObject`: retrieving the element from the LRU cache.

Now these will be the two high level functions, or at least what would be accessible from the cache. There may be more underlying functionality that will help achieve and maintain a valid LRU cache state.

## Understanding the different implementations

1. Using a doubly linked list and a dictionary
    The policy here is to move the recently used element to the head of the linkedlist and as the cache will exceed it's limit, the tail will be reassigned to the one before it, with adding the new element as the head. You can see how if we used an array, and added items in, it would steadily increase the run time proportional to the number of items in the array, i.e. cache.\
    The doubly linked list will store a node where the node object holds the key and value.
    The dictionary's key will be the key to retrieve, value being the element.

2. Using a priority queue and dictionary

### [Implementation in Swift](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/DataStructures/LRUCache.playground/Contents.swift)

