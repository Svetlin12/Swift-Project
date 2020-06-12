public class Player: Comparable {
    var brainScore: Int
    var lastBrainScore: Int
    var shotgunScore: Int
    let name: String
    private static var uniqueId: Int = 1
    var id: Int
    var cup: Cup
    
    public init(name: String) {
        self.name = name
        self.brainScore = 0
        self.shotgunScore = 0
        self.id = Player.uniqueId
        Player.uniqueId += 1
        self.cup = Cup()
        self.lastBrainScore = 0
    }
    
    public static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.id < rhs.id
    }
    
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    func playOneTurn() {
        guard let currentDice = cup.pickDice() else {
            return
        }
        
        print("Picked dice: ", terminator: " ")
        var hand = [String]()
        for dice in currentDice {
            if dice is GreenDice {
                print("🟩", terminator: " ")
            }
            if dice is RedDice {
                print("🟥", terminator: " ")
            }
            if dice is YellowDice {
                print("🟨", terminator: " ")
            }
            hand.append(dice.roll())
        }
        
        var brainCnt = 0
        var shotgunCnt = 0
        var cnt = 0
        print()
        print("Result: ", terminator: " ")
        for roll in hand {
            if roll == "👣" {
                cup.addRunner(runner: currentDice[cnt])
            }
            else if roll == "🧠" {
                brainCnt += 1
            }
            else if roll == "💥" {
                shotgunCnt += 1
            }
            print("\(roll)", terminator: " ")
            cnt += 1
        }
        print()
        
        brainScore += brainCnt
        shotgunScore += shotgunCnt
    }
    
    public func playRound() {
        var input = ""
        lastBrainScore = brainScore
        while (input != "No" && input != "n" && input != "no" && input != "N" && cup.currentDice.count != 0)
        {
            playOneTurn()
            if shotgunScore >= 3 {
                print("Player \(name) has lost his round because he has \(shotgunScore) shotguns!")
                cup.reset()
                shotgunScore = 0
                brainScore = lastBrainScore
                return
            }
            print("Player \(name)'s current score: brains: \(brainScore), shotguns: \(shotgunScore), dice left: \(cup.currentDice.count).\nDo you wish to proceed? [Yes/No]")
            guard let answer = readLine() else {
                return
            }
            input = answer
            print("input: [\(input)]")
        }
        shotgunScore = 0
        cup.reset()
        print("Player \(name)'s brain score after this round: \(brainScore).")
    }
}
