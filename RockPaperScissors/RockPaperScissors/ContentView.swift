//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by user197801 on 6/22/21.
//

import SwiftUI

struct iphoneHandImage: View {
    var text: String
    var body: some View {
        Image(text)
        .resizable()
        .frame(width: 120, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct backgroundColor: View {
    var text: String
    var body: some View {
        if text == "win" {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 1, blue: 135/255), Color(red: 200/255, green: 239/255, blue: 1)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        if text == "lose" {
            LinearGradient(gradient: Gradient(colors: [Color(red: 137/255, green: 2/255, blue: 62/255), Color(red: 255/255, green: 217/255, blue: 218/255)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        }
        if text == "begin" {
            Color(red: 246/255, green: 239/255, blue: 238/255).edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView: View {
    @State private var hands = ["rock", "paper", "scissors"]
    var loseTitle = ["Ha ha! You loser hooman!", "My CPU is 5nm! And you loser?", "I win! I'm so smart.", "Loser go tell your mom", "Hype Apple! iPhone beat hooman"]
    @State private var loseNum = 0
    var winTitle = ["You win? But for how long?", "You're just lucky man!", "Win? Your doom day will come!", "Oh, that's kind of surprise", "Win me this round? But forever, I doubt it!"]
    @State private var winNum = 0
    @State private var handOfIphone = Int.random(in: 0...2)
    @State private var imageHandOfIphone = "iphone"
    @State private var showingScore = false
    @State private var showingCorrect = false
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var theme = "begin"
    var body: some View {
        ZStack {
            backgroundColor(text: theme)
            VStack {
                Text("Beat your iPhone!")
                    .foregroundColor(.orange)
                    .font(.largeTitle)
                    .padding(50)

                iphoneHandImage(text: imageHandOfIphone)
                Spacer()
                HStack {
                    ForEach(0..<3) { num in
                        Button(action: {handTapped(num)}
                        ) {
                            Image(self.hands[num])
                                .resizable()
                                .frame(width: 100, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)).overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.orange, lineWidth: 1))
                     
                        }
                   }
                }
                Text("Your score is: \(score)")
                    .foregroundColor(.orange)
                    .font(.custom("Cochin", size: 32))
                    .padding(30)

            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Come on! Next Round!")) {
                    self.newRound()
                })
            }
        }
        
    }
    
    func handTapped(_ number: Int) {
        showingScore = true
        if number == handOfIphone {
            theme = "begin"
            imageHandOfIphone = hands[handOfIphone]
            scoreTitle = "Draw! Pretty good man!"
        }
        switch number {
        case 0:
            if handOfIphone == 1 {
                lose()
            } else if handOfIphone == 2 {
                win()
            }
        case 1:
            if handOfIphone == 0 {
                win()
            } else if handOfIphone == 2 {
                lose()
            }
        default:
            if handOfIphone == 0 {
                lose()
            } else if handOfIphone == 1 {
                win()
            }
        }

    }
    
    func lose() {
        theme = "lose"
        imageHandOfIphone = hands[handOfIphone]
        loseNum = Int.random(in: 0...4)
        scoreTitle = loseTitle[loseNum]
        if score > 0 {score -= 1}
    }
    
    func win() {
        theme = "win"
        imageHandOfIphone = hands[handOfIphone]
        winNum = Int.random(in: 0...4)
        scoreTitle = winTitle[winNum]
        score += 1
    }
    
    func newRound() {
        imageHandOfIphone = "iphone"
        handOfIphone = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
