class PairwiseSwapSolution {
  func swapped(num: Int) -> Int {
    var even = num << 1
    var odd = num >> 1

    for i in 0..<Int.bitWidth {
      if i%2 == 0 {
        even &= ~(1 << i)
      } else {
        odd &= ~(1 << i)
      }
    }

    return even | odd
  }
}

class BetterPairwiseSwapSolution {
  func swapped(num: Int) -> Int {
    let even = (num << 1) & 0xAAAAAAAA
    let odd = (num >> 1) & ~(0xAAAAAAAA)

    return even | odd
  }
}
