class TreeNode {
  var value: Int
  var left: TreeNode?
  var right: TreeNode?

  init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
    self.value = value
    self.left = left
    self.right = right
  }
}


class BSTSequenceSolution {
	func getBSTSequence(root: TreeNode?) -> [[Int]] {
    var result = [[Int]]()

    guard let node = root else {
      result.append([Int]())
      return result
    }

    var prefix = [Int]()
    prefix.append(node.value)

    let leftSubtreeSequence = getBSTSequence(root: node.left)
    let rightSubtreeSequence = getBSTSequence(root: node.right)

    for left in leftSubtreeSequence {
      for right in rightSubtreeSequence {
        var weaved = [[Int]]()
        weaveArray(first: left, second: right, results: &weaved, prefix: prefix)
        result.append(contentsOf: weaved)
      }
    }

    return result
}

func weaveArray(first: [Int], second: [Int],
                  results: inout [[Int]], prefix: [Int]) {
    if first.isEmpty || second.isEmpty {
      var result = prefix
      result.append(contentsOf: first + second)
      results.append(result)
      return
    }

    if let headFirst = first.first {
      weaveArray(first: Array(first[1...]), second: second,
                 results: &results, prefix: prefix + [headFirst])
    }

    if let headSecond = second.first {
      weaveArray(first: first, second: Array(second[1...]),
                 results: &results, prefix: prefix + [headSecond])
    }

  }
}
