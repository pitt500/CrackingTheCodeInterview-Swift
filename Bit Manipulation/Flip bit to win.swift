class FlipBitSolution {
  func flipBit(num: Int) -> Int {
    //All bits are 1
    if ~num == 0 { return Int.bitWidth }

    var bit1Counter = 0
    var previousCounter = 0
    var maxCounter = 0
    var consecutive0 = 0

    for i in 0..<Int.bitWidth {
      let isBit1 = num & (1 << i) != 0

      if isBit1 {
        bit1Counter += 1
      } else {
        if bit1Counter == 0 { //no 1s found yet
          consecutive0 += 1
        } else if consecutive0 == 1 { // a bridge with other 1s: 11..101..11
          maxCounter = max(maxCounter, bit1Counter + previousCounter + 1)
        } else if maxCounter < bit1Counter {
          maxCounter = bit1Counter
        }

        previousCounter = bit1Counter
        if bit1Counter > 0 { consecutive0 = 1 }

        bit1Counter = 0
      }
    }

    if consecutive0 == 1 {
      maxCounter = max(maxCounter, bit1Counter + previousCounter + 1)
    }

    return maxCounter
  }
}
