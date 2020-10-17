import Foundation
import XCTest

class Stack<T> {

    private var count = 0
    private var array = Array<T>()

    /// Adds an item to the stack.
    func push(_ element: T) {
        count += 1
        array.append(element)
    }

    /// Removes an item from the stack.
    func pop() {
        array.popLast() != nil ? count -= 1 : ()
    }

    /// Returns the top element of the stack.
    func peek() -> T? {
        return array.last
    }

    /// Returns bool indicating wether the stack is empty or not.
    func isEmpty() -> Bool {
        return count == 0
    }

}

class TestStack: XCTestCase {

    let stack = Stack<Int>()

    func testPush() {
        stack.push(1)
        XCTAssert(stack.peek() == 1)

        stack.push(2)
        XCTAssert(stack.peek() == 2)

        stack.push(3)
        XCTAssert(stack.peek() == 3)
    }

    func testPop() {
        stack.push(1)
        stack.push(2)
        stack.push(3)

        stack.pop()
        XCTAssert(stack.peek() == 2)

        stack.pop()
        XCTAssert(stack.peek() == 1)

        stack.pop()
        XCTAssert(stack.peek() == nil)
    }

    func testPeek() {
        XCTAssert(stack.peek() == nil)

        stack.push(1)
        XCTAssert(stack.peek() == 1)
        stack.push(2)
        XCTAssert(stack.peek() == 2)
        stack.push(3)
        XCTAssert(stack.peek() == 3)
    }

    func testIsEmpty() {
        XCTAssertTrue(stack.isEmpty())

        stack.push(1)
        stack.push(2)

        XCTAssertFalse(stack.isEmpty())

        stack.pop()
        stack.pop()

        XCTAssertTrue(stack.isEmpty())
    }
}

TestStack.defaultTestSuite.run()


class StackWithLinkedList<T: Comparable> {
    private var count = 0
    private var linkedList = LinkedList<T>()

    /// Adds an item to the stack.
    func push(_ element: T) {
        count += 1
        linkedList.append(element)
    }

    /// Removes an item from the stack.
    func pop() {
        linkedList.remove() ? count -= 1 : ()
    }

    /// Returns the top element of the stack.
    func peek() -> T? {
        return linkedList.tail?.data
    }

    /// Returns bool indicating wether the stack is empty or not.
    func isEmpty() -> Bool {
        return count == 0
    }
}

class TestStackWithLinkedList: XCTestCase {

    let stack = StackWithLinkedList<Int>()

    func testPush() {
        stack.push(1)
        XCTAssert(stack.peek() == 1)

        stack.push(2)
        XCTAssert(stack.peek() == 2)

        stack.push(3)
        XCTAssert(stack.peek() == 3)
    }

    func testPop() {
        stack.push(1)
        stack.push(2)
        stack.push(3)

        stack.pop()
        XCTAssert(stack.peek() == 2)

        stack.pop()
        XCTAssert(stack.peek() == 1)

        stack.pop()
        XCTAssert(stack.peek() == nil)
    }

    func testPeek() {
        XCTAssert(stack.peek() == nil)

        stack.push(1)
        XCTAssert(stack.peek() == 1)
        stack.push(2)
        XCTAssert(stack.peek() == 2)
        stack.push(3)
        XCTAssert(stack.peek() == 3)
    }

    func testIsEmpty() {
        XCTAssertTrue(stack.isEmpty())

        stack.push(1)
        stack.push(2)

        XCTAssertFalse(stack.isEmpty())

        stack.pop()
        stack.pop()

        XCTAssertTrue(stack.isEmpty())
    }
}

TestStackWithLinkedList.defaultTestSuite.run()
