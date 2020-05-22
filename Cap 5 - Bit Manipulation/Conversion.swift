class ConversionSolution {
  func bitsToConvert(num a: Int, into b: Int) -> Int {
    var difference = a ^ b
    var counter = 0

    while difference > 0 {
      counter += (difference & 1)
      difference >>= 1
    }

    return counter
  }
}

//Better
class BetterConversionSolution {
  func bitsToConvert(num a: Int, into b: Int) -> Int {
    var difference = a ^ b
    var counter = 0

    while difference > 0 {
      counter += 1
      difference = difference & (difference - 1)
    }

    return counter
  }
}
