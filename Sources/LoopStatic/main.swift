
import Engine

var shouldContinue = true

typealias Byte = UInt8

var memory = Engine.initialize()

guard memory != nil else { fatalError("Call to initialize function failed") }

while (shouldContinue) {

  shouldContinue = Engine.update(with: memory)
}

print("Did quit cleanly!")

