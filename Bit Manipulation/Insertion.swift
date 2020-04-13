class BitInsertionSolution {
  func insertBits(n: Int, m: Int, i: Int, j: Int) -> Int {
    var newNumber = n
    var bitPosition = i

    for bit in 0...(j - i) {
      let isBit1 = getBit(num: m, bit: bit)
      newNumber = udpdateBit(num: newNumber, bit: bitPosition,
                             isBit1: isBit1)
      bitPosition += 1
    }

    return newNumber
  }
  
  private func getBit(num: Int, bit: Int) -> Bool {
    return num & (1 << bit) != 0
  }

  private func udpdateBit(num: Int, bit: Int, isBit1: Bool) -> Int {
    let value = isBit1 ? 1 : 0
    let mask = ~(1 << bit)
    return (num & mask) | (value << bit)
  }
}
