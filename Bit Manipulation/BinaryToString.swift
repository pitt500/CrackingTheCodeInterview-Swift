class BinaryToStringSolution {
  func fractionToBinary(num: Double) -> String {
    if num >= 1 || num < 0 { return "ERROR" }

    var string = "."
    var val = num

    while val > 0 {
      if string.count >= 32 {
        return string
      }
      val *= 2
      print(val)
      if val >= 1 {
        string.append("1")
        val -= 1
      } else {
        string.append("0")
      }
    }

    return string
  }
}
