//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Veselin Stefanov on 15.09.20.
//  Copyright © 2020 Veselin Stefanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var appMove = Int.random(in: 0 ..< 3)
    @State private var playerShouldWin = Bool.random()
    @State private var showWinLooseAlert = false
    @State private var showScoreAlert = false
    @State private var roundNumber = 1
    @State private var playerGuessedRight = false
    @State private var playerScore = 0
    
    var body: some View {
        VStack{
            Text("Round \(roundNumber)")
                .font(.title)
            
            Spacer()
            
            if(self.playerShouldWin){
                Text("Player has to win")
                    .font(.headline)
            }
            else{
                Text("Player has to loose")
                    .font(.headline)
            }
            
            ForEach(0 ..< self.moves.count){number in
                Button(action: {
                    self.onMoveTap(whichMove: number)
                }){
                    if number == self.appMove{
                        Image(self.moves[number])
                            .renderingMode(.original)
                            .shadow(color: Color.red, radius: 3)
                    }
                    else{
                        Image(self.moves[number])
                            .renderingMode(.original)
                    }
                }
            }
            
            Spacer()
            
            .alert(isPresented: $showWinLooseAlert){
                Alert(title: Text("Round ended"), message: playerGuessedRight ? Text("You are correct") : Text("Wrong, try again!"), dismissButton: .default(Text("Continue")){
                        self.resetRound()
                    })
            }
        }
    }
    
    private func onMoveTap(whichMove playerMove: Int){
        switch(appMove){
        case 0:
            if playerShouldWin{
                self.playerGuessedRight = playerMove == 1
            }
            else{
                self.playerGuessedRight = playerMove == 2
            }
        case 1:
            if playerShouldWin{
                self.playerGuessedRight = playerMove == 2
            }
            else{
                self.playerGuessedRight = playerMove == 0
            }
        case 2:
            if playerShouldWin{
                self.playerGuessedRight = playerMove == 0
            }
            else{
                self.playerGuessedRight = playerMove == 1
            }
        default:
            self.playerGuessedRight = false
        }
        
        if self.playerGuessedRight{
            self.playerScore += 1
        }
        else{
            self.playerScore -= 1
        }
        
        self.showWinLooseAlert = true
    }
    
    private func resetRound(){
        
        self.roundNumber += 1
        self.appMove = Int.random(in: 0 ..< 3)
        self.playerShouldWin = Bool.random()
        self.playerGuessedRight = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
