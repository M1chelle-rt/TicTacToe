//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Michelle Thomas on 2/10/25.
//

import SwiftUI

@main
struct AppEntry: App {
    
    @StateObject var game = GameService()
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game)
        }
    }
}
