public class Game {
    public func play() {
        guard let players = readLine()?.components(separatedBy: " ") else {
            return
        }
        var convertedPlayers = [Player]()
        for player in players {
            convertedPlayers.append(.init(name: player))
        }
        let game = GameHandler(players: convertedPlayers)
        game.playGame()
    }
}
