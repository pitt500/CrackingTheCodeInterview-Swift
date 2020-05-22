class MinStack {
    private var stack: [Int]
    private var minStack: [Int]

    /** initialize your data structure here. */
    init() {
        self.stack = []
        self.minStack = []
    }

    func push(_ x: Int) {
        stack.append(x)

        guard let min = minStack.last else {
            minStack.append(x)
            return
        }

        if  min >= x {
            minStack.append(x)
        }
    }

    func pop() {
        let value = stack.popLast()

        if let min = minStack.last, min == value {
            minStack.popLast()
        }
    }

    func top() -> Int {
        if stack.isEmpty { return Int.max }

        return stack.last!
    }

    func getMin() -> Int {
        if minStack.isEmpty { return Int.max }

        return minStack.last!
    }
}

//Output
let minStack = MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin(); // return -3
minStack.pop();
minStack.top();    // return 0
minStack.getMin(); // return -2
