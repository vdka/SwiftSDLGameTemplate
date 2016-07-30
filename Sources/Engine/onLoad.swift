

/// Called every time the libGameEngine.dylib is reloaded. Use this to reload anything in the Engine that loaded after first load.
/// It can also be used as a sort of injection framework to modify the state of the running game.
@_silgen_name("onLoad")
public func onLoad(_ memory: UnsafeMutablePointer<Byte>!) -> Void {

  loadConfiguration()

  // Perform anything you want to inject into the gameState
  call(with: memory, runInjections)

  call(with: memory) { gameState, graphics in
    print(graphics.config)
  }
}

func loadConfiguration() {

  print("loadingConfig")
  loadKeybindings()
}

func runInjections(_ gameState: inout GameState, using graphics: inout Graphics) {
  print("injecting")
}
