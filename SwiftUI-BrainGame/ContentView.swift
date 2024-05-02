//
//  ContentView.swift
//  SwiftUI-BrainGame
//
//  Created by Dominic Barnett on 4/18/24.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var colorController: ColorController
    var body: some View {
        ZStack{
            VStack {
                HStack{
                    Button("II"){}
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
                    Text("✅")
                }
                    Spacer()
            

                HStack{
                    Button("No"){
                        colorController.checkAnswer(yes: false)
                    }
                        .frame(width: 150)
                        .padding()
                        .background(.white)
                        .cornerRadius(15.0)
                    Button("Yes"){
                        colorController.checkAnswer(yes: true)
                    }
                        .frame(width: 150)
                        .padding()
                        .background(.white)
                        .cornerRadius(15.0)

                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            .background(.brown)
        }
        
       
    }
}

struct HomeView: View {
    @State private var isShowingGameView: Bool = false
    @StateObject var colorController = ColorController()
    var body: some View {
        NavigationView(content: {
            
            VStack {
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
                .background(Color.blue)
            }
        })
        .environmentObject(colorController)
    }
}

struct GameOverView: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

#Preview {
    HomeView()
}
