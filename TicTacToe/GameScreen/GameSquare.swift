//
//  GameSquare.swift
//  TicTacToe
//
//  Created by Michelle Thomas on 2/24/25.
//

import SwiftUI

struct GameSquare{
    var id:Int //values from 1 to 9
    var player:Player? //? means that the value can be nil (null)
    
    var image:Image{
        
        if let player = player{
            return player.gamePiece.image
        } else{
            return Image("none")
        }
    }
        
    static var reset:[GameSquare]{
        var squares = [GameSquare]()
        
        for index in 1...9 {
            squares.append(GameSquare(id: index))
        }
        
        return squares
    }
    
}
