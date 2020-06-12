public class Players: Sequence {
    var players: [Player]
    
    public init () {
        players = [Player]()
    }
    
    public init (_ players: [Player]) {
        //error
//        if players.count < 2 || players.count > 8 {
//            return
//        }
        self.players = players
    }
    
    public func makeIterator() -> IndexingIterator<[Player]> {
        return players.makeIterator()
    }
    
    public func addPlayer(_ player: Player) {
        players.append(player)
    }
}
