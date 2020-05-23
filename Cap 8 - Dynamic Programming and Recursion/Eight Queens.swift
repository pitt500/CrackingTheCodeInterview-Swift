class NQueens {
  let gridSize: Int

  init(n: Int) {
    self.gridSize = n
  }

  func printQueens() {
    var result = [[Int]]()
    let queens = [Int](repeating: -1, count: gridSize)

    addQueen(row: 0, queens: queens, results: &result)

    print("Total results: \(result.count)")

    for q in result {
      printBoard(queens: q)
    }
  }

  func addQueen(row: Int, queens: [Int], results: inout [[Int]]) {
    var mutableQueens = queens
    if row == gridSize {
      results.append(queens)
    } else {
      for col in 0..<gridSize where isValidPlace(row: row, col: col, queens: queens){
        mutableQueens[row] = col
        addQueen(row: row + 1, queens: mutableQueens, results: &results)
      }
    }
  }

  private func isValidPlace(row: Int, col: Int, queens: [Int]) -> Bool {
    for r in 0..<row {
      let c = queens[r]

      //Same column
      if c == col {
        return false
      }

      //Check diagonals
      let columnDelta = abs(c - col)
      let rowDelta = row - r
      if columnDelta == rowDelta {
        return false
      }
    }

    return true
  }


  func printBoard(queens: [Int]) {
    var counter = 1
    print(terminator: "\n")

    for row in 0..<gridSize {
      for col in 0..<gridSize {

        if queens[row] == col {
          print("👑", terminator: "")
        } else {
          print(counter%2 == 0 ? "🟫" : "⬜️", terminator: "")
        }

        counter += 1
      }

      if gridSize%2 == 0 {
        counter -= 1
      }
      print()
    }
    print(terminator: "\n")
  }
}

let sol = NQueens(n: 8)
sol.printQueens()
