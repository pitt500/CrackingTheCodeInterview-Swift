class SolutionSortedSerachNoSize {
  func index(of value: Int, array: [Int]) -> Int? {
    return binarySearch(array: array, target: value)
  }

  // We can use Array.count property in this problem!
  // How can we get the length of array?
  private func binarySearch(array: [Int], target: Int) -> Int? {
    var index = 1

    //Get the length by jumping 2^n steps in the array. O(log n)
    while array[elementAt: index] != nil && array[elementAt: index]! < target {
      index <<= 1
    }

    var start = index >> 1
    var end = index

    while start <= end {
      let mid = start + (end - start) / 2

      let midValue = array[elementAt: mid] ?? -1

      if midValue > target || midValue == -1 {
        end = mid - 1
      } else if midValue < target {
        start = mid + 1
      } else {
        return mid
      }
    }

    return nil
  }
}

extension Array {
    public subscript(elementAt index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

let sol = SolutionSortedSerachNoSize()

if let foundIndex = sol.index(of: 50, array: [3, 5, 8, 10, 10, 13, 17, 35, 43]) {
  print(foundIndex)
} else {
  print("Not found")
}
