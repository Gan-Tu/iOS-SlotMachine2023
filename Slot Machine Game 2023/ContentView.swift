//
//  ContentView.swift
//  Slot Machine Game 2023
//
//  Created by Gan Tu on 7/29/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var showingInfoView: Bool = false
    @State private var showingGameOverModal: Bool = false
    @State private var reels: Array = [0, 1, 2]
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var animatingSymbols: Bool = false
    @State private var animatingGameOverModal: Bool = false
    
    let symbols = [
        "gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"
    ]
    
    // MARK: - FUNCTIONS
    
    func spinReels() {
        reels = reels.map({_ in Int.random(in: 0...symbols.count-1)})
        playSound(sound: "spin", type: "mp3")
    }

    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] {
            coins += betAmount * 10
            if coins > highScore {
                highScore = coins
                UserDefaults.standard.set(highScore, forKey: "HighScore")
                playSound(sound: "high-score", type: "mp3")
            } else {
                playSound(sound: "win", type: "mp3")
            }
        } else {
            coins -= betAmount
            if coins <= 0 {
                showingGameOverModal = true
            }
        }
    }
    
    func isGameOver() {
        if coins <= 0 {
            showingGameOverModal = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highScore = 0
        showingGameOverModal = false
        coins = 100
        betAmount = 10
        playSound(sound: "chimeup", type: "mp3")
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
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
                            .opacity(animatingSymbols ? 1 : 0)
                            .offset(y: animatingSymbols ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                            .onAppear(perform: {
                                self.animatingSymbols.toggle()
                                playSound(sound: "riseup", type: "mp3")
                            })
                    }

                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbols ? 1 : 0)
                                .offset(y: animatingSymbols ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear(perform: {
                                    self.animatingSymbols.toggle()
                                })
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL #3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbols ? 1 : 0)
                                .offset(y: animatingSymbols ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                                .onAppear(perform: {
                                    self.animatingSymbols.toggle()
                                })
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    
                    // MARK: - SPIN BUTTON
                    Button(action: {
                        withAnimation {
                            self.animatingSymbols = false
                        }
                        
                        self.spinReels()
                        
                        withAnimation {
                            self.animatingSymbols = true
                        }

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
                            playSound(sound: "casino-chips", type: "mp3")
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(betAmount == 20 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: betAmount == 20 ? 0 : 20)
                            .opacity(betAmount == 20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    Spacer()
                    
                    // MARK: - BET 10
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: betAmount == 10 ? 0 : -20)
                            .opacity(betAmount == 10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        Button(action: {
                            betAmount = 10
                            playSound(sound: "casino-chips", type: "mp3")
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
                    self.resetGame()
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
            .blur(radius: $showingGameOverModal.wrappedValue ? 5 : 0, opaque: false)
            
            // MARK: - POPUP
            if $showingGameOverModal.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad luck! You lost all the coins.\nLet's play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button(action: {
                                self.showingGameOverModal = false
                                self.animatingGameOverModal = false
                                betAmount = 10
                                coins = 100
                            }) {
                                Text("New game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(minWidth: 200, idealWidth: 200, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y:8)
                    .opacity($animatingGameOverModal.wrappedValue ? 1 : 0)
                    .offset(y: $animatingGameOverModal.wrappedValue ? 1 : -100)
                    .onAppear(perform: {
                        withAnimation(.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0)) {
                            self.animatingGameOverModal = true
                        }
                    })
                }
            }
            
        }
        .sheet(isPresented: $showingInfoView, content: {
            InfoView()
        })
    }
}

#Preview {
    ContentView()
}
