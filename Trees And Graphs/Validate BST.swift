class ValidateBST {

  private func isBinarySearchTree(_ root: TreeNode?,
                                  lastPrinted: inout Int?) -> Bool {
    guard let root = root else { return true }


    if !isBinarySearchTree(root.left) {
      return false
    }

    if let last = lastPrinted, root.value <= last {
      return false
    }

    lastPrinted = root.value

    if !isBinarySearchTree(root.right) {
      return false
    }

    return true
  }
  
  func isBinarySearchTree(_ root: TreeNode?) -> Bool {
    var lastPrinted: Int?
    return isBinarySearchTree(root, lastPrinted: &lastPrinted)
  }
}

//Approach #2 - CTCI

class BetterValidateBST {
  func isBinarySearchTree(_ root: TreeNode?) -> Bool {
    return isBinarySearchTree(root, min: nil, max: nil)
  }

  func isBinarySearchTree(_ root: TreeNode?, min: Int?, max: Int?) -> Bool {
    guard let root = root else { return true }

    if let min = min, root.value <= min {
      return false
    }

    if let max = max, root.value > max {
      return false
    }

    if  !isBinarySearchTree(root.left, min: min, max: root.value) ||
        !isBinarySearchTree(root.right, min: root.value, max: max) {
      return false
    }

    return true
  }
}
