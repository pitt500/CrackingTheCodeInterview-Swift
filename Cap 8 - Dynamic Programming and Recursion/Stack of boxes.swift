struct Box: CustomStringConvertible {
  let height: Int
  let width: Int
  let depth: Int

  var description: String {
    "height: \(height), width: \(width), depth: \(depth)\n"
  }
}

extension Box: Comparable {
  static func < (lhs: Box, rhs: Box) -> Bool {
    lhs.height < rhs.height && lhs.width < rhs.width && lhs.depth < rhs.depth
  }
}

class BasicStackOfBoxes {
  func getTallestStack(boxes: [Box]) -> Int {
    let sortedBoxes = boxes.sorted(by: { $0.height > $1.height })
    var maxHeight = 0

    for i in 0..<sortedBoxes.count {
      let height = getHeight(sortedBoxes, i)
      maxHeight = max(height, maxHeight)
    }

    return maxHeight
  }

  private func getHeight(_ boxes: [Box], _ index: Int) -> Int {
    let bottomBox = boxes[index]
    var maxHeight = 0

    for i in (index+1)..<boxes.count {
      if boxes[i] < bottomBox {
        let height = getHeight(boxes, i)
        maxHeight = max(height, maxHeight)
      }
    }

    maxHeight += bottomBox.height
    return maxHeight
  }

  func run(boxes: [Box]) {
    let startingPoint = CFAbsoluteTimeGetCurrent()
    print(getTallestStack(boxes: boxes))
    let totalTime = CFAbsoluteTimeGetCurrent() - startingPoint
    print("Total time: \(totalTime) seconds")
  }
}

class MemoStackOfBoxes {
  func getTallestStack(boxes: [Box]) -> Int {
    let sortedBoxes = boxes.sorted(by: { $0.height > $1.height })

    //Each index represent the height from ith value to the end.
    var cache = [Int](repeating: 0, count: boxes.count)

    var maxHeight = 0

    for i in 0..<sortedBoxes.count {
      let height = getHeight(sortedBoxes, i, cache: &cache)
      maxHeight = max(height, maxHeight)
    }

    return maxHeight
  }

  private func getHeight(_ boxes: [Box], _ index: Int, cache: inout [Int]) -> Int {
    if index < boxes.count && cache[index] > 0 {
      return cache[index]
    }

    let bottomBox = boxes[index]
    var maxHeight = 0

    for i in (index+1)..<boxes.count {
      if boxes[i] < bottomBox {
        let height = getHeight(boxes, i, cache: &cache)
        maxHeight = max(height, maxHeight)
      }
    }

    maxHeight += bottomBox.height
    cache[index] = maxHeight

    return maxHeight
  }

  func run(boxes: [Box]) {
    let startingPoint = CFAbsoluteTimeGetCurrent()
    print(getTallestStack(boxes: boxes))
    let totalTime = CFAbsoluteTimeGetCurrent() - startingPoint
    print("Total time: \(totalTime) seconds")
  }
}


let boxes = [
  Box(height: 4, width: 6, depth: 3),
  Box(height: 2, width: 4, depth: 4),
  Box(height: 6, width: 3, depth: 5),
  Box(height: 10, width: 5, depth: 3),
  Box(height: 8, width: 4, depth: 2),
  Box(height: 7, width: 1, depth: 8),
  Box(height: 3, width: 5, depth: 1),
  Box(height: 8, width: 5, depth: 1),
  Box(height: 4, width: 5, depth: 4),
  Box(height: 9, width: 5, depth: 7),
  Box(height: 7, width: 3, depth: 3),
  Box(height: 3, width: 6, depth: 2),
]

let sol = BasicStackOfBoxes()
sol.run(boxes: boxes)

let sol2 = MemoStackOfBoxes()
sol2.run(boxes: boxes)
