class TowersOfHanoi {

  private func setup(for n: Int) -> [[Int]] {
    var towers = [[Int]](repeating: [Int](), count: 3)
    for i in stride(from: n, to: 0, by: -1) {
      towers[0].append(i)
    }

    return towers
  }


  func hanoi(numDisks: Int) -> [[Int]] {
    var towers = setup(for: numDisks)

    moveDisks(towers: &towers, numDisks: numDisks, origin: 0, destination: 2, aux: 1)

    return towers
  }

  func moveDisks(towers: inout [[Int]], numDisks: Int, origin: Int,  destination: Int, aux: Int) -> Void {

    guard numDisks > 0 else { return }

    //Alterning between towers for even and odds numDisks
    moveDisks(towers: &towers, numDisks: numDisks - 1, origin: origin,
              destination: aux, aux: destination)

    if let poped = towers[origin].popLast() {
      towers[destination].append(poped)
      print()
      print("Origin: \(origin)")
      print("Aux: \(aux)")
      print("Dest: \(destination)")
      print(towers)
    }

    moveDisks(towers: &towers, numDisks: numDisks - 1, origin: aux,
              destination: destination, aux: origin)

  }

}


let sol = TowersOfHanoi()
let result = sol.hanoi(numDisks: 3)
print(result)
