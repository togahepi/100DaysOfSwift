//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by user197801 on 6/16/21.
//

import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule()).overlay(Capsule().stroke(Color.blue, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)).shadow(color: .purple, radius: 6)
    }
}

extension View {
    func formatFlagImage() -> some View {
        self.modifier(FlagImage())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "Germany", "France", "UK", "US", "Ireland", "Italy","Nigeria", "Poland","Russia","Spain"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingCorrect = false
    @State private var scoreTitle = ""
    @State private var numberFlagTapped = 0
    @State private var score = 0
    @State private var showingScore = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 45) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.black)
                    Text("\(countries[correctAnswer])")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
            
                ForEach(0..<3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                    .formatFlagImage()
                }
                
                Text("Current score: \(score)")
                Spacer()
            }
            
        }
        
        
        .alert(isPresented: $showingScore) {
            if showingCorrect {
               return Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                
                })
            } else {
                return Alert(title: Text(scoreTitle), message: Text("You just tapped flag of \(countries[numberFlagTapped])"), dismissButton: .default(Text("Continue")) {
                                self.askQuestion()
                            })
            }
                
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            showingCorrect = true
            score += 1
        } else {
            scoreTitle = "Wrong"
            showingCorrect = false
            numberFlagTapped = number
            if score > 0 {
                score -= 1
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
