import PackageDescription

let package = Package(
  name: "SwiftSDLGameTemplate",
  targets: [
    Target(name: "SDL"),
    Target(name: "Shared"),
    Target(name: "Engine",   dependencies: [.Target(name: "Shared"), .Target(name: "SDL"), .Target(name: "Renderer")]),
    Target(name: "Renderer", dependencies: [.Target(name: "Shared"), .Target(name: "SDL")]),
    Target(name: "LoopStatic", dependencies: [.Target(name: "Engine")]),
    Target(name: "LoopDynamic")
  ],
  dependencies: [
    .Package(url: "https://github.com/PureSwift/CSDL2.git", majorVersion: 1)
  ]
)

let libShared = Product(name: "Shared", type: .Library(.Dynamic), modules: "Shared")
let libGameEngine = Product(name: "GameEngine", type: .Library(.Dynamic), modules: "Engine")
let libGameRenderer = Product(name: "GameRenderer", type: .Library(.Dynamic), modules: "Renderer")

products.append(contentsOf: [libShared, libGameEngine, libGameRenderer])

