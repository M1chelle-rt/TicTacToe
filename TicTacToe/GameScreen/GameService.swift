//
//  GameService.swift
//  TicTacToe
//
//  Created by Michelle Thomas on 2/17/25.
//

import SwiftUI
//piggybacking on the main therad of the app to update UI
@MainActor

class GameService: ObservableObject{
    @Published var player1 = Player(gamePiece: .X, name: "Player 1")
    @Published var player2 = Player(gamePiece: .O, name: "Player 2")
    
    @Published var possibleMoves = Moves.all
    
    @Published var gameBoard = GameSquare.reset
    
    //we need to build a gameboard
    @Published var gameOver = false
    var gameType = GameType.single
    
    var currentPlayer: Player {
        if player1.isCurrent {
            return player1
        }
        else{
            return player2
        }
    }
    
    var gameStarted: Bool {
        player1.isCurrent || player2.isCurrent
    }
    
    var boardDisabled: Bool{
        gameOver || !gameStarted
    }
    
    func setUpGame(gameType: GameType, player1Name:String, player2Name:String){
        switch gameType {
        case .single:
            self.gameType = .single
            player2.name = player2Name
            
        case .bot:
            self.gameType = .bot
           
        case .peer:
            self.gameType = .peer
            
        case .undetermined:
            self.gameType = .undetermined
            break
        }
        player1.name = player1Name

    }
    
    func reset(){
        player1.isCurrent = false
        player2.isCurrent = false
        
        player1.moves.removeAll()
        player2.moves.removeAll()

        gameOver = false
        
        possibleMoves = Moves.all

        gameBoard = GameSquare.reset

    }
    
    func updateMoves(index: Int){
        if player1.isCurrent{
            player1.moves.append(index+1)
            gameBoard[index].player = player1
        } else {
            player2.moves.append(index+1)
            gameBoard[index].player = player2
        }
    }
    
    func checkIfWinner(){
        if player1.isWinner || player2.isWinner{
            gameOver = true
            
        }
    }
    
    func toggleCurrent(){
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    func makeMove(at index:Int){
        if gameBoard[index].player == nil{
            withAnimation{
                updateMoves(index: index)
            }
            checkIfWinner()
            
            if !gameOver{
                if let matchingIndex = possibleMoves.firstIndex(where: {$0 ==  (index+1)}){
                    possibleMoves.remove(at: matchingIndex)
                }
                
                toggleCurrent()
            }
            if possibleMoves.isEmpty{
                gameOver = true
            }
        }
    }
    
}//class end

