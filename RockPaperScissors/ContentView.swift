//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Veselin Stefanov on 15.09.20.
//  Copyright © 2020 Veselin Stefanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private enum Moves: Int{
        case Rock
        case Paper
        case Scissors
    }
    
    private let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var appMove = Int.random(in: 0 ..< 3)
    @State private var playerShouldWin = Bool.random()
    @State private var playerGuessedRight = false
    
    @State private var playerScore = 0
    @State private var roundNumber = 1
    
    @State private var showWinLooseAlert = false
    @State private var showScoreAlert = false
    
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
                    
//                     If the app shows what move has been chosen
                     
                     if number == self.appMove{
                         Image(self.moves[number])
                             .renderingMode(.original)
                             .shadow(color: Color.red, radius: 3)
                     }
                     else{
                         Image(self.moves[number])
                             .renderingMode(.original)
                     }
                     
                     
                    
//                    Image(self.moves[number])
//                        .renderingMode(.original)
                }
            }
            
            Spacer()
            
            .alert(isPresented: $showWinLooseAlert){
                Alert(title: playerGuessedRight ? Text("You are correct") : Text("Wrong, try again!"), message: Text("Your score \(self.playerScore)"), dismissButton: .default(Text("Continue")){
                        self.resetRound()
                    })
            }
        }
    }
    
    private func hasPlayerWon(appMove: Int, playerMove: Int) -> Bool{
        let appMove = Moves(rawValue: self.appMove)
        let playerMove = Moves(rawValue: playerMove)
        
        if appMove == Moves.Rock && playerMove != Moves.Paper{
            return false
        }
        
        if appMove == Moves.Paper && playerMove != Moves.Scissors{
            return false
        }
        
        if appMove == Moves.Scissors && playerMove != Moves.Rock{
            return false
        }
        
        return true
    }
    
    private func onMoveTap(whichMove playerMove: Int){
        
        self.playerGuessedRight = hasPlayerWon(appMove: self.appMove, playerMove: playerMove) == playerShouldWin
        if self.playerGuessedRight{
            self.playerScore += 1
        }
        else if self.playerScore > 0{
            self.playerScore -= 1
        }
        
        self.showWinLooseAlert = true
    }
    
    private func resetRound(){
        
        // If the last round is reached
        if roundNumber == 10{
            roundNumber = 1
            playerScore = 0
        }
        else{
            roundNumber += 1
        }
        
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
