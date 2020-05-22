class PermutationsWithoutDups {

  func getPermutations(_ string: String) -> [String] {
    if string.count == 1 {
      return [string]
    }

    var mutableString = string
    let letter = mutableString.removeLast()
    let permutations = getPermutations(mutableString)

    var result = [String]()

    for i in 0...mutableString.count {
      for perm in permutations {
        var value = [Character](perm)
        value.insert(letter, at: i)
        result.append(String(value))
      }
    }

    return result
  }
}
