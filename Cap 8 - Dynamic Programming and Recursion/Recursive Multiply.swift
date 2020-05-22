class BasicRecursiveMultiply {
  func multiply(a: Int, b: Int) -> Int {
    let large = max(a, b)
    let small = min(a, b)

    if small == 0 {
      return 0
    }

    return mult(large, small)
  }
  
  private func mult(_ a: Int,_ b: Int) -> Int {
    if a == 1 {
      return b
    }

    let value = a >> 1 //Divided by 2
    let side1 = mult(value, b)
    var side2 = side1

    if a%2 == 1 {
      side2 = mult(value + 1, b)
    }

    return side1 + side2
  }
}

class TopDownRecursiveMultiply {
  func multiply(a: Int, b: Int) -> Int {
    let large = max(a, b)
    let small = min(a, b)

    if small == 0 {
      return 0
    }
    var cache = [Int](repeating: 0, count: large + 1)

    return mult(large, small, &cache)
  }

  private func mult(_ a: Int,_ b: Int,_ cache: inout [Int]) -> Int {
    if a == 1 {
      return b
    } else if cache[a] > 0 {
      return cache[a]
    }

    let value = a >> 1 //Divided by 2
    let side1 = mult(value, b, &cache)
    var side2 = side1

    if a%2 == 1 {
      side2 = mult(value + 1, b, &cache)
    }

    cache[a] = side1 + side2

    return cache[a]
  }
}

class BestRecursiveMultiply {
  func multiply(a: Int, b: Int) -> Int {
    let large = max(a, b)
    let small = min(a, b)

    if small == 0 {
      return 0
    }

    return mult(large, small)
  }

  private func mult(_ a: Int,_ b: Int) -> Int {
    if a == 1 {
      return b
    }

    let value = a >> 1 //Divided by 2
    let side1 = mult(value, b)

    if a%2 == 1 {
      return side1 + side1 + b
    }

    return side1 + side1
  }
}

let startingPoint = CFAbsoluteTimeGetCurrent()
let sol = BasicRecursiveMultiply()
let res = sol.multiply(a: 100000, b: 100000)
let totalTime = CFAbsoluteTimeGetCurrent() - startingPoint
print("result: \(res)")
print("Total time: \(totalTime) seconds")

let startingPoint2 = CFAbsoluteTimeGetCurrent()
let sol2 = TopDownRecursiveMultiply()
let res2 = sol2.multiply(a: 100000, b: 100000)
let totalTime2 = CFAbsoluteTimeGetCurrent() - startingPoint2
print("result: \(res2)")
print("Total time: \(totalTime2) seconds")


let startingPoint3 = CFAbsoluteTimeGetCurrent()
let sol3 = BestRecursiveMultiply()
let res3 = sol3.multiply(a: 100000, b: 100000)
let totalTime3 = CFAbsoluteTimeGetCurrent() - startingPoint3
print("result: \(res3)")
print("Total time: \(totalTime3) seconds")
