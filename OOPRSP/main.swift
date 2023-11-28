//
//  main.swift
//  OOPRSP
//
//  Created by 이보한 on 2023/11/24.
//

import Foundation

enum RockScissorsPaper: String, CaseIterable {
    case scissors = "1"
    case rock = "2"
    case paper = "3"
}

enum MukJiPa: String, CaseIterable {
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
    var secondGameTurn: Bool?
    var firstHand: RockScissorsPaper?
    var secondHand: MukJiPa?
    
    mutating func chooseHand() {
        if let input = readLine(),
           let select = RockScissorsPaper(rawValue: input) {
            let playerHand = select
            self.firstHand = playerHand
        }
    }
    mutating func randomHand() {
        self.firstHand = RockScissorsPaper.allCases.randomElement()
    }
    
    mutating func chooseSecondHand() {
        if let input = readLine(),
           let select = MukJiPa(rawValue: input) {
            let playerHand = select
            self.secondHand = playerHand
        }
    }
    mutating func randomSecondHand() {
        self.secondHand = MukJiPa.allCases.randomElement()
    }
}

struct Ruler {
    func ruleFirstGame(playerHand: RockScissorsPaper?,
                       computerHand: RockScissorsPaper?) -> Result {
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
    
    func ruleSecondGame(turn: Result,
                        user: Player,
                        computer: Player
    ) {
        var shadowUser = user
        var shadowComputer = computer
        print(turn)
        
        if turn == Result.win {
            print("[사용자 턴] 묵(1) 찌(2), 빠(3)! <종료 : 0> :")
        } else { print("[컴퓨터 턴] 묵(1) 찌(2), 빠(3)! <종료 : 0> :") }
        
        shadowUser.chooseSecondHand()
        shadowComputer.randomSecondHand()
        
        if shadowUser.firstHand == shadowComputer.firstHand {
            print("\(shadowUser.secondHand!), \(shadowComputer.secondHand!)")
            print("승리")
        } else if (shadowUser.secondHand == .muk && shadowComputer.secondHand == .ji) ||
                    (shadowUser.secondHand == .ji && shadowComputer.secondHand == .pa) ||
                    (shadowUser.secondHand == .pa && shadowComputer.secondHand == .muk) {
            ruleSecondGame(turn: Result.win,
                           user: shadowUser,
                           computer: shadowComputer)
        } else if (shadowUser.secondHand == .ji && shadowComputer.secondHand == .muk) ||
                    (shadowUser.secondHand == .pa && shadowComputer.secondHand == .ji) ||
                    (shadowUser.secondHand == .muk && shadowComputer.secondHand == .pa) {
            ruleSecondGame(turn: Result.lose,
                           user: shadowUser,
                           computer: shadowComputer)
        }        else {
            print("\(shadowUser.secondHand!), \(shadowComputer.secondHand!)")
            print("패배")
        }
    }
}

func start() {
    print("가위(1), 바위(2), 보(3)! <종료 : 0> :")
    let ruler = Ruler()
    var user = Player()
    var computer = Player()
    
    user.chooseHand()
    computer.randomHand()
    
    let secondGameTurn = ruler.ruleFirstGame(playerHand: user.firstHand,
                                             computerHand: computer.firstHand)
    
    if secondGameTurn == Result.draw {
        print("비겼습니다!")
        start()
    } else if secondGameTurn == Result.win {
        user.secondGameTurn = true
        print("이겼습니다!")
    } else {
        user.secondGameTurn = false
        print("졌습니다!")
    }
    
    ruler.ruleSecondGame(turn: secondGameTurn,
                         user: user,
                         computer: computer)
}

start()
