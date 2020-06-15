public class Players: Sequence {
    public var players: [Player]
    
    public init () {
        players = [Player]()
    }
    
    public init (_ players: [Player]) {
        self.players = players
    }
    
    public func makeIterator() -> IndexingIterator<[Player]> {
        return players.makeIterator()
    }
    
    public func addPlayer(_ player: Player) {
        players.append(player)
    }
}
