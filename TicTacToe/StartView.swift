//
//  ContentView.swift
//  TicTacToe
//
//  Created by Michelle Thomas on 2/10/25.
//

import SwiftUI


struct StartView: View {
    
    @EnvironmentObject var game:GameService
    
    @State private var gameType: GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    
    @FocusState private var focus: Bool //whether or not the keyboard is present or not
    
    @State private var startGame = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Picker("Select the game", selection: $gameType) {
                    Text("Select Game Type").tag(GameType.undetermined)
                    
                    Text("Two sharing a device").tag(GameType.single)
                    
                    Text("Challenge your device").tag(GameType.bot)
                    
                    Text("Challenge a friend").tag(GameType.peer)
                    
                } //picker ends
                .padding()
                
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous))
                Text(gameType.description)
                    .padding()
                
                VStack{
                    switch gameType {
                    case .single:
                        TextField("Your Name", text: $yourName)
                        TextField("Your Opponent's Name", text: $opponentName)
                    case .bot:
                        TextField("Your Name", text: $yourName)
                    case .peer:
                        EmptyView()
                    case .undetermined:
                        EmptyView()
                    }
                }
                
                
                .padding()
                .textFieldStyle(.roundedBorder)
                .focused($focus)
                .frame(width:350)
                
                if gameType != .peer {
                    Button("Start Game"){
                        //setup the game MT
                        game.setUpGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                        focus = false
                        startGame.toggle()
                    }//end button
                    .buttonStyle(.borderedProminent)
                    .disabled(gameType == .undetermined || yourName.isEmpty || ( gameType == .single && opponentName.isEmpty))
                    Image("welcomeScreen")
                }
                Spacer()
            }//Vstack picker ends
            
            
            .padding()
            .navigationTitle("Tic-Tac-Toe")
            .fullScreenCover(isPresented: $startGame) {
                GameView()
            }
        }
    }
}
    


#Preview {
    StartView()
        .environmentObject(GameService())
    //RM revisit
    
}
