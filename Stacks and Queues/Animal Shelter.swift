//Animal Shelter
enum Animal {
  case cat
  case dog
}

class Node: CustomStringConvertible {
  var value: Animal
  var next: Node?

  init(_ value: Animal, next: Node? = nil) {
    self.value = value
    self.next = next
  }

  var description: String {
    return "\(value)"
  }
}

class AnimalShelter: CustomStringConvertible {
  var head: Node?
  var tail: Node?

  init() {

  }

  func enqueue(_ animal: Animal) {
    let node = Node(animal)

    if head == nil {
      head = node
    } else {
      tail?.next = node
    }

    tail = node
  }

  func dequeueAny() -> Animal? {
    defer {
      head = head?.next
    }

    return head?.value
  }

  func dequeue(type: Animal) -> Animal? {
    if head?.value == type {
      return dequeueAny()
    }

    var node = head
    while let next = node?.next, next.value != type {
      node = next
    }

    if node === tail {
      return nil
    } else if node?.next === tail {
      let value = tail?.value

      node?.next = nil
      tail = node

      return value
    } else {
      let value = node?.next?.value
      node?.next = node?.next?.next

      return value
    }
  }

  var description: String {
    var node = head
    var string = ""
    while node != nil {
      string += "\(node!.value) -> "
      node = node?.next
    }

    return string
  }
}

//Output
let shelter = AnimalShelter()

shelter.enqueue(.dog)
shelter.enqueue(.dog)
shelter.enqueue(.dog)
shelter.enqueue(.dog)
shelter.enqueue(.dog)

print(shelter)

if let value = shelter.dequeue(type: .cat) {
 print(value)
 print(shelter)
}
