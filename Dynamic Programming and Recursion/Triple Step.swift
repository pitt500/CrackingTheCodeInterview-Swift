class BasicTripleStep {
  func getNumWaysRunStairs(n: Int) -> Int {
    if n == 0 {
      return 0
    }

    return numWays(n)
  }

  private func numWays(_ n: Int) -> Int {
    if n == 0 {
      return 1
    } else if n < 0 {
      return 0
    }

    return numWays(n - 3) + numWays(n - 2) + numWays(n - 1)
  }
}

class TopDownTripleStep {
  func getNumWaysRunStairs(n: Int) -> Int {
    if n == 0 {
      return 0
    }

    var cache = [Int: Int]()

    return numWays(n, &cache)
  }

  private func numWays(_ n: Int,_ cache: inout [Int: Int]) -> Int {
    if n == 0 {
      return 1
    } else if n < 0 {
      return 0
    }

    if let cached = cache[n] {
      return cached
    }

    let result = numWays(n - 3, &cache) +
 numWays(n - 2, &cache) +
 numWays(n - 1, &cache)

    cache[n] = result
    return result
  }
}
