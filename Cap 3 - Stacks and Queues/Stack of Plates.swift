//Stack of Plates
typealias Stack = [Int]
class SetOfStacks: CustomStringConvertible {
  private var stacks: [Stack]
  private var maxCapacity: Int
  private var currentIndex = 0

  init(maxCapacity: Int) {
    self.stacks = [Stack()]
    self.maxCapacity = maxCapacity
  }

  func push(_ value: Int) {

    if let current = stacks.last,  current.count >= maxCapacity {
      stacks.append(Stack())
      currentIndex += 1
    }

    stacks[currentIndex].append(value)
  }

  func pop() -> Int? {

    guard let current = stacks.last else {
      return nil
    }

    if current.isEmpty && stacks.count > 1 {
      stacks.popLast()
      currentIndex -= 1
    }

    guard let value = stacks[currentIndex].popLast()  else {
      return nil
    }

    return value
  }

  func peek() -> Int? {
    return stacks[currentIndex].last
  }

  func pop(at index: Int) -> Int? {
    if index >= stacks.count || index < 0 {
      return nil
    }

    if index == stacks.count - 1 {
      return pop()
    }

    guard let value = stacks[index].popLast() else {
      return nil
    }

    var aux = Stack()
    for i in (index + 1)..<stacks.count {

      while !stacks[i].isEmpty {
        aux.append(stacks[i].popLast()!)
      }

      stacks[i-1].append(aux.popLast()!)

      while !aux.isEmpty {
        stacks[i].append(aux.popLast()!)
      }
    }

    if stacks.last?.isEmpty == true {
      stacks.popLast()
      currentIndex -= 1
    }

    return value
  }

  var description: String {
    var string = ""
    for stack in stacks {
      string += stack.description + " "
    }

    return string
  }
}

// Output
let plates = SetOfStacks(maxCapacity: 4)
plates.push(3)
plates.push(3)
plates.push(3)
plates.push(3)

plates.push(4)
plates.push(4)
plates.push(4)
plates.push(4)

plates.push(5)
plates.push(5)
plates.push(5)
plates.push(5)

plates.push(6)
plates.push(6)
plates.push(4)
plates.push(2)

print(plates)

plates.pop()
plates.pop()
plates.pop()

print(plates)

plates.pop(at: 1)
plates.pop(at: 1)
plates.pop(at: 1)

print(plates)

for _ in 1...9 {
 plates.pop()
}

print(plates)
