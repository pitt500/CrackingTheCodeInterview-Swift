// Minimal Tree
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

func minimalTree(_ input: [Int]) -> TreeNode? {
  if input.isEmpty { return nil }

  let middleIndex = input.count / 2

  let root = TreeNode(value: input[middleIndex])

  root.left = minimalTree(Array(input[0..<middleIndex]))
  root.right = minimalTree(Array(input[(middleIndex + 1)..<input.count]))

  return root
}

let tree = minimalTree([4, 5, 8, 10, 12, 13, 15, 20])
