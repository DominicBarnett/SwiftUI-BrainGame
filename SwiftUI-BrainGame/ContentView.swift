//
//  ContentView.swift
//  SwiftUI-BrainGame
//
//  Created by Dominic Barnett on 4/18/24.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var colorController: ColorController
    @State private var isGameOver: Bool = false
    
    var body: some View {
            ZStack {
                VStack {
                    HStack {
                        Button("II") {}
                            .padding()
                        Spacer()
                        Text("Time: \(colorController.time)")
                            .padding()
                        Text("Score: \(colorController.score)")
                            .padding()
                    }
                    Spacer()
                    Text("Does the meaning match the text color?")
                    ZStack {
                        VStack {
                            Text("meaning")
                            Text(colorController.colorA.rawValue)
                                .foregroundColor(Color(.black))
                                .frame(width: 150)
                                .padding()
                                .background(.white)
                                .cornerRadius(15.0)
                            
                            Text(colorController.colorBtext.rawValue)
                                .foregroundColor(Color(colorController.colorBcolor.getColor()))
                                .frame(width: 150)
                                .padding()
                                .background(.white)
                                .cornerRadius(15.0)
                            Text("text color")
                        }
                    }
                    Spacer()
                    
                    HStack {
                        Button("No") {
                            colorController.checkAnswer(yes: false)
                        }
                        .frame(width: 150)
                        .padding()
                        .background(.white)
                        .cornerRadius(15.0)
                        Button("Yes") {
                            colorController.checkAnswer(yes: true)
                        }
                        .frame(width: 150)
                        .padding()
                        .background(.white)
                        .cornerRadius(15.0)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color.brown)
                
                NavigationLink(destination: GameOverView(restartGame: {
                    self.isGameOver = false
                }), isActive: $isGameOver) {
                    EmptyView()
                }
                .isDetailLink(false)
            
        }
        .onReceive(colorController.$gameState) { gameState in
            if gameState == .over {
                self.isGameOver = true
            }
        }
    }
}

struct HomeView: View {
    @State private var isShowingGameView: Bool = false
    @StateObject var colorController = ColorController()
    var body: some View {
        NavigationView(content: {
            
            ZStack {
                VStack {
                    Spacer()
                    Text("Welcome to The Brain Game")
                    Spacer()
                    NavigationLink(
                        destination:GameView(),
                        isActive: $isShowingGameView,
                        label: {
                            EmptyView()
                        })
                    
                    Button("play"){
                        colorController.startGame()
                        self.isShowingGameView = true
                    }
                    .foregroundColor(.white)
                    .frame(width: 150)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15.0)

                    
                    Spacer()
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity
                    )
            }
            .background(.brown)
        })
        .environmentObject(colorController)
        .accentColor(.black)
    }
}

struct GameOverView: View {
    let restartGame: () -> Void
    @State private var isShowingGameView: Bool = false
    @EnvironmentObject var colorController: ColorController
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                Text("Game Over")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text("Score: \(colorController.score)")
                    .foregroundColor(.white)
                    .padding()
                Spacer()
//                NavigationLink(
//                    destination:GameView(),
//                    isActive: $isShowingGameView,
//                    label: {
//                        EmptyView()
//                    })
                Button("Restart") {
                    colorController.restartGame()
                    dismiss()
//                    restartGame()
//                    self.isShowingGameView = true
//                    
                }
                .foregroundColor(.white)
                .frame(width: 150)
                .padding()
                .background(Color.blue)
                .cornerRadius(15.0)
                Spacer()
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
        }
        .background(Color.brown)
    }
}
#Preview {
    HomeView()
}

// Timer logic
// If timer <= 0
//      navigate to GameOverView
