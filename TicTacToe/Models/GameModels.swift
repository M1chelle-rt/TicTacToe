//
//  GameModels.swift
//  TicTacToe
//
//  Created by Michelle Thomas on 2/10/25.
//

import SwiftUI

enum GameType {
    case single, bot, peer, undetermined
    
    var description : String {
        switch self {
        case .single:
            return "Share your device with a friend to play"
        case .bot:
            return "Play with a bot."
        case .peer:
            return "Invite someone on the network to play with"
        case .undetermined:
            return ""
        }
    }
}

enum GamePiece: String{
    case X, O
    
    var image:Image {
        Image(self.rawValue)
    }
    
}


struct Player{
    let gamePiece:GamePiece
    var name: String
    var moves:[Int] = []
    var isCurrent = false
    
    var isWinner: Bool{
        for moves in Moves.winningMoves{
            if moves.allSatisfy(self.moves.contains){
                return true
            }
        }
        return false
    }
}

enum Moves{
    static var all = [1, 2, 3, 4, 5, 6, 7, 8, 9]

   static var winningMoves = [
        [1,2,3],
        [4,5,6],
        [7,8,9],
        [1,4,7],
        [2,5,8],
        [3,6,9],
        [1,5,9],
        [3,5,7]
    ]
}
