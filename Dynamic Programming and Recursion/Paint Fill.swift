class PaintFill: CustomStringConvertible {
  var image: [[Int]]

  init(image: [[Int]]) {
    self.image = image
  }

  func paintArea(row: Int, col: Int, newColor: Int) {
    guard areValidBounds(row, col) && newColor != image[row][col] else { return }
    let oldValue = image[row][col]

    paintHelper(row, col, newColor, oldValue)
  }

  private func paintHelper(_ row: Int,_ col: Int,_ newColor: Int,_ current: Int) {
    guard areValidBounds(row, col) && image[row][col] == current else { return }

    image[row][col] = newColor

    paintHelper(row, col - 1, newColor, current)
    paintHelper(row, col + 1, newColor, current)
    paintHelper(row - 1, col, newColor, current)
    paintHelper(row + 1, col, newColor, current)
    paintHelper(row - 1, col - 1, newColor, current)
    paintHelper(row - 1, col + 1, newColor, current)
    paintHelper(row + 1, col - 1, newColor, current)
    paintHelper(row + 1, col + 1, newColor, current)
  }

  private func areValidBounds(_ row: Int,_ col: Int) -> Bool {
    row >= 0 && row < image.count && col >= 0 && col < image[0].count
  }

  var description: String {
    var string = ""
    for rowImage in image {
      string += "\(rowImage)\n"
    }

    return string
  }
}


let image = [
  [1, 1, 1, 1, 2, 2],
  [1, 2, 1, 3, 2, 2],
  [1, 2, 3, 3, 3, 1],
  [2, 2, 3, 3, 1, 1],
  [1, 1, 1, 3, 1, 1]
]

let sol = PaintFill(image: image)
sol.paintArea(row: 2, col: 3, newColor: 0)
print(sol)
