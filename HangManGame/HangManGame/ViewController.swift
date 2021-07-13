//
//  ViewController.swift
//  HangManGame
//
//  Created by user197801 on 5/29/21.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    let alphabet = [" ","a","b","c","d","e","&","f","g","h","i","j","k","l","m","n","o","p","q","s","r","t","u","v","w","x","y","z"]

    var countries = [String]()
    var wordToGuest = String()
    var wordToHide = UITextField()
    let hangMan = UIButton(type: .custom)
    var hangManNum = 0
    var activatedButton = [UIButton]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        hangMan.translatesAutoresizingMaskIntoConstraints = false
        hangMan.setImage(UIImage(named: "\(hangManNum)"), for: .normal)
        hangMan.isUserInteractionEnabled = false
        hangMan.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(hangMan)
        
        wordToHide.translatesAutoresizingMaskIntoConstraints = false
        wordToHide.textAlignment = .center
        wordToHide.placeholder = "Tap letter to guess. Only 7 fails accepted!"
        wordToHide.font = UIFont.systemFont(ofSize: 40)
        wordToHide.isUserInteractionEnabled = false
        view.addSubview(wordToHide)
        
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonView)
        
        let width = 100
        let height = 60
        var index = 0
        for row in 0..<4 {
            for column in 0..<7 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                letterButton.setTitle(alphabet[index], for: .normal)
                letterButton.setTitleColor(randomColor(), for: .normal)
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = randomColor().cgColor
                let frame = CGRect(x: column*width, y: height*row, width: width, height: height)
                letterButton.frame = frame
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                buttonView.addSubview(letterButton)
                index += 1
                
            }
        }
        
        NSLayoutConstraint.activate([
            hangMan.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            hangMan.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hangMan.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            wordToHide.topAnchor.constraint(equalTo: hangMan.bottomAnchor, constant: 60),
            wordToHide.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.widthAnchor.constraint(equalToConstant: 700),
            buttonView.heightAnchor.constraint(equalToConstant: 240),
            buttonView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: wordToHide.bottomAnchor, constant: 40),
            buttonView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -40)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        loadGame()
    }

    func loadData() {
        if let dataGameUrl = Bundle.main.url(forResource: "countries", withExtension: "txt") {
            if let dataGame = try? String(contentsOf: dataGameUrl) {
                countries = dataGame.components(separatedBy: "\n")
            }
        }
    }
    func loadGame() {
        let trueRamdomIndex = GKShuffledDistribution(lowestValue: 0, highestValue: countries.count)
        wordToGuest = countries[trueRamdomIndex.nextInt()]
        for _ in 0..<wordToGuest.count {
            wordToHide.text! += "*"
        }
        print(wordToGuest)
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        activatedButton.append(sender)
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            sender.layer.borderWidth = 0
            sender.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
        UIView.animate(withDuration: 0.1, delay: 0.2, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
        UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
//            sender.transform = CGAffineTransform(scaleX: 2, y: 2)
            sender.transform = CGAffineTransform(translationX: 0, y: -10)
            
        })
        UIView.animate(withDuration: 0.1, delay: 0.3, options: [], animations: {
            sender.alpha = 0
        })
        let lowerWordToGuest = wordToGuest.lowercased()
        guard let letter = sender.titleLabel?.text else {
            return
        }
        var wordModifier = wordToHide.text!
        var chars = Array(wordModifier)
        var letterFound = false
        for (index, char) in lowerWordToGuest.enumerated() {
            if letter.contains(char) {
                chars[index] = char
                letterFound = true
            }
        }
        wordModifier = String(chars)
        
        wordToHide.text = wordModifier
        
        if wordModifier == lowerWordToGuest {
            
            let ac = UIAlertController(title: "You Win!", message: "Ha Ha Ha!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Come on! Next word!", style: .cancel) { [weak self] action in
                self?.resetGame()
            })
            present(ac, animated: true)
        }
        
        
        
        if !letterFound {
            hangManNum += 1
            hangMan.setImage(UIImage(named: "\(hangManNum)"), for: .normal)
            print(hangManNum)
            print(activatedButton.count)
        }
        
        if hangManNum == 7 {
            let ac = UIAlertController(title: "You Lose!", message: "Ha Ha Ha!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK bro!!!", style: .cancel) { [weak self] action in
                self?.resetGame()
            })
            present(ac, animated: true)
        }
    }
    
    @objc func resetGame() {
        wordToHide.text = ""
        for button in activatedButton {
            button.alpha = 1
            button.layer.borderWidth = 1
            button.transform = .identity
        }
        activatedButton.removeAll(keepingCapacity: true)
        loadGame()
        hangManNum = 0
        hangMan.setImage(UIImage(named: "\(hangManNum)"), for: .normal)
    }
    
    func randomColor() -> UIColor {
        let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
         
        return color
    }
}

