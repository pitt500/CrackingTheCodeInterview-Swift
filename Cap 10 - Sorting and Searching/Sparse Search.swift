class SolutionSparseSearch {
  func search(word: String, array: [String]) -> Int? {
    guard !array.isEmpty else { return nil }

    var start = 0
    var end = array.count - 1

    while start < end {
      var mid = start + (end - start) / 2

      if array[mid].isEmpty {
        mid = getMiddleIndex(array: array, start: start, mid: mid, end: end)

        if mid == -1 { return nil }
      }

      if word == array[mid] {
        return mid
      } else if word > array[mid] {
        start = mid + 1
      } else {
        end = mid - 1
      }

    }

    return nil
  }

  private func getMiddleIndex(array: [String], start: Int, mid: Int, end: Int) -> Int {
    var left = mid - 1
    var right = mid + 1


    while true {
      if left < start && right > end {
        return -1
      } else if right <= end && !array[right].isEmpty {
        return right
      } else if left >= start && !array[left].isEmpty {
        return left
      }

      right += 1
      left -= 1
    }
  }
}


let sol = SolutionSparseSearch()

if let index = sol.search(word: "car", array: ["all","","","","","base","","", "border", "","", "car", "","delta", ""]) {
  print("Index found: \(index)")
} else {
  print("Not found")
}
