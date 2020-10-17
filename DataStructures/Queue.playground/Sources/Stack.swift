public class Stack<T> {

    public var count = 0
    private var array = Array<T>()

    public init() { }

    /// Adds an item to the stack.
    public func push(_ element: T) {
        count += 1
        array.append(element)
    }

    /// Removes an item from the stack.
    public func pop() -> T? {
        let poppedEl = array.popLast()
        poppedEl != nil ? count -= 1 : ()
        return poppedEl
    }

    /// Returns the top element of the stack.
    public func peek() -> T? {
        return array.last
    }

    public func bottom() -> T? {
        return array.first
    }

    /// Returns bool indicating wether the stack is empty or not.
    public func isEmpty() -> Bool {
        return count == 0
    }

}
