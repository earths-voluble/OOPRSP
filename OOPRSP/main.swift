//
//  main.swift
//  OOPRSP
//
//  Created by 이보한 on 2023/11/24.
//

import Foundation

enum RockScissorsPaper: String {
    case exit = "0"
    case scissors = "1"
    case rock = "2"
    case paper = "3"
}

class Player {
    var hand: Int?
    
    func play() {
        
    }
    
    init(hand: Int?) {
        self.hand = hand
    }
    
}

func game(playerSelection: RockScissorsPaper) {
    let playerHand = Int(playerSelection.rawValue)
    var newPlayer = Player(hand: playerHand)
    var newComputer = Player(hand: Int.random(in: 1...3))
    
    if newPlayer.hand == 0 {
        print("프로그램 종료")
    } else if newPlayer.hand == newComputer.hand {
        print("비겼습니다!")
    } else if (newComputer.hand == 1 && newPlayer.hand == 2) ||
                (newComputer.hand == 2 && newPlayer.hand == 3) ||
                (newComputer.hand == 3 && newPlayer.hand == 1) {
        print("이겼습니다!")
    } else {
        print("졌습니다")
    }
    
}

while true {
    print("가위바위보")
    if let input = readLine(),
       let select = RockScissorsPaper(rawValue: input) {
        game(playerSelection: select)
    }
}
