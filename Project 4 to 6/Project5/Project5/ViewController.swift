//
//  ViewController.swift
//  Project5
//
//  Created by user197801 on 5/14/21.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWord = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promtForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordUrl) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["SilkWorm"]
        }
        startGame()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWord.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWord[indexPath.row]
        return cell
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWord.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }
    
    @objc func promtForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
//        ac.addTextField()
//        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Sumit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        let errorTitle : String
        let errorMessage : String
        
        if lowerAnswer.isEmpty {
            return
        }
        if lowerAnswer == title?.lowercased() {
            return
        }
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    if lowerAnswer.count < 3 {
                        errorTitle = "Word is too short"
                        errorMessage = "Find words with length above 3 letters"
                    } else {
                        usedWord.insert(lowerAnswer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                    }
                    
                } else {
                    errorTitle = "Word not recognised"
                    errorMessage = "You can not just make them up, you know!"
                }
            } else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        } else {
            guard let title = title?.lowercased() else {
                return
            }
            errorTitle = "Word is not possible"
            errorMessage = "You can not spell that word from \(title)"
        }
        
        showErrorMessage(errorTitle, errorMessage)
        
    }
    
    func showErrorMessage(_ title: String,_ message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {
            return false
        }
        
        for letter in word {
            if let possition = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: possition)
            } else {
                return false
            }
        }
        return true
    }
    func isOriginal(word: String) -> Bool {
//        for answer in usedWord {                                //used it if you want answer can have capitalized letter
//            if answer.lowercased() == word.lowercased() {
//                return false
//            }
//        }
//        return true
        return !usedWord.contains(word)
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missSpelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return missSpelledRange.location == NSNotFound
    }
    

}

