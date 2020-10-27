import Foundation
import XCTest

struct Heap<T: Comparable> {

    // MARK: Properties

    var collection: [T]
    var sorted: (T, T) -> Bool

    var isEmpty: Bool {
        return collection.isEmpty
    }
    var count: Int {
        return collection.count
    }
    var peek: T? {
        return collection.first
    }

    // MARK: Initializer
    init(_ items: [T], _ sort: @escaping (T, T) -> Bool) {
        collection = items
        sorted = sort
        buildHeap()
    }

    // MARK: Helper functions

    func isRoot(_ index: Int) -> Bool {
        index == 0
    }

    func leftChildIndex(of index: Int) -> Int {
        (index * 2) + 1
    }

    func rightChildIndex(of index: Int) -> Int {
        (index * 2) + 2
    }

    func parentIndex(of index: Int) -> Int {
        (index - 1) / 2
    }

    /// Calculates the priority of the two elements in the collection at the given indices.
    /// Returns true if the element at the first index has a higher priority than the second index.
    func isHigherPrioriy(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return sorted(collection[firstIndex], collection[secondIndex])
    }

    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < collection.count else {
            return parentIndex
        }

        return isHigherPrioriy(at: parentIndex, than: childIndex) ? parentIndex : childIndex
    }

    /// Calculates the highest priority of the parent with its left child, then uses that index to calculate the highest priority index compared to the right child.
    func highestPriorityIndex(for parentIndex: Int) -> Int {
        highestPriorityIndex(of: highestPriorityIndex(of: parentIndex, and: leftChildIndex(of: parentIndex)), and: rightChildIndex(of: parentIndex))
    }

    mutating func swapIndex(_ index: Int, with indexToSwap: Int) {
        collection.swapAt(indexToSwap, index)
    }

    // MARK: Functions

    /// Helper function to create a prioritized heap from an unsorted array.
    /// Iterates through the first half of the collections index in reverse order.
    /// This is because the first half of the heap, is every parent node in the heap.
    mutating func buildHeap() {
        for index in (0..<collection.count).reversed() {
            siftDown(elementAtIndex: index)
        }
    }

    mutating func enqueue(_ element: T) {
        collection.append(element)
        siftUp(elementAtIndex: collection.count - 1)
    }

    mutating func siftUp(elementAtIndex index: Int) {
        let parentInd = parentIndex(of: index)
        guard !isRoot(index), isHigherPrioriy(at: index, than: parentInd) else {
            return // Return if element is root position OR element has a lower priority than the parent
        }

        swapIndex(index, with: parentInd)
        siftUp(elementAtIndex: parentInd)
    }

    mutating func dequeue() -> T? {
        guard !isEmpty else {
            return nil
        }

        collection.swapAt(collection.count - 1, 0)
        let removedElement = collection.removeLast()

        if !isEmpty {
            siftDown(elementAtIndex: 0)
        }

        return removedElement
    }

    mutating func siftDown(elementAtIndex index: Int) {
        let ind = highestPriorityIndex(for: index)
        if index == ind {
            return
        }

        collection.swapAt(index, ind)
        siftDown(elementAtIndex: ind)
    }
}


class TestHeap: XCTestCase {

    func testHeapCreation() {
        let heap = Heap<Int>([3, 2, 8, 5, 0], >)

        XCTAssert(heap.peek == 8)
        XCTAssert(heap.count == 5)
        XCTAssert(heap.isEmpty == false)
    }

    func testMaxHeap() {
        let heap = Heap<Int>([3, 2, 8, 5, 0], >)

        XCTAssert(heap.peek == 8)
    }

    func testMinHeap() {
        let heap = Heap<Int>([3, 2, 8, 5, 0], <)

        XCTAssert(heap.peek == 0)
    }

    func testEnqueue() {
        var heap = Heap<Int>([3, 2, 8, 5, 0], >)
        XCTAssert(heap.peek == 8)

        heap.enqueue(22)
        XCTAssert(heap.peek == 22)

        heap.enqueue(12)
        XCTAssert(heap.peek == 22)
    }

    func testEnqueueOnEmpty() {
        var heap = Heap<Int>([], >)
        XCTAssert(heap.peek == nil)

        heap.enqueue(22)
        XCTAssert(heap.peek == 22)

        heap.enqueue(12)
        XCTAssert(heap.peek == 22)

        heap.enqueue(33)
        XCTAssert(heap.peek == 33)

        XCTAssert(heap.isEmpty == false)
        XCTAssert(heap.count == 3)
    }

    func testDequeue() {
        var heap = Heap<Int>([3, 2, 8, 5, 0], >)

        let firstDequeued = heap.dequeue()

        XCTAssert(firstDequeued == 8)
        XCTAssert(heap.peek == 5)
        XCTAssert(heap.count == 4)

        let secondDequeued = heap.dequeue()

        XCTAssert(secondDequeued == 5)
        XCTAssert(heap.peek == 3)
        XCTAssert(heap.count == 3)
    }

    func testDequeueOnEmpty() {
        var heap = Heap<Int>([], <)

        let firstDequeued = heap.dequeue()

        XCTAssert(firstDequeued == nil)
        XCTAssert(heap.isEmpty == true)
        XCTAssert(heap.count == 0)
        XCTAssert(heap.peek == nil)
    }
}

TestHeap.defaultTestSuite.run()
