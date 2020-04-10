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

class PathOfSumSolution {
  func countPaths(root: TreeNode?, sum: Int) -> Int {
    guard let node = root else { return 0 }

    let pathsFromRoot = countPathsFromNode(node: root, expectedSum: sum,
                                       currentSum: 0)

    let leftPaths = countPaths(root: node.left, sum: sum)
    let rightPaths = countPaths(root: node.right, sum: sum)

    return pathsFromRoot + leftPaths + rightPaths
  }

  func countPathsFromNode(node: TreeNode?, expectedSum: Int,
                          currentSum: Int) -> Int {
    guard let node = node else { return 0 }
    let current = currentSum + node.value

    var totalPaths = 0

    if current == expectedSum {
      totalPaths += 1
    }

    totalPaths += countPathsFromNode(node: node.left,
                                     expectedSum: expectedSum,
                                     currentSum: current)

    totalPaths += countPathsFromNode(node: node.right,
                                     expectedSum: expectedSum,
                                     currentSum: current)

    return totalPaths
  }
}

//Optimized Solution - CTCI

class BestPathOfSumSolution {
  func countPaths(root: TreeNode?, targetSum: Int) -> Int {
    var pathCount: [Int: Int] = [:]
    return countPaths(root: root, targetSum: targetSum,
                      runningSum: 0, pathCount: &pathCount)
  }

  func countPaths(root: TreeNode?, targetSum: Int,
                  runningSum: Int, pathCount: inout [Int: Int]) -> Int {
    guard let node = root else { return 0 }

    let currentSum = runningSum + node.value
    let sum = currentSum - targetSum
    var totalPaths = pathCount[sum] ?? 0

    if currentSum == targetSum {
      totalPaths += 1
    }

    updatePathCount(pathCount: &pathCount, key: currentSum, delta: 1)

    totalPaths += countPaths(root: node.left, targetSum: targetSum,
                             runningSum: currentSum, pathCount: &pathCount)
    totalPaths += countPaths(root: node.right, targetSum: targetSum,
                             runningSum: currentSum, pathCount: &pathCount)

    updatePathCount(pathCount: &pathCount, key: currentSum, delta: -1)

    return totalPaths
  }

  func updatePathCount(pathCount: inout [Int: Int], key: Int, delta: Int) {
    let newCount = (pathCount[key] ?? 0) + delta

    if newCount == 0 {
      pathCount[key] = nil
    } else {
      pathCount[key] = newCount
    }
  }
}

//        1
//     /     \
//   3        -1
// /   \     /   \
//2     1   4     5
//     /   / \     \
//    1   1   2     6

let leftLevel1 = TreeNode(value: 3)
let rightLevel1 = TreeNode(value: -1)
let root = TreeNode(value: 1, left: leftLevel1, right: rightLevel1)

let node1Level2 = TreeNode(value: 2)
let node2Level2 = TreeNode(value: 1, left: TreeNode(value: 1))
leftLevel1.left = node1Level2
leftLevel1.right = node2Level2

let node3Level2 = TreeNode(value: 4,
                           left: TreeNode(value: 1),
                           right: TreeNode(value: 2))
let node4Level2 = TreeNode(value: 5, right: TreeNode(value: 6))
rightLevel1.left = node3Level2
rightLevel1.right = node4Level2
