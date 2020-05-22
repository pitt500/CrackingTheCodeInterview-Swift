class GraphNode {
  var value: Int
  var children: [GraphNode]
  var isVisited: Bool = false

  init(value: Int, children: [GraphNode]) {
    self.value = value
    self.children = children
  }
}

class RouteBetweenNodes {

  func searchDFS(_ start: GraphNode, _ end: GraphNode) -> Bool {
    if start.value == end.value { return true }

    start.isVisited = true
    for node in start.children {
      if !node.isVisited  {
        let found = searchDFS(node, end)

        if found {
          return true
        }
      }
    }

    return false
  }

  func searchBFS(_ start: GraphNode, _ end: GraphNode) -> Bool {
    if start === end { return true }
    var queue = [GraphNode]()

    queue.append(start)
    while !queue.isEmpty {
      let node = queue.removeFirst() // O(n)
      if node.isVisited {
        continue
      }

      node.isVisited = true

      if node === end {
        return true
      } else {
        queue.append(contentsOf: node.children)
      }
    }

    return false
  }

}

let solution = RouteBetweenNodes()

var nodes = [GraphNode]()
for i in 1...7 {
 nodes.append(GraphNode(value: i, children: []))
}

nodes[0].children = [nodes[1], nodes[3]]
nodes[1].children = [nodes[2], nodes[4]]
nodes[3].children = [nodes[4]]
nodes[4].children = [nodes[5]]
nodes[5].children = [nodes[1]]

let result = solution.searchBFS(nodes[0], nodes[4])

if result {
 print(" Found!")
} else {
 print("Not Found")
}
