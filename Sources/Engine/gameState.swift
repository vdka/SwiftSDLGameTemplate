
struct GameState {

  var score: Int

  var shouldQuit: Bool = false

  var player: Player

  var timer: Timer = Timer()

  init(score: Int) {

    self.score = score
    self.shouldQuit = false
    self.player = Player(position: .zero)
  }
}
