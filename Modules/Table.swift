public class Table {
    var playersInfo: Players
    var playerMaxStringCnt: Int = 0
    
    public init (players: Players) {
        playersInfo = players
        for player in players.players {
            playerMaxStringCnt = max(playerMaxStringCnt, player.name.count)
        }
        playerMaxStringCnt = max(playerMaxStringCnt, "Player".count)
    }
    
    public func updatePlayerInfo(_ player: Player) {
        playersInfo.players = playersInfo.players.filter( {
            if $0 == player {
                $0.brainScore = player.brainScore
            }
            return true
        })
    }
    
    public func printTable() {
        print(String.init(repeating: "-", count: playerMaxStringCnt * 2 + 6))
        print("|", terminator: " ")
        print("\(formatString("Player"))\(formatString("Score"))")
        print(String.init(repeating: "-", count: playerMaxStringCnt * 2 + 6))
        for player in playersInfo.players {
            print("|", terminator: " ")
            print("\(formatString(player.name))\(formatString(String(player.brainScore)))")
        }
        print(String.init(repeating: "-", count: playerMaxStringCnt * 2 + 6))
    }
    
    private func formatString(_ str: String) -> String {
        // this is always >= 0
        let diffInLen = playerMaxStringCnt - str.count
        var leftIntervals = diffInLen / 2
        let rightIntervals = diffInLen / 2 + 1
        if diffInLen % 2 != 0 {
            leftIntervals += 1
        }
        var newStr = ""
        for _ in 0..<leftIntervals {
            newStr.append(" ")
        }
        newStr.append(contentsOf: str)
        for _ in 0..<rightIntervals {
            newStr.append(contentsOf: " ")
        }
        newStr.append("|")
        return newStr
    }
}
