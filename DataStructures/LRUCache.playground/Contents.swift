import UIKit
import XCTest

class LRUCache<T> {
    struct Element {
        var key: String
        var value: T
    }

    /// Total capacity of the LRU cache.
    private(set) var capacity: UInt
    /// LinkedList will store elements that are most accessed at the head and least accessed at the tail.
    private(set) var linkedList = DoublyLinkedList<Element>()
    /// Dictionary that will store the element, T, at the specified key.
    private(set) var dictionary = [String: T]()

    /// LRUCache requires a capacity which must be greater than 0
    required init(capacity: UInt) {
        self.capacity = capacity
    }

    /// Sets the specified value at the specified key in the cache.
    func setObject(for key: String, value: T) {
        // TODO: add check to move existing value to head.
        if linkedList.count == capacity {
            if let leastAccessedKey = linkedList.tail?.value.key {
                dictionary[leastAccessedKey] = nil
            }
            linkedList.remove()
        }
        let element = Element(key: key, value: value)
        linkedList.insert(value: element, at: 0)
        dictionary[key] = value
    }

    /// Returns the element at the specified key. Nil if it doesn't exist.
    func retrieveObject(at key: String) -> T? {
        return dictionary[key]
    }
}



class TestLRUCache: XCTestCase {

    let cache = LRUCache<Int>(capacity: 5)

    func testEmptyCache() {
        XCTAssert(cache.linkedList.head == nil)
        XCTAssert(cache.linkedList.tail == nil)
        XCTAssert(cache.linkedList.count == 0)
    }

    func testFirstCase() {
        cache.setObject(for: "Rinni", value: 21)

        XCTAssert(cache.linkedList.head?.value.key == "Rinni")
        XCTAssert(cache.linkedList.tail?.value.key == "Rinni")
        XCTAssert(cache.linkedList.head?.value.value == 21)
        XCTAssert(cache.linkedList.tail?.value.value == 21)
        XCTAssert(cache.linkedList.count == 1)

        XCTAssert(cache.dictionary["Rinni"] == 21)
    }

    func testSecondCase() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)

        XCTAssert(cache.linkedList.head?.value.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.value.key == "Rinni")
        XCTAssert(cache.linkedList.head?.value.value == 21)
        XCTAssert(cache.linkedList.tail?.value.value == 21)
        XCTAssert(cache.linkedList.count == 2)

        XCTAssert(cache.dictionary["Rinni"] == 21)
        XCTAssert(cache.dictionary["Sarin"] == 21)
    }

    func testThirdCase() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Sarin", value: 20) // FIXME: test fails here

        XCTAssert(cache.linkedList.head?.value.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.value.key == "Rinni")
        XCTAssert(cache.linkedList.head?.value.value == 20)
        XCTAssert(cache.linkedList.tail?.value.value == 21)
        XCTAssert(cache.linkedList.count == 2)

        XCTAssert(cache.dictionary["Rinni"] == 21)
        XCTAssert(cache.dictionary["Sarin"] == 20)
    }
}

TestLRUCache.defaultTestSuite.run()


TestDoublyLinkedList.defaultTestSuite.run()
