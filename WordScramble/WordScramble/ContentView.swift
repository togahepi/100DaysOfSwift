//
//  ContentView.swift
//  WordScramble
//
//  Created by user197801 on 6/26/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWord = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word:", text: $newWord ,onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                List(usedWord, id: \.self) {
                    let ran = (0...1).randomElement()
                    Image(systemName: "\($0.count).circle.fill")
                        .foregroundColor(ran == 1 ? .purple: .green)
                    Text($0)
                }
                
                Text("Your score is: \(score)")
                Spacer()
            }
            .onAppear(perform: startGame)
            
            .alert(isPresented: $showingError) {
                Alert(title: Text("\(errorTitle)"), message: Text("\(errorMessage)"), dismissButton: .default(Text("OK!")))
            }
            .navigationBarItems(trailing:
                                    Button("New word", action: {startGame()} )
            )
            .navigationBarTitle(rootWord)
        }
        
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard answer.count > 2 else {
            wordError(title: "Word is too short", message: "You can do better than that!")
            return
        }
        
        guard answer != rootWord.lowercased() else {
            wordError(title: "Really?", message: "You can not use given word!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word is not regconize", message: "You can not make up words")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        score += 1 + answer.count
        usedWord.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "Kitty"
                usedWord.removeAll(keepingCapacity: true)
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWord.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
    
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspellRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspellRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
