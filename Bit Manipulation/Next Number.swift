class NextNumberSolution {
  func findNextNumber(num: Int) -> (min: Int, max: Int) {
    let numBits = countBits(num: num)
    var min = -1
    var max = -1

    for n in stride(from: num - 1, to: 0, by: -1) {
      if numBits == countBits(num: n) {
        min = n
        break
      }
    }

    for n in (num+1)... {
      if numBits == countBits(num: n) {
        max = n
        break
      }
    }

    return (min: min, max: max)
  }

  private func countBits(num: Int) -> Int {
    var n = num
    var counter = 0

    while n > 0 {
      if n%2 == 1 {
        counter += 1
      }

      n = n >> 1
    }
    return counter
  }
}

//Better
class BetterNextNumberSolution {
  func findNextNumber(num: Int) -> (min: Int, max: Int) {
    let min = getMin(num)
    let max = getMax(num)

    return (min, max)
  }

  func getMin(_ num: Int) -> Int {
    guard num > 1 else { return 0 }
    var n = num

    let bitInfo = countBitsAndFindFirstNonTrailingOne(num: num)
    let onePosition = bitInfo.numOnes + bitInfo.numZeros

    if onePosition > (Int.bitWidth - 1)  || onePosition <= 0 {
      return -1
    }

    //Clear all bits from 0 to onePosition
    n &= ~0 << (onePosition + 1)


    let a = 1 << (bitInfo.numOnes + 1) // 0s with 1 at onePosition
    let b = a - 1 // 0s followed by numOnes + 1 ones

    // numOnes + 1 ones followed by numZeros - 1 zeros
    let c = b << (bitInfo.numZeros - 1)

    //Insert numOnes + 1 ones next to the right of onePosition
    n |= c

    return n
  }

  func getMax(_ num: Int) -> Int {
    var n = num

    let bitInfo = countBitsAndFindFirstNonTrailingZero(num: num)
    let zeroPosition = bitInfo.numOnes + bitInfo.numZeros

    if zeroPosition > (Int.bitWidth - 1)  || zeroPosition <= 0 {
      return -1
    }

    //Add 1 at zeroPosition
    n |= (1 << zeroPosition)

    //Clear all bits from zeroPosition
    n &= ~((1 << zeroPosition) - 1)

    //Add numOnes - 1 from right to left
    n |= (1 << (bitInfo.numOnes - 1)) - 1
    return n
  }

  func countBitsAndFindFirstNonTrailingZero(num: Int)
    -> (numOnes: Int, numZeros: Int) {
    var n = num
    var counterOnes = 0
    var counterZeros = 0

    while n > 0 {
      if n%2 == 1 {
        counterOnes += 1
      } else if counterOnes > 0 {
        return (counterOnes, counterZeros)
      } else {
        counterZeros += 1
      }
      n >>= 1
    }

    return (counterOnes, counterZeros)
  }

  func countBitsAndFindFirstNonTrailingOne(num: Int)
    -> (numOnes: Int, numZeros: Int) {
      var n = num
      var counterOnes = 0
      var counterZeros = 0

      while n & 1 == 1 {
        counterOnes += 1
        n >>= 1
      }

      if n == 0 {
        return (-1, -1)
      }

      while n & 1 == 0 && n != 0 {
        counterZeros += 1
        n >>= 1
      }

      return (counterOnes, counterZeros)
  }

}

//Best
class BestNextNumberSolution {
  func findNextNumber(num: Int) -> (min: Int, max: Int) {
    return (getMin(num), getMax(num))
  }

  func getMin(_ num: Int) -> Int {
    guard num > 1 else { return 0 }

    let bitInfo = countBitsAndFindFirstNonTrailingOne(num: num)
    let onePosition = bitInfo.numOnes + bitInfo.numZeros

    if onePosition > (Int.bitWidth - 1)  || onePosition <= 0 {
      return -1
    }

    return num - (1 << bitInfo.numOnes) - (1 << (bitInfo.numZeros - 1)) + 1
  }

  func getMax(_ num: Int) -> Int {
    let bitInfo = countBitsAndFindFirstNonTrailingZero(num: num)
    let zeroPosition = bitInfo.numOnes + bitInfo.numZeros

    if zeroPosition > (Int.bitWidth - 1)  || zeroPosition <= 0 {
      return -1
    }

    return num + (1 << bitInfo.numZeros) + (1 << (bitInfo.numOnes - 1)) - 1
  }

  func countBitsAndFindFirstNonTrailingZero(num: Int)
    -> (numOnes: Int, numZeros: Int) {
    var n = num
    var counterOnes = 0
    var counterZeros = 0

    while n > 0 {
      if n%2 == 1 {
        counterOnes += 1
      } else if counterOnes > 0 {
        return (counterOnes, counterZeros)
      } else {
        counterZeros += 1
      }
      n >>= 1
    }

    return (counterOnes, counterZeros)
  }

  func countBitsAndFindFirstNonTrailingOne(num: Int)
    -> (numOnes: Int, numZeros: Int) {
      var n = num
      var counterOnes = 0
      var counterZeros = 0

      while n & 1 == 1 {
        counterOnes += 1
        n >>= 1
      }

      if n == 0 {
        return (-1, -1)
      }

      while n & 1 == 0 && n != 0 {
        counterZeros += 1
        n >>= 1
      }
      return (counterOnes, counterZeros)
  }

}
