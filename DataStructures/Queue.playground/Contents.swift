import Foundation
import XCTest

protocol QueueProtocol {
    associatedtype T

    var isEmpty: Bool { get }
    var count: Int { get }
    var front: T? { get }
    var rear: T? { get }

    func enqueue(_ : T)

    func dequeue() -> T?
}

class Queue<T: Comparable> {
    private var array = Array<T>()

    var count: Int {
        return array.count
    }

    var isEmpty: Bool {
        return array.isEmpty
    }

    func enqueue(_ element: T) {
        array.append(element)
    }

    func dequeue() -> T? {
        guard !array.isEmpty else {
            return nil
        }

        return array.removeFirst()
    }

    func peek() -> T? {
        return array.first
    }
}

class QueueWithStacks<T: Comparable> {

    private let stackOne = Stack<T>()
    private let stackTwo = Stack<T>()

    var isEmpty: Bool {
        return stackOne.isEmpty() && stackTwo.isEmpty()
    }

    var count: Int {
        return stackOne.count + stackTwo.count
    }

    var front: T? {
        if !stackOne.isEmpty() {
            return stackOne.bottom()
        } else {
            return stackTwo.peek()
        }
    }

    var rear: T? {
        if !stackOne.isEmpty() {
            return stackOne.peek()
        } else {
            return stackTwo.bottom()
        }
    }

    /// adding an element to the stack.
    func enqueue(_ element: T) {
        stackOne.push(element)
    }

    /// removing an element from the stack.
    func dequeue() -> T? {
        var rearElement: T?

        if stackOne.isEmpty() && stackTwo.isEmpty() {
            rearElement = nil
        } else if !stackTwo.isEmpty() {
            rearElement = stackTwo.pop()
        } else {
            while !stackOne.isEmpty() {
                stackTwo.push(stackOne.peek()!)
                stackOne.pop()

            }
            rearElement = stackTwo.pop()
        }

        return rearElement
    }
}

class QueueWithStack<T>: QueueProtocol {
    private var stack = Stack<T>()

    var isEmpty: Bool {
        return stack.isEmpty()
    }

    var count: Int {
        return stack.count
    }

    var front: T? {
        return stack.peek()
    }

    var rear: T? {
        return stack.bottom()
    }

    func enqueue(_ element: T) {
        stack.push(element)
    }

    func dequeue() -> T? {
        return recurseDequeue()
    }

    private func recurseDequeue() -> T? {
        if stack.isEmpty() {
            return nil
        }

        let popped = stack.pop()

        if stack.isEmpty() {
            return popped
        }

        let item = recurseDequeue()
        stack.push(popped!)

        return item
    }
}

class TestQueueWithArray: XCTestCase {
    let queue = Queue<Character>()

    func testEnqueue() {
        queue.enqueue("A")
        queue.enqueue("B")
        queue.enqueue("C")

        XCTAssert(queue.isEmpty == false)
        XCTAssert(queue.count == 3)
    }

    func testDequeue() {
        queue.enqueue("A")
        queue.enqueue("B")
        queue.enqueue("C")

        let dequeuedElement = queue.dequeue()

        XCTAssert(dequeuedElement == "A")
        XCTAssert(queue.isEmpty == false)
        XCTAssert(queue.count == 2)
    }

    func testDequeueOnEmpty() {
        let dequeuedElement = queue.dequeue()

        XCTAssert(dequeuedElement == nil)
        XCTAssert(queue.isEmpty == true)
        XCTAssert(queue.count == 0)
    }
}

class TestQueueWithStack: XCTestCase {
    let queue = QueueWithStack<Character>()

    func testEnqueue() {
        queue.enqueue("A")
        queue.enqueue("B")
        queue.enqueue("C")

        XCTAssert(queue.isEmpty == false)
        XCTAssert(queue.count == 3)
    }

    func testDequeue() {
        queue.enqueue("A")
        queue.enqueue("B")
        queue.enqueue("C")

        let dequeuedElement = queue.dequeue()

        XCTAssert(dequeuedElement == "A")
        XCTAssert(queue.isEmpty == false)
        XCTAssert(queue.count == 2)
    }

    func testDequeueOnEmpty() {
        let dequeuedElement = queue.dequeue()

        XCTAssert(dequeuedElement == nil)
        XCTAssert(queue.isEmpty == true)
        XCTAssert(queue.count == 0)
    }
}

class TestQueueWithStacks: XCTestCase {

    let queue = QueueWithStacks<Character>()

    func testEnqueue() {
        queue.enqueue("A")
        queue.enqueue("B")
        queue.enqueue("C")

        XCTAssert(queue.isEmpty == false)
        XCTAssert(queue.count == 3)
    }

    func testDequeue() {
        queue.enqueue("A")
        queue.enqueue("B")
        queue.enqueue("C")

        let dequeuedElement = queue.dequeue()

        XCTAssert(dequeuedElement == "A")
        XCTAssert(queue.isEmpty == false)
        XCTAssert(queue.count == 2)

        XCTAssert(queue.front == "B")
        XCTAssert(queue.rear == "C")
    }

    func testDequeueAllElements() {
        queue.enqueue("A")
        queue.enqueue("B")
        queue.enqueue("C")

        let dequeuedElOne = queue.dequeue()
        XCTAssert(dequeuedElOne == "A")
        XCTAssert(queue.front == "B")
        XCTAssert(queue.rear == "C")

        let dequeuedElTwo = queue.dequeue()
        XCTAssert(dequeuedElTwo == "B")
        XCTAssert(queue.front == "C")
        XCTAssert(queue.rear == "C")

        let dequeuedElThree = queue.dequeue()
        XCTAssert(dequeuedElThree == "C")
        XCTAssert(queue.front == nil)
        XCTAssert(queue.rear == nil)

        XCTAssert(queue.isEmpty == true)
        XCTAssert(queue.count == 0)
    }

    func testDequeueOnEmpty() {
        let dequeuedElement = queue.dequeue()

        XCTAssert(dequeuedElement == nil)
        XCTAssert(queue.isEmpty == true)
    }
}

TestQueueWithStack.defaultTestSuite.run()
TestQueueWithArray.defaultTestSuite.run()
TestQueueWithStacks.defaultTestSuite.run()
