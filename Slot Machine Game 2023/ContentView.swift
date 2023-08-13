//
//  ContentView.swift
//  Slot Machine Game 2023
//
//  Created by Gan Tu on 7/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingInfoView: Bool = false
    @State private var reels: Array = [0, 1, 2]
    @State private var highScore: Int = 0
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    
    let symbols = [
        "gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"
    ]
    
    func spinReels() {
        reels = reels.map({_ in Int.random(in: 0...symbols.count-1)})
    }

    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] {
            playerWins()
            if coins > highScore {
                newHighScore()
            }
        } else {
            playerLoses()
            // GAME OVER
        }
    }
    
    func playerWins() {
        coins += betAmount * 10
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    func newHighScore() {
        highScore = coins
    }
    
    func gameOver() {
        // TODO
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPruple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .center, spacing: 5) {
                LogoView()
                
                Spacer()
                
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("\(highScore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }
                    .modifier(ScoreContainerModifier())
                }
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                    // MARK: - REEL #1
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }

                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL #3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    
                    // MARK: - SPIN BUTTON
                    Button(action: {
                        self.spinReels()
                        self.checkWinning()
                    }) {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }
                .layoutPriority(2)
                
                
                Spacer ()
                
                HStack {
                    // MARK: - BET 20
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            betAmount = 20
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(betAmount == 20 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(betAmount == 20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    // MARK: - BET 10
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(betAmount == 10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        Button(action: {
                            betAmount = 10
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(betAmount == 10 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                    }
                }
                
            }
            .overlay(alignment: .topLeading) {
                // MARK: - RESET BUTTON
                Button(action: {
                    // TODO
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier())
            }
            .overlay(alignment: .topTrailing) {
                // MARK: - INFO
                Button(action: {
                    self.showingInfoView = true
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier())
            }
            .padding()
            .frame(maxWidth: 720)
        }
        .sheet(isPresented: $showingInfoView, content: {
            InfoView()
        })
    }
}

#Preview {
    ContentView()
}
