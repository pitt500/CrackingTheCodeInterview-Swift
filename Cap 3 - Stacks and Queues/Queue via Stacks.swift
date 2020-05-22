class MyQueue {

    private var stack: [Int]
    private var buffer: [Int]


    /** Initialize your data structure here. */
    init() {
        stack = []
        buffer = []
    }

    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        stack.append(x)
    }

    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        if !buffer.isEmpty {
            return buffer.popLast()!
        }

        createBuffer()

        return buffer.popLast() ?? Int.min
    }

    /** Get the front element. */
    func peek() -> Int {
        if !buffer.isEmpty {
            return buffer.last!
        }

        createBuffer()

        return buffer.last ?? Int.min
    }

    private func createBuffer() {
        while !stack.isEmpty {
            buffer.append(stack.popLast()!)
        }
    }

    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return stack.isEmpty && buffer.isEmpty
    }
}

//Output
let queue = MyQueue();

queue.push(1);
queue.push(2);
queue.peek();  // returns 1
queue.pop();   // returns 1
queue.empty(); // returns false
