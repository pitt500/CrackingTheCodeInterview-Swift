class SolutionAnagram {

  func groupAnagrams1(array: [String]) -> [[String]] {
    var results: [String: [String]] = [:]

    for word in array {
      let sorted = String(word.sorted())

      if results[sorted] == nil {
        results[sorted] = [word]
      } else {
        results[sorted]!.append(word)
      }
    }

    return results.map { $0.value }
  }

  // One line solution
  func groupAnagrams2(array: [String]) -> [[String]] {
    return Dictionary(
      grouping: array,
      by: { String($0.sorted()) }
    ).map { $0.value }
  }
}

let sol = SolutionAnagram()

print(sol.groupAnagrams2(array: ["eat", "bat", "play", "ate", "tab", "tea"]))
