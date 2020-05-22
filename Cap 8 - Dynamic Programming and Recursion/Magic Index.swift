class BasicMagicIndex{
  func getMagicIndex(array: [Int]) -> Int {
    for i in array.indices {
      if array[i] == i {
        return i
      }
    }

    return -1
  }
}


class BetterMagicIndex{
  func getMagicIndex(array: [Int]) -> Int {
    return getIndex(array, 0, array.count-1)
  }

  private func getIndex(_ array: [Int],_ start: Int,_ end: Int) -> Int {
    if start > end {
      return -1
    }

    let mid = (end + start) / 2

    if array[mid] == mid {
      return mid
    } else if mid > array[mid] {
      return getIndex(array, mid+1, end)
    } else {
      return getIndex(array, start, mid - 1)
    }
  }
}

//Works with duplicated values
class BestMagicIndex {
  func getMagicIndex(array: [Int]) -> Int {
    return getIndex(array, 0, array.count-1)
  }

  private func getIndex(_ array: [Int],_ start: Int,_ end: Int) -> Int {
    if start > end {
      return -1
    }

    let midIndex = (end + start) / 2
    let midValue = array[midIndex]

    if midValue == midIndex {
      return midIndex
    }

    //Left side
    let leftIndex = min(midIndex - 1, midValue)
    let leftResult = getIndex(array, start, leftIndex)
    if leftResult >= 0 {
      return leftResult
    }

    //Right side
    let rightIndex = max(midIndex + 1, midValue)
    return getIndex(array, rightIndex, end)
  }
}
