class PowerSet {
  func getPowerSet(_ array: [Int]) -> [[Int]] {
    if array.count == 0 {
      return [[]]
    }

    var copyArray = array
    let lastElement = copyArray.removeLast()

    let setArray = getPowerSet(copyArray)
    var powerSet = setArray

    for element in setArray {
      powerSet.append(element + [lastElement])
    }

    return powerSet
  }

  func getPowetSetWithBits(_ array: [Int]) -> [[Int]] {
    let numSubsets = (1 << array.count)
    var powerSet: [[Int]] = []
    for i in 0..<numSubsets {
      powerSet.append(convert(num: i, to: array))
    }

    return powerSet
  }

  func convert(num: Int, to set: [Int]) -> [Int] {
    var newSubset: [Int] = []

    var bitNum = num
    var index = 0

    while bitNum > 0 {
      if (bitNum & 1) == 1 {
        newSubset.append(set[index])
      }

      index += 1
      bitNum >>= 1
    }

    return newSubset
  }
}
