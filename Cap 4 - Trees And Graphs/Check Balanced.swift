class TreeNode {
  var value: Int
  var left: TreeNode?
  var right: TreeNode?
  var parent: TreeNode? = nil

  init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
    self.value = value
    self.left = left
    self.right = right
  }
}

class CheckBalancedTree {
  func isTreeBalanced(root: TreeNode?) -> Bool {
    guard let node = root else {
      return false
    }

    let leftHeight = getHeight(node.left)
    let rightHeight = getHeight(node.right)

    return abs(leftHeight - rightHeight) <= 1

  }

  func getHeight(_ node: TreeNode?) -> Int {
    guard let node = node else {
      return 0
    }

    let leftHeight = getHeight(node.left)
    if leftHeight == Int.min { return Int.min }

    let rightHeight = getHeight(node.right)
    if rightHeight == Int.min { return Int.min }

    if abs(leftHeight - rightHeight) > 1 {
      return Int.min
    }

    return max(leftHeight, rightHeight) + 1
  }
}
