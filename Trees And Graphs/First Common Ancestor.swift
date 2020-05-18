class FirstCommonAncestorSolution {

  func firstAncestor(nodeA: TreeNode?, nodeB: TreeNode?) -> TreeNode? {
    //Nodes are nil or root
    guard nodeA?.parent != nil else { return nodeA }
    guard nodeA?.parent != nil else { return nodeB }

    let depthA = countDepth(node: nodeA)
    let depthB = countDepth(node: nodeB)
    let diff = abs(depthA - depthB)

    var deeperNode = depthA > depthB ? nodeA : nodeB
    var shallowerNode = depthA > depthB ? nodeB : nodeA

    for _ in 1...diff {
      deeperNode = deeperNode?.parent
    }

    let maxDepth = max(depthA, depthB)

    for _ in (diff + 1)...maxDepth {
      if deeperNode === shallowerNode {
        return deeperNode
      }
      deeperNode = deeperNode?.parent
      shallowerNode = shallowerNode?.parent
    }

    //Nodes don’t come from the same Tree
    return nil
  }

  private func countDepth(node: TreeNode?) -> Int {
    if node == nil {
      return 0
    }

    return countDepth(node: node?.parent) + 1
  }
}
