import Foundation
import XCTest

public protocol Payload {
    associatedtype Key
    associatedtype Value

    var key: Key { get set }
    var value: Value { get set }
}


public struct CachePayload<T: Hashable, U>: Payload {

    public var key: T
    public var value: U

    public init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}


/// A Node class to represent data objects in the LinkedList class
public class Node<T: Payload> {

    public var payload: T
    public var previous: Node<T>?
    public var next: Node<T>?

    public init(value: T) {
        self.payload = value
    }
}


/// An implementation of a generic doubly linkedList.
public class DoublyLinkedList<T: Payload> {

    public var head: Node<T>?
    public var tail: Node<T>?
    var isEmpty: Bool {
        return head == nil && tail == nil
    }

    public var count: Int = 0

    public init() {}

    public func prettyPrint() {
        var nodesPayload = [T]()
        var currNode = head
        while currNode != nil {
            if let payload = currNode?.payload {
                nodesPayload.append(payload)
            }
            currNode = currNode?.next
        }

        for payload in nodesPayload {
            print("(\(payload.key): \(payload.value))", terminator: " -> ")
        }
    }

    /// traverses the nodes and returns the node at the given index and nil if no nodes are found in the LinkedList.
    /// The head starting at index 0.
    func node(at index: Int) -> Node<T>? {
        guard !isEmpty || index == 0 else {
            return head
        }

        var node = head
        for _ in stride(from: 0, to: index, by: 1) {
            node = node?.next
        }

        return node
    }

    /// Adds a node from the value to the LinkedList.
    func add(value: T) {
        let node = Node(value: value)

        guard !isEmpty else {
            head = node
            tail = node
            count += 1
            return
        }

        node.previous = tail
        tail?.next = node
        tail = node
        count += 1
    }

    /// The head starting at index 0
    /// returns bool indicating wether or not the insert was successful.
    public func insert(value: T, at index: Int) -> Bool {
        guard !isEmpty else {
            add(value: value)
            return true
        }

        guard case 0..<count = index else {
            print("NOT WITHIN HERE")
            return false
        }

        let newNode = Node(value: value)

        var currNode = head
        for _ in stride(from: 0, to: index - 1, by: 1) {
            currNode = currNode?.next
        }

        if currNode === head {
            if head === tail {
                newNode.next = head
                head?.previous = newNode
                head = newNode
            } else {
                newNode.next = head
                head = newNode
            }

            count += 1
            return true
        }

        newNode.previous = currNode
        newNode.next = currNode?.next
        currNode?.next?.previous = newNode
        currNode?.next = newNode

        count += 1
        return true
    }

    /// The head starting at index 0
    /// returns bool indicating wether or not the insert was successful.
    public func insert(node: Node<T>, at index: Int) -> Bool {
        guard !isEmpty else {
            head = node
            tail = node
            count += 1
            return true
        }

        guard case 0..<count = index else {
            return false
        }

        var currNode = head
        for _ in stride(from: 0, to: index - 1, by: 1) {
            currNode = currNode?.next
        }

        if currNode === head {
            if head === tail {
                node.next = head
                head?.previous = node
                head = node
            } else {
                node.next = head
                head = node
            }

            count += 1
            return true
        }

        node.previous = currNode
        node.next = currNode?.next
        currNode?.next?.previous = node
        currNode?.next = node

        count += 1
        return true
    }

    /// The head of the LinkedList starting at index 0
    /// Returns bool indicating wether or not the remove was successful
    func remove(at index: Int) -> Bool {
        guard case 0..<count = index else {
            return false
        }

        var currNode = head
        for _ in stride(from: 0, to: index, by: 1) {
            currNode = currNode?.next
        }

        if currNode === head {
            if head === tail {
               head = nil
               tail = nil
            } else {
               head?.next?.previous = nil
               head = head?.next
            }
            count -= 1
            return true
        }

        currNode?.previous?.next = currNode?.next
        currNode?.next?.previous = currNode?.previous

        count -= 1
        return true
    }

    /// Removes the last element from the linkedlist.
    public func remove() -> Bool {
        guard !isEmpty else {
            return false
        }

        if head === tail {
            head = nil
            tail = nil
            count -= 1
            return true
        }

        tail?.previous?.next = nil
        tail = tail?.previous

        count -= 1
        return true
    }

    public func moveToHead(node: Node<T>) {
        guard !isEmpty else {
            return
        }

        if head === node && tail === node {
            // do nothing
        } else if head === node {
            // do nothing
        } else if tail === node {
            tail?.previous?.next = nil
            tail = tail?.previous

            let prevHead = head
            head?.next?.previous = node
            head = node
            head?.next = prevHead
        } else {
            var currNode = head
            while currNode?.next !== node && currNode !== tail {
                currNode = currNode?.next
            }

            currNode?.next = node.next
            node.next?.previous = currNode

            let prevHead = head
            head = node
            head?.next = prevHead
            prevHead?.previous = head
        }
    }
}


public class TestDoublyLinkedList: XCTestCase {

    var linkedList = DoublyLinkedList<CachePayload<String, Int>>()

