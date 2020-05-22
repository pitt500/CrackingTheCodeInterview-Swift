//Build order DFS
class Project: CustomStringConvertible {
  let name: String
  private(set) var children: [Project] = []
  private var map: [String: Project] = [:]
  private(set) var state = State.blank

  enum State {
    case completed
    case partial
    case blank
  }

  init(name: String) {
    self.name = name
  }

  func addNeighbor(node: Project) {
    if map[node.name] == nil {
      children.append(node)
      map[node.name] = node
    }
  }

  func setState(_ state: State) {
    self.state = state
  }

  var description: String {
    name
  }
}

class Graph {
  private(set) var nodes: [Project] = []
  private var map: [String: Project] = [:]

  @discardableResult
  func getOrCreateNode(name: String) -> Project {
    if map[name] == nil {
      let node = Project(name: name)
      nodes.append(node)
      map[name] = node
    }

    return map[name]!
  }

  func addEdge(startName: String, endName: String) {
    let start = getOrCreateNode(name: startName)
    let end = getOrCreateNode(name: endName)
    start.addNeighbor(node: end)
  }
}

class SolutionBuildOrder {
  func getBuildOrder(projects: [String],
                     dependencies: [[String]]) -> [Project]? {
    let graph = buildGraph(projects: projects, dependencies: dependencies)
    return orderProjects(projects: graph.nodes)
  }

  func buildGraph(projects: [String], dependencies: [[String]]) -> Graph {
    let graph = Graph()
    for project in projects {
      graph.getOrCreateNode(name: project)
    }

    //dependency example: [“A”, “B”]
    for dependency in dependencies {
      if let first = dependency.first, let second = dependency.last {
        graph.addEdge(startName: first, endName: second)
      }
    }

    return graph
  }

  func orderProjects(projects: [Project]) -> [Project]? {
    var order: [Project] = []

    for project in projects {
      if project.state == .blank {
        if !dfs(project: project, order: &order) {
          return nil
        }
      }
    }

    return order
  }

  func dfs(project: Project, order: inout [Project]) -> Bool {
    if project.state == .partial {
      return false // cycle
    }

    if project.state == .blank {
      for child in project.children {
        if !dfs(project: child, order: &order) {
          return false
        }
      }
      project.setState(.completed)
      order.append(project)
    }

    return true
  }
}


let sol = SolutionBuilsOrder()
let projects = ["A", "B", "C", "D", "E", "F", "G"]
let dependencies = [
 ["F", "A"],
 ["F", "B"],
 ["F", "C"],
 ["D", "G"],
 ["C", "A"],
 ["B", "A"],
 ["A", "E"]
]
if let res = sol.getBuildOrder(projects: projects,
                              dependencies: dependencies) {
 print(Array(res.reversed()))
} else {
 print("Cycle found")
}
