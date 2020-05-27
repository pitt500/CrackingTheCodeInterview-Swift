enum BooleanSymbol: Character {
  case xor = "^"
  case and = "&"
  case or  = "|"
}

class BasicBooleanEvaluation {
  func countEval(expression: String, result: Bool) -> Int {
    if expression.isEmpty {
      return 0
    }

    if expression.count == 1 {
      return stringToBool(character: expression.first!) == result ? 1 : 0
    }

    let array = [Character](expression)
    var total = 0

    for i in stride(from: 1, to: array.count, by: 2) {
      let left = String(array[0..<i])
      let right = String(array[(i+1)..<array.count])

      let leftTrue = countEval(expression: left, result: true)
      let leftFalse = countEval(expression: left, result: false)
      let rightTrue = countEval(expression: right, result: true)
      let rightFalse = countEval(expression: right, result: false)

      let totalCombinations = (leftTrue + leftFalse) * (rightTrue + rightFalse)
      let totalTrue = getTotalTrue(for: array[i], leftTrue, leftFalse, rightTrue, rightFalse)

      let subTotal = result ? totalTrue : totalCombinations - totalTrue
      total += subTotal
    }

    return total
  }

  private func stringToBool(character: Character) -> Bool {
    character == "1" ? true : false
  }

  private func getTotalTrue(for character: Character,_ leftTrue: Int,_ leftFalse: Int,_ rightTrue: Int,_ rightFalse: Int ) -> Int {
    guard let symbol = BooleanSymbol(rawValue: character) else {
      return 0
    }

    switch symbol {
    case .xor:
      return leftTrue * rightFalse + rightTrue * leftFalse
    case .and:
      return leftTrue * rightTrue
    case .or:
      return leftTrue * rightTrue + leftTrue * rightFalse + leftFalse * rightTrue
    }
  }

  func run(expression: String, result: Bool) {
    let startingPoint = CFAbsoluteTimeGetCurrent()
    let total = countEval(expression: expression, result: result)
    print("Total parenthesis combination: \(total)")
    let totalTime = CFAbsoluteTimeGetCurrent() - startingPoint
    print("Total time: \(totalTime) seconds")
  }
}

class MemoBooleanEvaluation {
  func countEval(expression: String, result: Bool) -> Int {
    var cache = [String: Int]()

    return countEval(expression: expression, result: result, cache: &cache)
  }

  private func countEval(expression: String, result: Bool, cache: inout [String: Int]) -> Int {
    if expression.isEmpty {
      return 0
    }else if expression.count == 1 {
      return stringToBool(character: expression.first!) == result ? 1 : 0
    }

    let key = "\(result)\(expression)"
    if let cached = cache[key] {
      return cached
    }

    let array = [Character](expression)
    var total = 0

    for i in stride(from: 1, to: array.count, by: 2) {
      let left = String(array[0..<i])
      let right = String(array[(i+1)..<array.count])

      let leftTrue = countEval(expression: left, result: true, cache: &cache)
      let leftFalse = countEval(expression: left, result: false, cache: &cache)
      let rightTrue = countEval(expression: right, result: true, cache: &cache)
      let rightFalse = countEval(expression: right, result: false, cache: &cache)

      let totalCombinations = (leftTrue + leftFalse) * (rightTrue + rightFalse)
      let totalTrue = getTotalTrue(for: array[i], leftTrue, leftFalse, rightTrue, rightFalse)

      let subTotal = result ? totalTrue : totalCombinations - totalTrue
      total += subTotal
    }

    cache[key] = total
    return total
  }

  private func stringToBool(character: Character) -> Bool {
    character == "1" ? true : false
  }

  private func getTotalTrue(for character: Character,_ leftTrue: Int,_ leftFalse: Int,_ rightTrue: Int,_ rightFalse: Int ) -> Int {
    guard let symbol = BooleanSymbol(rawValue: character) else {
      return 0
    }

    switch symbol {
    case .xor:
      return leftTrue * rightFalse + rightTrue * leftFalse
    case .and:
      return leftTrue * rightTrue
    case .or:
      return leftTrue * rightTrue + leftTrue * rightFalse + leftFalse * rightTrue
    }
  }

  func run(expression: String, result: Bool) {
    let startingPoint = CFAbsoluteTimeGetCurrent()
    let total = countEval(expression: expression, result: result)
    print("Total parenthesis combination: \(total)")
    let totalTime = CFAbsoluteTimeGetCurrent() - startingPoint
    print("Total time: \(totalTime) seconds")
  }
}

let expression = "1^1^1^1^1^1^1^1"
let sol = BasicBooleanEvaluation()
sol.run(expression: expression, result: false)

let sol2 = MemoBooleanEvaluation()
sol2.run(expression: expression, result: false)
