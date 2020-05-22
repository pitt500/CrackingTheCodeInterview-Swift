//Three in One - Stack
class ThreeInOneStack {
  var stack: [Int?] = [nil, nil]
  private var middleTopIndex = 1
  private var middleBottomIndex = 1

  enum StackError: Error {
    case invalidStack
  }

  func push(value: Int, atStack stackNumber: Int) throws -> Void {
    if stackNumber > 3 && stackNumber < 0 { throw StackError.invalidStack }

    switch stackNumber {
    case 1:
      stack.insert(value, at: 0)
      middleTopIndex += 1
      middleBottomIndex += 1
    case 2:
      stack.insert(value, at: middleTopIndex)
      middleBottomIndex += 1
    case 3:
      stack.append(value)
    default:
      break
    }
  }

  func pop(fromStack stackNumber: Int) throws -> Int? {
    if stackNumber > 3 && stackNumber < 0 {
      throw StackError.invalidStack
    }

    switch stackNumber {
    case 1:
      if stack.first! == nil {
        return nil
      }

      middleTopIndex -= 1
      middleBottomIndex -= 1
      return stack.remove(at: 0)!
    case 2:
      if stack[middleTopIndex] == nil {
        return nil
      }

      let value = stack.remove(at: middleTopIndex)!
      middleBottomIndex -= 1

      return value
    case 3:
      if stack.last! == nil {
        return nil
      }

      return stack.popLast()!
    default:
      return nil
    }

  }

}

//Output
let stack = ThreeInOneStack()

try stack.push(value: 1, atStack: 1)
try stack.push(value: 2, atStack: 1)

try stack.push(value: 5, atStack: 2)
try stack.push(value: 3, atStack: 2)

try stack.push(value: 4, atStack: 3)
try stack.push(value: 7, atStack: 3)

print(stack.stack)

for i in 1...3 {
 for _ in 1...3 {
   if let value = try? stack.pop(fromStack: i) {
     print("Pop: \(value) at stack #\(i)")
   } else {
     print("Stack #\(i) is empty")
   }

   print(stack.stack)
 }
}
