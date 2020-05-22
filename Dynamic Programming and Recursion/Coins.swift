class BasicCoins {
  func waysToGetCents(cents: Int) -> Int {
    let coins = [25, 10, 5, 1]

    return getCentsHelper(cents, coins)
  }

  private func getCentsHelper(_ n: Int,_ coins: [Int]) -> Int {

    if n == 0 {
      return 1
    } else if n < 0 {
      return 0
    }

    var numWays = 0

    for coin in coins where coin <= n {
      numWays += getCentsHelper(n - coin, coins)
    }

    return numWays
  }

  func run() {
    let startingPoint = CFAbsoluteTimeGetCurrent()
    print(waysToGetCents(cents: 45))
    let totalTime = CFAbsoluteTimeGetCurrent() - startingPoint
    print("Total time: \(totalTime) seconds")
  }
}

class MemoCoins {
  func waysToGetCents(cents: Int) -> Int {
    let coins = [25, 10, 5, 1]
    var cache = [Int](repeating: 0, count: cents + 1)

    return getCentsHelper(cents, coins, &cache)
  }

  private func getCentsHelper(_ n: Int,_ coins: [Int],_ cache: inout [Int]) -> Int {

    if n == 0 {
      return 1
    } else if n < 0 {
      return 0
    } else if cache[n] != 0 {
      return cache[n]
    }

    var numWays = 0

    for coin in coins where coin <= n {
      numWays += getCentsHelper(n - coin, coins, &cache)
    }
    cache[n] = numWays
    return cache[n]
  }

  func run() {
    let startingPoint = CFAbsoluteTimeGetCurrent()
    print(waysToGetCents(cents: 45))
    let totalTime = CFAbsoluteTimeGetCurrent() - startingPoint
    print("Total time: \(totalTime) seconds")
  }
}


BasicCoins().run()
//Result: 418060
//Total time: 89.62966096401215 seconds

MemoCoins().run()
//Result: 418060
//Total time: 0.046044111251831055 seconds
