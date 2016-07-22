
let baseDir = "/" + Array(#file.characters.split(separator: "/").dropLast(3)).map(String.init).joined(separator: "/")

let buildDir = baseDir + "/.build/debug/"