    func testMoveToHeadOnEmptyLinkedList() {
        let rinni = CachePayload(key: "Rinni", value: 21)
        let node = Node(value: rinni)

        linkedList.moveToHead(node: node)

        XCTAssert(linkedList.isEmpty ==  true)
        XCTAssert(linkedList.head ==  nil)
        XCTAssert(linkedList.tail ==  nil)
    }

    func testMoveTailToHead() {
        let rinni = CachePayload(key: "Rinni", value: 21)
        let sarin = CachePayload(key: "Sarin", value: 21)

        linkedList.add(value: rinni)
        linkedList.add(value: sarin)
        linkedList.moveToHead(node: linkedList.tail!)

        XCTAssert(linkedList.isEmpty == false)
        XCTAssert(linkedList.head?.payload.key == "Sarin")
        XCTAssert(linkedList.tail?.payload.key == "Rinni")
    }

    func testMoveHeadToHead() {
        let rinni = CachePayload(key: "Rinni", value: 21)
        let sarin = CachePayload(key: "Sarin", value: 21)

        linkedList.add(value: rinni)
        linkedList.add(value: sarin)
        linkedList.moveToHead(node: linkedList.head!)

        XCTAssert(linkedList.isEmpty == false)
        XCTAssert(linkedList.head?.payload.key == "Rinni")
        XCTAssert(linkedList.tail?.payload.key == "Sarin")
    }

    func testMoveOneItemToHead() {
        let rinni = CachePayload(key: "Rinni", value: 21)
        linkedList.add(value: rinni)
        linkedList.moveToHead(node: linkedList.tail!)

        XCTAssert(linkedList.isEmpty == false)
        XCTAssert(linkedList.count == 1)
        XCTAssert(linkedList.head?.payload.key == "Rinni")
        XCTAssert(linkedList.tail?.payload.key == "Rinni")
    }

    func testMoveMiddleItemToHead() {
        let rinni = CachePayload(key: "Rinni", value: 21)
        let sarin = CachePayload(key: "Sarin", value: 21)
        let cenz = CachePayload(key: "Cenz", value: 23)
        let ruh = CachePayload(key: "Ruhsane", value: 21)
        let nick = CachePayload(key: "Nick", value: 23)

        linkedList.add(value: rinni)
        linkedList.add(value: sarin)
        linkedList.add(value: cenz)
        linkedList.add(value: ruh)
        linkedList.add(value: nick)

        if let nodey = linkedList.node(at: 2) {
            linkedList.moveToHead(node: nodey)
        }

        XCTAssert(linkedList.head?.payload.key == "Cenz")
        XCTAssert(linkedList.node(at: 1)?.payload.key == "Rinni")
        XCTAssert(linkedList.node(at: 2)?.payload.key == "Sarin")
        XCTAssert(linkedList.node(at: 3)?.payload.key == "Ruhsane")
    }

    func testMoveItemBeforeTailToHead() {
        let rinni = CachePayload(key: "Rinni", value: 21)
        let sarin = CachePayload(key: "Sarin", value: 21)
        let cenz = CachePayload(key: "Cenz", value: 23)
        let ruh = CachePayload(key: "Ruhsane", value: 21)
        let nick = CachePayload(key: "Nick", value: 23)

        linkedList.add(value: rinni)
        linkedList.add(value: sarin)
        linkedList.add(value: cenz)
        linkedList.add(value: ruh)
        linkedList.add(value: nick)

        if let nodey = linkedList.node(at: 3) {
            linkedList.moveToHead(node: nodey)
        }

        XCTAssert(linkedList.head?.payload.key == "Ruhsane")
        XCTAssert(linkedList.node(at: 1)?.payload.key == "Rinni")
        XCTAssert(linkedList.node(at: 2)?.payload.key == "Sarin")
        XCTAssert(linkedList.node(at: 3)?.payload.key == "Cenz")
        XCTAssert(linkedList.node(at: 4)?.payload.key == "Nick")
    }

    func testMoveItemAfterHeadToHead() {
        let rinni = CachePayload(key: "Rinni", value: 21)
        let sarin = CachePayload(key: "Sarin", value: 21)
        let cenz = CachePayload(key: "Cenz", value: 23)
        let ruh = CachePayload(key: "Ruhsane", value: 21)
        let nick = CachePayload(key: "Nick", value: 23)

        linkedList.add(value: rinni)
        linkedList.add(value: sarin)
        linkedList.add(value: cenz)
        linkedList.add(value: ruh)
        linkedList.add(value: nick)

        if let nodey = linkedList.node(at: 1) {
            linkedList.moveToHead(node: nodey)
        }

        XCTAssert(linkedList.head?.payload.key == "Sarin")
        XCTAssert(linkedList.node(at: 1)?.payload.key == "Rinni")
        XCTAssert(linkedList.node(at: 2)?.payload.key == "Cenz")
        XCTAssert(linkedList.node(at: 3)?.payload.key == "Ruhsane")
        XCTAssert(linkedList.node(at: 4)?.payload.key == "Nick")
    }
}
