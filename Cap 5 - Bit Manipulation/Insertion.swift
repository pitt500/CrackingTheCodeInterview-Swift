class BitInsertionSolution {
  func insertBits(n: Int, m: Int, i: Int, j: Int) -> Int {
    guard i < j && i >= 0 && j < 32 else { return 0 }

    let allOnes = ~0
    let left = allOnes << (j + 1)
    let right = 1 << (i - 1)

    let mask = left | right
    
    let nCleared = n & mask
    let mShifted = m << i

    return nCleared | mShifted
  }
}
