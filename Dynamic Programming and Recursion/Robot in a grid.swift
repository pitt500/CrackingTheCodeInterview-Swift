class BasicRobotInAGrid {
  func findPath(maze: [[Int]]) -> [(r: Int, c: Int)] {
    var path: [(r: Int, c: Int)] = []
    if findRobotPath(maze, maze.count - 1, maze[0].count - 1, &path) {
      return path
    }

    return []
  }

  private func findRobotPath(_ maze: [[Int]],_ row: Int,_ col: Int,
                             _ path: inout [(r: Int, c: Int)])
    -> Bool {

      if (row < 0 || col < 0 || maze[row][col] == 1) {
        return false
      }

      let isOrigin = (row == 0) && (col == 0)

      if isOrigin || findRobotPath(maze, row - 1, col, &path) ||  findRobotPath(maze, row, col - 1, &path) {
        path.append((row, col))
        return true
      }

      return false
  }
}

class TopDownRobotInAGrid {
  func findPath(maze: [[Int]]) -> [(r: Int, c: Int)] {
    var path: [(r: Int, c: Int)] = []
    var visited: [String: Bool] = [:]
    if findRobotPath(maze, maze.count - 1, maze[0].count - 1, &path, &visited) {
      return path
    }

    return []
  }

  private func findRobotPath(_ maze: [[Int]],_ row: Int,_ col: Int,
                             _ path: inout [(r: Int, c: Int)],
                             _ failedPoint: inout [String: Bool])
    -> Bool {

      if (row < 0 || col < 0 || maze[row][col] == 1) {
        return false
      }

      if failedPoint["\(row)_\(col)"] != nil {
        return false
      }

      let isOrigin = (row == 0) && (col == 0)

      if isOrigin || findRobotPath(maze, row - 1, col, &path, &failedPoint) ||
                     findRobotPath(maze, row, col - 1, &path, &failedPoint) {
        path.append((row, col))
        return true
      }

      failedPoint["\(row)_\(col)"] = false
      return false
  }
}


func printPath(maze: [[Int]], path: [(r: Int, c: Int)]) {
  for i in 0..<maze.count {
    for j in 0..<maze[0].count {
      if path.contains(where: { $0.c == j && $0.r == i }) {
        print("x", terminator: " ")
      } else {
        print(maze[i][j], terminator: " ")
      }
    }
    print()
  }
}



let maze = [
  [0,0,0,1,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [1,1,1,1,0,0,0,0],
  [0,0,0,0,0,0,1,1],
  [0,0,1,1,0,0,0,0],
  [0,0,0,0,1,0,0,0],
  [0,0,0,0,1,0,0,0],
]

let sol = BasicRobotInAGrid()
let startingPoint = CFAbsoluteTimeGetCurrent()
let res = sol.findPath(maze: maze)
let totalTime = CFAbsoluteTimeGetCurrent() - startingPoint
printPath(maze: maze, path: res)
print("Total time: \(totalTime) seconds")
print()

let sol2 = TopDownRobotInAGrid()
let startingPoint2 = CFAbsoluteTimeGetCurrent()
let res2 = sol2.findPath(maze: maze)
let totalTime2 = CFAbsoluteTimeGetCurrent() - startingPoint2
printPath(maze: maze, path: res2)
print("Total time: \(totalTime2) seconds")
