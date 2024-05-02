//
//  ScoreController.swift
//  SwiftUI-BrainGame
//
//  Created by Dominic Barnett on 4/18/24.
//

import Foundation
import UIKit

enum GameState{
    case start
    case playing
    case over
}
                    
enum GameColors: String, CaseIterable{
    case red = "red"
    case blue = "blue"
    case yellow = "yellow"
    case orange = "orange"
    case green = "green"
    case purple = "purple"
    
    func getColor() -> UIColor{
        switch self{
        case .red:
            return UIColor.red
        case .blue:
            return UIColor.blue
        case .green:
            return UIColor.green
        case .yellow:
            return UIColor.yellow
        case .orange:
            return UIColor.orange
        case .purple:
            return UIColor.purple
        }
    }
}

class ColorController: ObservableObject{
    // red, blue, yellow, orange, green, purple

    @Published var score: Int = 0
    @Published var time: Int = 60
    @Published var timer: Timer = Timer()
    @Published var gameState: GameState = .start
    @Published var colorA: GameColors = .red
    @Published var colorBtext: GameColors = .blue
    @Published var colorBcolor: GameColors = .red
    
    
    init(){
        changeColors()
    }
    
    func startGame(){
        gameState = .playing
        time = 60
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.time -= 1
            print(self.time)
            if self.time < 0{
                self.timer.invalidate()
                self.gameState = .over
            }
        })
    }
    
    func changeColors(){
        colorA = GameColors.allCases.randomElement()!
        colorBtext = GameColors.allCases.randomElement()!
        colorBcolor = GameColors.allCases.randomElement()!
        if Int.random(in: 0...1) == 1{
            colorBcolor = colorBtext
        }
    }
    
    func checkAnswer(yes: Bool){
        if yes{
            if colorA == colorBcolor{
                score += 10
            }
            else{
                score -= 10
            }
        }
        else{
            if colorA != colorBcolor{
                score += 10
            }
            else{
                score -= 10
            }
        }
        changeColors()
    }
}

