//
//  GameView.swift
//  TicTacToe
//
//  Created by Michelle Thomas on 2/24/25.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack{
            VStack{
                if[game.player1.isCurrent,
                   game.player2.isCurrent]
                    .allSatisfy({$0==false}){
                    Text("Select a player to start game.")
                    
                }
                
                HStack{
                    Button(game.player1.name) {
                        game.player1.isCurrent = true
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(game.player1.isCurrent ?
                              Color.green: Color.gray)
                    )//end of background bracket
                    .foregroundColor(.white)
                    
                    Button(game.player2.name) {
                        game.player2.isCurrent = true
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(game.player2.isCurrent ?
                              Color.green: Color.gray)
                    )//end of background bracket
                    .foregroundColor(.white)
                }
                .disabled(game.gameStarted)
                
                //create the game board
                VStack{
                    HStack{
                        ForEach(0...2, id: \.self){
                            index in SquareView(index: index)
                        }//end for
                    }
                    HStack{
                        ForEach(3...5, id: \.self){
                            index in SquareView(index: index)
                        }//end for
                    }
                    HStack{
                        ForEach(6...8, id: \.self){
                            index in SquareView(index: index)
                        }//end for
                    }
                    
                    
                }//end of board vstack
                
                
                .disabled(game.boardDisabled)
                
                //display the winner when the game is over
                
                VStack{
                    if game.gameOver{
                        Text("Game Over!")
                        
                        if game.possibleMoves.isEmpty{
                            Text("It's a draw!")
                        } else {
                            Text("\(game.currentPlayer.name) wins")
                        }
                        
                        Button("New Game"){
                            game.reset()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }//end of game result vstack
                .font(.largeTitle)
                
                Spacer()
            }
            
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("End Game"){
                        dismiss()
                    }.buttonStyle(.bordered)
                    
                }
            }//end of toolbar
            .navigationTitle("Tic-Tac-Toe")
            .onAppear {
                game.reset()
            }
        }
    }
}

#Preview {
    GameView()
        .environmentObject(GameService())
}
