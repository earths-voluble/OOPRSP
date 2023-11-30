//
//  main.swift
//  OOPRSP
//
//  Created by 이보한 on 2023/11/24.
//

start()

enum RockScissorsPaperSelection: String, CaseIterable {
    case exit = "0"
    case scissors = "1"
    case rock = "2"
    case paper = "3"
}

enum MukJiPaSeleciton: String, CaseIterable {
    case exit = "0"
    case muk = "1"
    case ji = "2"
    case pa = "3"
}

enum Result: String {
    case win
    case draw
    case lose
}

struct Player {
    var rockScissorsPaperHand: RockScissorsPaperSelection?
    var mukJiPaHand: MukJiPaSeleciton?
    
    mutating func choiceRockScissorsPaperHand() {
        if let input = readLine(),
           let select = RockScissorsPaperSelection(rawValue: input) {
            let playerHand = select
            self.rockScissorsPaperHand = playerHand
        }
    }
    mutating func randomRockScissorsPaperHand() {
        let exceptExitCase = RockScissorsPaperSelection.allCases.filter{ $0.rawValue != "0" }
        self.rockScissorsPaperHand = exceptExitCase.randomElement()
    }
    
    mutating func choiceMukJiPaHand() {
        if let input = readLine(),
           let select = MukJiPaSeleciton(rawValue: input) {
            let playerHand = select
            self.mukJiPaHand = playerHand
        }
    }
    mutating func randomMukJiPaHand() {
        self.mukJiPaHand = MukJiPaSeleciton.allCases.randomElement()
    }
}

struct Refree {
    func runFirstGame(playerHand: RockScissorsPaperSelection?,
                      computerHand: RockScissorsPaperSelection?) -> Result {
        print("\(playerHand!),\(computerHand!)")
        if playerHand == computerHand {
            return Result.draw
        } else if (playerHand == .rock && computerHand == .scissors) ||
                    (playerHand == .scissors && computerHand == .paper) ||
                    (playerHand == .paper && computerHand == .rock) {
            return Result.win
        } else {
            return Result.lose
        }
    }
    
    func noticeRockScissorsPaperResult(_ mukJiPaTurn: Result) {
        switch mukJiPaTurn {
        case .win:
            print("이겼습니다!")
        case .lose:
            print("졌습니다!")
        case .draw:
            print("error: 00")
        }
    }
    
    func runSecondGameSecond(rockScissorsPaperResult: Result, playerHand: MukJiPaSeleciton?, computerHand: MukJiPaSeleciton?) {
        if rockScissorsPaperResult == Result.win {
            print("[사용자 턴] 묵(1) 찌(2), 빠(3)! <종료 : 0> :")
        } else if rockScissorsPaperResult == Result.lose { print("[컴퓨터 턴] 묵(1) 찌(2), 빠(3)! <종료 : 0> :") }
        else {
            print("error: 01")
            exit(0)
        }
        if playerHand == computerHand {
//            print("\(playerHand!),\(computerHand!)")
            if rockScissorsPaperResult == Result.win {
                print("사용자 승리")
                return
            } else {
                print("컴퓨터 승리")
                return
            }
        } else if (playerHand == .muk && computerHand == .ji) ||
                    (playerHand == .ji && computerHand == .pa) ||
                    (playerHand == .pa && computerHand == .muk) {
            print("\(playerHand!), \(computerHand!)")
            
            runSecondGameSecond(rockScissorsPaperResult: Result.win, playerHand: nil, computerHand: nil)
            
        }
    }
    
    func runSecondGame(rockScissorsPaperResult: Result,
                       user: Player,
                       computer: Player
    ) {
        var shadowUser = user
        var shadowComputer = computer
        print(rockScissorsPaperResult)
        
        
        if rockScissorsPaperResult == Result.win {
            print("[사용자 턴] 묵(1) 찌(2), 빠(3)! <종료 : 0> :")
        } else if rockScissorsPaperResult == Result.lose { print("[컴퓨터 턴] 묵(1) 찌(2), 빠(3)! <종료 : 0> :") }
        else {
            print("error: 01")
            exit(0)
        }
        
        shadowUser.choiceMukJiPaHand()
        shadowComputer.randomMukJiPaHand()
        
        if shadowUser.mukJiPaHand == shadowComputer.mukJiPaHand {
            print("\(shadowUser.mukJiPaHand!), \(shadowComputer.mukJiPaHand!)")
            if rockScissorsPaperResult == Result.win {
                print("사용자 승리")
                return
            } else {
                print("컴퓨터 승리")
                return
            }
        } else if (shadowUser.mukJiPaHand == .muk && shadowComputer.mukJiPaHand == .ji) ||
                    (shadowUser.mukJiPaHand == .ji && shadowComputer.mukJiPaHand == .pa) ||
                    (shadowUser.mukJiPaHand == .pa && shadowComputer.mukJiPaHand == .muk) {
            print("\(shadowUser.mukJiPaHand!), \(shadowComputer.mukJiPaHand!)")
            runSecondGame(rockScissorsPaperResult: Result.win,
                          user: shadowUser,
                          computer: shadowComputer)
        } else if (shadowUser.mukJiPaHand == .ji && shadowComputer.mukJiPaHand == .muk) ||
                    (shadowUser.mukJiPaHand == .pa && shadowComputer.mukJiPaHand == .ji) ||
                    (shadowUser.mukJiPaHand == .muk && shadowComputer.mukJiPaHand == .pa) {
            print("\(shadowUser.mukJiPaHand!), \(shadowComputer.mukJiPaHand!)")
            runSecondGame(rockScissorsPaperResult: Result.lose,
                          user: shadowUser,
                          computer: shadowComputer)
        } else {
            shadowUser.mukJiPaHand = nil
            print("잘못된 입력, 턴이 넘어갑니다.")
            runSecondGame(rockScissorsPaperResult: Result.lose, user: shadowUser, computer: shadowComputer)
        }
    }
}


func start() {
    print("가위(1), 바위(2), 보(3)! <종료 : 0> :")
    let refree = Refree()
    var user = Player()
    var computer = Player()
    
    user.choiceRockScissorsPaperHand()
    computer.randomRockScissorsPaperHand()
    
    let rockScissorsPaperResult = refree.runFirstGame(playerHand: user.rockScissorsPaperHand,
                                                      computerHand: computer.rockScissorsPaperHand)
    
    
    if rockScissorsPaperResult == .draw {
        print("비겼습니다!")
        start()
        return
    } else {
        user.choiceMukJiPaHand()
        computer.randomMukJiPaHand()
        refree.runSecondGameSecond(rockScissorsPaperResult: rockScissorsPaperResult,
                                   playerHand: user.mukJiPaHand,
                                   computerHand: computer.mukJiPaHand)
        second(firstResult: rockScissorsPaperResult)
    }
    
    func second(firstResult : Result) {
        refree.noticeRockScissorsPaperResult(firstResult)
        refree.runSecondGame(rockScissorsPaperResult: firstResult,
                             user: user,
                             computer: computer)
    }
}
