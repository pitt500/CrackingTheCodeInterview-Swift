//Sort a Stack
class SortedStack: CustomStringConvertible {
  private var stack: [Int]
  private var aux: [Int]

  init() {
    stack = []
    aux = []
  }

  var isEmpty: Bool {
    return stack.isEmpty
  }

  func pop() -> Int? {
    return stack.popLast()
  }

  func peek() -> Int? {
    return stack.last
  }

  func push(_ value: Int) {
    if let last = peek(), last < value {
      moveToAux(value)
      rollover()
    } else {
      stack.append(value)
    }
  }

  private func moveToAux(_ value: Int) {
    var valueInserted = false
    while !isEmpty {
      aux.append(pop()!)

      if !valueInserted && (stack.isEmpty || value < stack.last!) {
        valueInserted = true
        aux.append(value)
      }
    }
  }

  private func rollover() {
    while !aux.isEmpty {
      stack.append(aux.popLast()!)
    }
  }

  var description: String {
    String(describing: stack)
  }
}

//Output
let stack = SortedStack()

stack.push(5)
stack.push(3)
stack.push(4)
stack.push(2)
stack.push(7)
stack.push(10)

print(stack)

print(stack.peek()!)
stack.pop()

print(stack)
