func printScreen(width: Int, screen: [UInt8]) {
  var num = 1
  let widthNum = width/8
  for byte in screen {
    for i in stride(from: 7, to: -1, by: -1) {
      print((byte >> i) & 1, terminator: "")
    }

    if num % widthNum == 0 {
      print()
    } else {
      print("|", terminator: "")
    }
    num += 1
  }
}

class DrawLineSolution {

  func drawLine(screen: [UInt8], width: Int, x1: Int, x2: Int, y: Int) {
    var newScreen = screen
    let widthNum = width/8
    let height = screen.count/widthNum

    if y > height || x1 > width || x2 > width || x1 <= 0 || x2 <= 0 {
      return
    }

    let lastColumnYPosition = y*widthNum
    let firstColumnYPosition = lastColumnYPosition - widthNum
    var counter = 0

    print("One by one:")
    for index in firstColumnYPosition..<lastColumnYPosition {
      for i in 0..<8 {

        if counter >= x1 && counter <= x2 {
          newScreen[index] |= (1 << (7 - i))
        } else if counter > x2 {
          break
        }
        counter += 1
      }
    }

    printScreen(width: width, screen: newScreen)

  }
}

// Better

class BetterDrawLineSolution {
  func drawLine(screen: [UInt8], width: Int, x1: Int, x2: Int, y: Int) {
    var newScreen = screen
    let widthNum = width/8
    let height = screen.count/widthNum

    if y > height || x1 > width || x2 > width || x1 <= 0 || x2 <= 0 || x1 > x2 {
      print("ERROR")
      return
    }

    let lastColumnYPosition = y*widthNum
    let firstColumnYPosition = lastColumnYPosition - widthNum
    var minRange = 0
    var maxRange = 7

    print("Optimized:")
    //Not bad, but it always start from the first column even with 0s
    for index in firstColumnYPosition..<lastColumnYPosition {

      if x1 >= minRange && x2 <= maxRange { //Both x's are in the same byte
        newScreen[index] = ~(~0 << (maxRange - x1 + 1)) & (~0 << (maxRange - x2))
        break // No more to print
      } else if x1 >= minRange && x1 <= maxRange {
        newScreen[index] = ~(~0 << (maxRange - x1 + 1))
      } else if x2 >= minRange && x2 <= maxRange {
        newScreen[index] = (~0 << (maxRange - x2))
        break // No more to print
      } else if x1 <= minRange {
        newScreen[index] |= ~0
      }

      minRange += 8
      maxRange += 8
    }

    printScreen(width: width, screen: newScreen)

  }
}


//Best
// For UInt8 use 0b1111111 instead of ~0
class BestDrawLineSolution {
  func drawLine(screen: [UInt8], width: Int, x1: Int, x2: Int, y: Int) {
    var newScreen = screen
    let widthNum = width/8
    let height = screen.count/widthNum
    let row = widthNum*y

    if y > height || x1 > width || x2 > width || x1 <= 0 || x2 <= 0 || x1 > x2 {
      print("ERROR")
      return
    }

    let startOffset = x1%8
    var firstFullByte = x1/8

    if startOffset != 0 {
      firstFullByte += 1
    }

    let endOffset = x2%8
    var lastFullByte = x2/8

    if endOffset != 7 {
      lastFullByte -= 1
    }

    //Set full bytes first
    for bytePosition in firstFullByte...lastFullByte {
      newScreen[row + bytePosition] = 0b11111111
    }

    //Create masks for start and end of line
    let startMask = UInt8(0b11111111 >> startOffset)
    let endMask = ~UInt8(0b11111111 >> (endOffset + 1))

    print("Best:")
    //Case when x1 and x2 are in the same line
    if (x1/8) == (x2/8) {
      newScreen[row + (x1/8)] = UInt8(startMask & endMask)

    } else {

      if startOffset != 0 {
        let index = row + firstFullByte - 1
        newScreen[index] = UInt8(startMask)
      }

      if endOffset != 7 {
        let index = row + lastFullByte + 1
        newScreen[index] = UInt8(endMask)
      }
    }

    printScreen(width: width, screen: newScreen)

  }
}

//Test
let x1 = 11
let x2 = 25
let y = 3
let width = 32

let sol = DrawLineSolution()
sol.drawLine(screen: [UInt8](repeating: 0, count: 16), width: 32, x1: x1, x2: x2, y: y)

let sol2 = BetterDrawLineSolution()
sol2.drawLine(screen: [UInt8](repeating: 0, count: 16), width: 32, x1: x1, x2: x2, y: y)


let sol3 = BestDrawLineSolution()
sol3.drawLine(screen: [UInt8](repeating: 0, count: 16), width: 32, x1: x1, x2: x2, y: y)
