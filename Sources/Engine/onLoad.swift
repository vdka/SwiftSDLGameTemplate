

/// Called every time the libGameEngine.dylib is reloaded. Use this to reload anything in the Engine that loaded after first load.
/// It can also be used as a sort of injection framework to modify the state of the running game.
@_silgen_name("onLoad")
func onLoad(_ memory: UnsafeMutablePointer<Byte>!) -> Void {

  loadConfiguration()

  // Perform anything you want to inject into the gameState
  call(with: memory, runInjections)

  //
  call(with: memory) { _, graphics, _ in
    print("graphics.config \(graphics.config)")
  }
}

func loadConfiguration() {

  print("loadingConfig")
  loadKeybindings()
}

func runInjections(_ gameState: inout GameState, _ graphics: inout Graphics, _ assetData: AssetData) {
  print("injecting")
}
