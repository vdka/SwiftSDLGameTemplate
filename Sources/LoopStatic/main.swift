
import Engine

var shouldQuit = false

typealias Byte = UInt8

var memory = Engine.initialize()

guard memory != nil else { fatalError("Call to initialize function failed") }

while (!shouldQuit) {

  shouldQuit = Engine.update(with: memory)
}

print("Did quit cleanly!")
