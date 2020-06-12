public class Players {
    var players: [Player]
    
    init (players: Player...) {
        //error
//        if players.count < 2 || players.count > 8 {
//            return
//        }
        self.players = players
    }
}
