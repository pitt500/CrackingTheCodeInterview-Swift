class PermutationsWithDups {

  func getPermutations(_ string: String) -> [String] {
    var result = [String]()
    var dict = calculateDuplicates(string)
    getPerms(&dict, "", string.count, &result)

    return result
  }

  func calculateDuplicates(_ string: String) -> [Character: Int] {
    var dict = [Character: Int]()

    for char in string {
      if dict[char] == nil {
        dict[char] = 1
      } else {
        dict[char]! += 1
      }
    }

    return dict
  }

  private func getPerms(_ frequency: inout [Character: Int], _ prefix: String, _ remaining: Int, _ result: inout [String]) {
    if remaining == 0 {
      result.append(prefix)
      return
    }

    for char in frequency.keys {
      let count = frequency[char]!

      if count > 0 {
        frequency[char]! = count - 1
        print("\(prefix)\(char), remaining: \(remaining - 1)")
        getPerms(&frequency, "\(prefix)\(char)", remaining - 1, &result)

        // This enable the check for next character and add it to prefix
        frequency[char]! = count
      }
    }
  }
}
