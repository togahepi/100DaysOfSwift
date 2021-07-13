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
    var histories = [History]()
    var question = String()
    var isBackFromHistories = false
    var indexBackFromHistories = Int()
    var count = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promtForAnswer))
        let restart = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        let viewHitories = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(viewHistories))
        navigationItem.leftBarButtonItems = [restart,viewHitories]
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordUrl) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["SilkWorm"]
        }
        let defaults = UserDefaults.standard
        if let savedHistories = defaults.object(forKey: "histories") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                histories = try jsonDecoder.decode([History].self, from: savedHistories)
            } catch {
                
            }
        }
//        let defaults = UserDefaults.standard
//        usedWord = defaults.array(forKey: "answers") as? [String] ?? [String]()
//        print(usedWord)
//        question = defaults.object(forKey: "question") as? String ?? String()
//        if question.isEmpty {
//            startGame()
//        } else {
//            title = question
//            tableView.reloadData()
//        }
        if isBackFromHistories {
            tableView.reloadData()
        } else {
            if histories.isEmpty {
                startGame()
            } else {
//                histories.removeAll()
//                save()
                let dataToLoad = histories.last
                title = dataToLoad?.question
                usedWord = dataToLoad?.answers ?? [String]()
            }
        }
        
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
        question = allWords.randomElement()!
        title = question
        isBackFromHistories = false
        usedWord.removeAll(keepingCapacity: true)
        
        let history = History(question: question, answers: usedWord)
        histories.append(history)
        save()
//        let defaults = UserDefaults.standard
//        defaults.set(question, forKey: "question")
//        defaults.set(usedWord, forKey: "answers")
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
//                        let defaults = UserDefaults.standard
//                        defaults.set(usedWord, forKey: "answers")
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        if isBackFromHistories {
                            histories.remove(at: indexBackFromHistories)
                            let history = History(question: question, answers: usedWord)
                            histories.insert(history, at: indexBackFromHistories)
                            save()
                            count += 1
        
                            return
                        } else {
                            histories.removeLast()
                            let history = History(question: question, answers: usedWord)
                            histories.append(history)
                            save()
                            count += 1
                            
                            return
                        }
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
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(histories) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "histories")
        }
    }
    
    @objc func viewHistories() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Histories") as? HistoryTableViewController {
            vc.historiesSaved = histories
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

