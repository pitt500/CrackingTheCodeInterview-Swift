
public class Node {
   public var val: Int
   public var left: Node?
   public var right: Node?
   public var parent: Node?
   public init(_ val: Int) {
       self.val = val
       self.left = nil
       self.right = nil
       self.parent = nil
   }
}

class Successor {
    func inorderSuccessor(_ node: Node?) -> Node? {
        if (node == nil) {
            return nil
        }

        if (node?.right != nil) {
            return getLeftMost(node: node?.right);
        } else {
            return getFirstRightMost(node: node);
        }
    }

    func getLeftMost(node: Node?) -> Node? {
        if node?.left == nil {
            return node
        }

        return getLeftMost(node: node?.left)
    }

    func getFirstRightMost(node: Node?) -> Node?{
        if node?.parent == nil {
            return nil
        }

        if node === node?.parent?.right {
            return getFirstRightMost(node: node?.parent)
        }

        return node?.parent
    }
}
