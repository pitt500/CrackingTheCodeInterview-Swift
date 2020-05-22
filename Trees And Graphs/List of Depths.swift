import UIKit

// MARK: - Linked List
class Node<Value> {
  var value: Value
  var next: Node?

  init(value: Value, next: Node? = nil) {
    self.value = value
    self.next = next
  }
}

extension Node: CustomStringConvertible {
  var description: String {
    guard let next = next else {
      return "\(value)"
    }

    return "\(value) -> " + String(describing: next) + " "
  }
}

struct LinkedList<Value> {
  var head: Node<Value>?
  var tail: Node<Value>?

  init() {}

  var isEmpty: Bool {
    return head == nil
  }

  private mutating func copyNodes() {
    guard !isKnownUniquelyReferenced(&head) , var oldNode = head else {
      return
    }

    head = Node(value: oldNode.value)
    var newNode = head

    while let nextOldNode = oldNode.next {
      newNode!.next = Node(value: nextOldNode.value)
      newNode = newNode!.next

      oldNode = nextOldNode
    }

    tail = newNode
  }

  //MARK: - Search
  func node(at index: Int) -> Node<Value>? {
    var currentNode = head
    var currentIndex = 0

    while currentNode != nil && currentIndex < index {
      currentNode = currentNode?.next
      currentIndex += 1
    }

    return currentNode
  }

  //MARK: - Insertion
  mutating func push(_ value: Value) {
    copyNodes()
    head = Node(value: value, next: head)
    if tail == nil {
      tail = head
    }
  }

  mutating func append(_ value: Value) {
    copyNodes()
    if isEmpty {
      push(value)
      return
    }

    tail?.next = Node(value: value)
    tail = tail?.next
  }

  @discardableResult
  mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
    copyNodes()
    guard tail !== node else {
      append(value)
      return tail!
    }

    node.next = Node(value: value, next: node.next)
    return node.next!
  }

  //MARK: - Deletion
  @discardableResult
  mutating func pop() -> Value? {
    copyNodes()
    defer {
      head = head?.next
      if isEmpty {
        tail = nil
      }
    }

    return head?.value
  }

  @discardableResult
  mutating func removeLast() -> Value? {
    copyNodes()
    guard let head = head else {
      return nil
    }

    guard head.next != nil else {
      return pop()
    }

    var prev = head
    var current = head

    while let next = current.next {
      prev = current
      current = next
    }

    prev.next = nil
    tail = prev

    return current.value
  }

  @discardableResult
  mutating func remove(after node: Node<Value>) -> Value? {
    copyNodes()
    defer {
      if node.next === tail {
        tail = node
      }

      node.next = node.next?.next
    }

    return node.next?.value
  }
}

extension LinkedList: CustomStringConvertible {
  var description: String {
    guard let head = head else {
      return "Empty List"
    }

    return String(describing: head)
  }
}

extension LinkedList: Collection {
  func index(after i: Index) -> Index {
    return Index(node: i.node?.next)
  }

  subscript(position: Index) -> Value {
    return position.node!.value
  }

  var startIndex: Index {
    return Index(node: head)
  }

  var endIndex: Index {
    return Index(node: tail?.next)
  }

  struct Index: Comparable {
    var node: Node<Value>?

    static func == (lhs: Index, rhs: Index) -> Bool {
      switch (lhs.node, rhs.node) {
      case let (left?, right?):
        return left.next === right.next
      case (nil, nil):
        return true
      default:
        return false
      }
    }

    static func < (lhs: Index, rhs: Index) -> Bool {
      guard lhs != rhs else { return false }

      let nodes = sequence(first: lhs.node) { $0?.next }
      return nodes.contains { $0 === rhs.node }
    }


  }
}

class LinkedListNode {
  var val: Int
  var next: LinkedListNode?

  init(val: Int, next: LinkedListNode? = nil) {
    self.val = val
    self.next = next
  }
}

// MARK: - TreeNode
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


//MARK: - Problem

func getLinkedList(from root: TreeNode?) -> [LinkedListNode] {
  guard let node = root else { return [] }
  var linkedLists: [LinkedListNode] = []
  var stack: [TreeNode] = []
  var auxStack: [TreeNode] = [node]
  var depth = 1

  while !auxStack.isEmpty {

    //O(n)
    stack = auxStack.reversed()
    auxStack.removeAll()

    //O(n)
    while !stack.isEmpty {
      let treeNode = stack.removeLast() // O(1)

      let listNode = LinkedListNode(val: treeNode.value)

      if linkedLists.count == depth ,let last = linkedLists.last {
        last.next = listNode
      } else {
        linkedLists.append(listNode)
      }

      if let left = treeNode.left {
        auxStack.append(left)
      }

      if let right = treeNode.right {
        auxStack.append(right)
      }
    }
    depth += 1
  }

  return linkedLists
}

//From CTCI
class BestListOfDepths {
  func getLinkedList(from root: TreeNode?) -> [LinkedList<TreeNode>] {
    var result = [LinkedList<TreeNode>]()
    var current = LinkedList<TreeNode>()
    if root != nil {
      current.append(root!)
    }

    while current.count > 0 {
      result.append(current)
      let parents = current
      current = LinkedList<TreeNode>()

      for parent in parents {
        if let left = parent.left {
          current.append(left)
        }

        if let right = parent.right {
          current.append(right)
        }
      }

    }

    return result
  }
}
