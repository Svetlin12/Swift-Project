public class GameHandler {
    let players: Players
    let table: Table
    var winners: Players = Players()
    
    public init(players: [Player]) {
        self.players = Players(players)
        self.table = Table(players: self.players)
    }
    
    public func playGame() throws {
        while winners.players.count == 0 {
            for player in players {
                print("Current score:")
                table.printTable()
                
                do {
                    try player.playRound()
                } catch PlayerError.invalidInput {
                    throw PlayerError.invalidInput
                }
                
                if player.brainScore >= 13 {
                    winners.addPlayer(player)
                }
                table.updatePlayerInfo(player)
            }
        }
        
        if winners.players.count == 1 {
            print("The winner is: \(winners.players.first!.name) with score \(winners.players.first!.brainScore)")
        }
        else {
            print("The winners are: ")
            for player in winners.players {
                print("\(player.name) with score \(player.brainScore)")
            }
        }
    }
}
