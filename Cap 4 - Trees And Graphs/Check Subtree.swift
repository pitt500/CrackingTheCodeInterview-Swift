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

// Check Subtree
class CheckSubtreeSolution {
  func isSubtree(_ rootA: TreeNode?, _ rootB: TreeNode?) -> Bool {
    var treeAResult = ""
    var treeBResult = ""

    preOrder(rootA, &treeAResult)
    preOrder(rootB, &treeBResult)

    return treeAResult.contains(treeBResult)
  }

  func preOrder(_ node: TreeNode?,_ result: inout String) {
    visit(node, &result)

    guard let node = node else {
      return
    }

    preOrder(node.left, &result)
    preOrder(node.right, &result)
  }

  func visit(_ node: TreeNode?,_ result: inout String) {

    guard let node = node else {
        result.append("x ")
        return
    }

    if node.value >= 0 && node.value < 10 {
        result.append("0\(node.value) ")
    } else {
        result.append("\(node.value) ")
    }
  }
}

// Better Solution - CTCI:

class BetterCheckSubtreeSolution {
  func isSubtree(_ rootA: TreeNode?, _ rootB: TreeNode?) -> Bool {
    if rootB == nil {
      return true // Empty tree is always a subtree
    }

    return subtree(rootA, rootB)
  }

  func subtree(_ nodeA: TreeNode?, _ nodeB: TreeNode?) -> Bool {
    if nodeA == nil {
      return false //Big tree empty and subtree not found
    } else if nodeA?.value == nodeB?.value && matchTree(nodeA, nodeB) {
      return true // Subtree found!
    }

    return subtree(nodeA?.left, nodeB) || subtree(nodeA?.right, nodeB)
  }

  func matchTree(_ nodeA: TreeNode?, _ nodeB: TreeNode?) -> Bool {
    if nodeA == nil && nodeB == nil {
      return true // Nothin left in the subtree
    } else if nodeA == nil || nodeB == nil {
      return false // exactly tree is empty, don’t match
    } else if nodeA?.value != nodeB?.value {
      return false
    } else {
      return matchTree(nodeA?.left,nodeB?.left) &&
        matchTree(nodeA?.right,nodeB?.right)
    }
  }
}
