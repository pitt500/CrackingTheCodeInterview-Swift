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

class RandomNodeSolution {
  private var root: TreeNode?
  private var nodes: [TreeNode] = []

  init(root: TreeNode?) {
    self.root = root
  }

  func getRandomNode() -> TreeNode? {
    if root == nil {
      return nil
    }

    let number = Int.random(in: 0..<nodes.count)

    return nodes[number]
  }

  func insert(_ value: Int) {
    var node = root

    while node != nil {
      if node!.value <= value {
        if node?.left == nil {
          node?.left = TreeNode(value: value)
          nodes.append(node!.left!)
          break
        } else {
          node = node?.left
        }
      } else {
        if node?.right == nil {
          node?.right = TreeNode(value: value)
          nodes.append(node!.right!)
          break
        } else {
          node = node?.right
        }
      }
    }

  }

  func delete(value: Int) {
    var node = root

    while node != nil {
      if node?.value == value {
        if let index = nodes.firstIndex(where: { $0 === node }) {
          nodes.remove(at: index)
        }

        if node?.left == nil && node?.right == nil {
          node = nil
        } else if node?.left == nil {
          node = node?.right
        } else if node?.right == nil {
          node = node?.left
        } else {
          node = node?.left
          node?.left = nil
        }

      } else {
        if node!.value <= value {
          node = node?.left
        } else {
          node = node?.right
        }
      }
    }
  }

  func find(value: Int) -> TreeNode? {
    var node = root

    while node != nil {
      if node?.value == value {
        return node
      } else {
        if node!.value <= value {
          node = node?.left
        } else {
          node = node?.right
        }
      }
    }

    return nil
  }
}

//CTCI Solution: Get left and right size to balance equality of being choice

class RandomTree {
  var root: TreeNode2?

  init(root: TreeNode2) {
    self.root = root
  }

  var size: Int {
    return root == nil ? 0 : root!.size
  }

  func getRandomNode() -> TreeNode2? {
    if root == nil { return nil }

    let index = Int.random(in: 0...size)
    return root?.getIthNode(index: index)
  }

  func insert(value: Int) {
    if root == nil {
      root = TreeNode2(value: value)
    } else {
      root?.insert(value: value)
    }
  }
}

class TreeNode2 {
  var value: Int
  var left: TreeNode2?
  var right: TreeNode2?
  var size = 0

  init(value: Int, left: TreeNode2? = nil, right: TreeNode2? = nil) {
    self.value = value
    self.left = left
    self.right = right
    self.size = 1
  }

  /*
   // Implementation that calculate random every time. Not optimal.
   func getRandomNode() -> TreeNode? {
   let leftSize = left == nil ? 0 : left.size
   let index = Int.random(in: 0...size)

   if index < leftSize {
   	return left.getRandomNode()
   } else if index == leftSize {
   	return self
   } else {
   	return right.getRandomNode()
   }
   }
   */

  func getIthNode(index: Int) -> TreeNode2? {
    let leftSize = left == nil ? 0 : left!.size
    if index < leftSize {
      return left?.getIthNode(index: index)
    } else if index == leftSize {
      return self
    } else {
      // Skipping leftsize + 1 nodes...
      return right?.getIthNode(index: index - (leftSize + 1))
    }
  }

  func insert(value: Int) {
    if value <= self.value {
      if left == nil {
        left = TreeNode2(value: value)
      } else {
        left?.insert(value: value)
      }
    } else {
      if right == nil {
        right = TreeNode2(value: value)
      } else {
        right?.insert(value: value)
      }
    }
    size += 1
  }

  func find(value: Int) -> TreeNode2? {
    if value == self.value {
      return self
    } else if value <= self.value {
      return left != nil ? left?.find(value: value) : nil
    } else if value > self.value {
      return right != nil ? right?.find(value: value) : nil
    }

    return nil
  }
}
