class Parens {
  func basicGetPairsOfParenthesis(n: Int) -> Set<String> {
    if n == 1 {
      return ["()"]
    }

    let pairs = basicGetPairsOfParenthesis(n: n - 1)
    var result: Set<String> = []

    for pair in pairs {
      result.insert("(\(pair))")
      result.insert("\(pair)()")
      result.insert("()\(pair)")
    }

    return result
  }

  func bestGetPairOfParenthesis(n: Int) -> [String] {
    var result: [String] = []
    var current = [Character](repeatElement("-", count: n*2))
    addParenthesis(array: &result, leftCounter: n, rightCounter: n, current: &current, index: 0)
    return result
  }

  private func addParenthesis(array: inout [String], leftCounter: Int, rightCounter: Int,
                              current: inout [Character], index: Int) {
    guard leftCounter >= 0 && rightCounter >= 0 else { return }

    if leftCounter == 0 && rightCounter == 0 {
      array.append(String(current))
    } else {
      current[index] = "("
      addParenthesis(array: &array, leftCounter: leftCounter - 1, rightCounter: rightCounter,
                     current: &current, index: index + 1)

      if rightCounter > leftCounter {
        current[index] = ")"
        addParenthesis(array: &array, leftCounter: leftCounter, rightCounter: rightCounter - 1,
                       current: &current, index: index + 1)
      }
    }
  }
}
