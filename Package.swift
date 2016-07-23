import PackageDescription

let package = Package(
  name: "SwiftSDLGameTemplate",
  targets: [
    Target(name: "SDL"),
    Target(name: "Shared"),
    Target(name: "Engine",   dependencies: [.Target(name: "Shared"), .Target(name: "SDL"),]),
    Target(name: "LoopStatic", dependencies: [.Target(name: "Engine")]),
    Target(name: "LoopDynamic") // This game loop depends on Engine indirectly through runtime linking
  ],
  dependencies: [
    .Package(url: "https://github.com/PureSwift/CSDL2.git", majorVersion: 1)
  ]
)

let libShared = Product(name: "Shared", type: .Library(.Dynamic), modules: "Shared")
let libGameEngine = Product(name: "GameEngine", type: .Library(.Dynamic), modules: "Engine")

products.append(contentsOf: [libShared, libGameEngine])

