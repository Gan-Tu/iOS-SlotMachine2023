//
//  ContentView.swift
//  Slot Machine Game 2023
//
//  Created by Gan Tu on 7/29/23.
//

import SwiftUI

struct ContentView: View {
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
                        
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("200")
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
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }

                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL #3
                        ZStack {
                            ReelView()
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: - SPIN BUTTON
                    Button(action: {
                        // TODO
                    }) {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }
                
                
                Spacer ()
                
                HStack {
                    // MARK: - BET 20
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            // TODO
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .font(.system(.title, design: .rounded))
                                .padding(.vertical, 5)
                                .frame(width: 90)
                                .shadow(color: Color("ColorTransparentBlack"), radius: 0, x:0, y:3)
                        }
                        .background(
                            Capsule()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom))
                                .padding(3)
                                .background(
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .bottom, endPoint: .top))
                                    
                                )
                        )
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
                            .scaledToFit()
                            .frame(height: 64)
                            .animation(.default)
                            .modifier(ShadowModifier())
                    }
                }
                
            }
            .overlay(alignment: .topLeading) {
                Button(action: {
                    // TODO
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier())
            }
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    // TODO
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier())
            }
            .padding()
            .frame(maxWidth: 720)
        }
    }
}

#Preview {
    ContentView()
}
