import PlayersModules

public enum GameError: Error {
    case lessThanTwoPlayers
    case moreThanEightPlayers
    case invalidChoiceNumber
    case invalidInput
}

public class Game {
    public init() {
    }
    
    // play the whole game - from the start menu until the end
    public func play() {
        do {
            try startMenu()
        } catch GameError.invalidChoiceNumber {
            print("The entered option is incorrect: try typing '1' or '2'!")
        } catch GameError.lessThanTwoPlayers {
            print("The game must be played by more than 1 player!")
        } catch GameError.moreThanEightPlayers {
            print("The game must be played by less than 9 players!")
        } catch GameError.invalidInput {
            print("Invalid input was given!")
        } catch PlayerError.invalidInput {
            print("Invalid input was given while playing the game!")
        } catch {
        }
    }
    
    // display start menu and handle user input and then call playGame in order to start the game
    private func startMenu() throws {
        print("This is an implementation of the game Zombie Dice created by Svetlin Popivanov")
        print("1. Start Game")
        print("2. I want to know how to play the game")
        print("Select option: ", terminator: "")
        
        guard let choice = readLine() else {
            throw GameError.invalidInput
        }
        
        if choice != "1" && choice != "2" {
            throw GameError.invalidChoiceNumber
        }
        
        if choice == "2" {
            print("You can check out the rules on the following address: https://en.wikipedia.org/wiki/Zombie_Dice")
            print("press any key when you are ready: ", terminator: "")
            
            guard let _ = readLine() else {
                throw GameError.invalidInput
            }
        }
        
        do {
            try playGame()
        } catch GameError.lessThanTwoPlayers {
            throw GameError.lessThanTwoPlayers
        } catch GameError.moreThanEightPlayers {
            throw GameError.moreThanEightPlayers
        } catch GameError.invalidInput {
            throw GameError.invalidInput
        } catch PlayerError.invalidInput {
            throw PlayerError.invalidInput
        }
    }
    
    private func playGame() throws {
        print("Enter the names of the players each space-separated:")
        
        guard var players = readLine()?.components(separatedBy: " ") else {
            throw GameError.invalidInput
        }
        
        if players.count < 2 {
            throw GameError.lessThanTwoPlayers
        }
        else if players.count > 8 {
            throw GameError.moreThanEightPlayers
        }
        
        players = players.filter({ if $0.isEmpty { return false }; return true })
        
        var convertedPlayers = [Player]()
        for player in players {
            convertedPlayers.append(.init(name: player))
        }
        let game = GameHandler(players: convertedPlayers)
        print("==================================================================")
        
        do {
            try game.playGame()
        } catch PlayerError.invalidInput {
            throw PlayerError.invalidInput
        }
        
        print("Thanks for playing the game!")
    }
}
