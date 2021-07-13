//
//  ViewController.swift
//  Project2
//
//  Created by user197801 on 5/9/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var highScore: UITextField!
    
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var totalAskedQuestion = 0
    var highestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor(red: 1.2, green: 0.5, blue: 0.8, alpha: 1.0).cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score!", style: .plain, target: self, action: #selector(showScore))
    }
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        
        let defaults = UserDefaults.standard
        highestScore = defaults.integer(forKey: "highestScore")
        highScore.text = "Highest score is: \(highestScore)"
        
        title = "Which flag is \(countries[correctAnswer].uppercased())?"
    }
    
    @objc func showScore() {
        let vc = UIAlertController(title: "Your score is: \(score)", message: "", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel)) //this is a way that add cancel button to return
        present(vc, animated: true, completion: {
            //vc.view.superview?.isUserInteractionEnabled = true
            vc.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
            //self.dismiss(animated: true, completion: nil) //this line only will make aler message dismiss immediately
        })
    }
    
    @objc func dismissOnTapOutside() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func resetGame(action: UIAlertAction! = nil) {
        if score > highestScore {
            highestScore = score
            highScore.text = "Highest score is: \(highestScore)"
            score = 0
        }
        totalAskedQuestion = 0
        askQuestion()
    }
    @IBAction func buttonTaped(_ sender: UIButton) {
        totalAskedQuestion += 1
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        })
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else if score > 0 {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        } else {
            title = "Wrong! That's the flag is \(countries[sender.tag].uppercased())"
        }
        
        if totalAskedQuestion < 10 {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else if score > highestScore {
            let ac = UIAlertController(title: title, message: "You get highest score: \(score)", preferredStyle: .alert)
            saveHighScore(score)
            ac.addAction(UIAlertAction(title: "Reset game!", style: .default, handler: resetGame))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Reset game!", style: .default, handler: resetGame))
            present(ac, animated: true)
        }
        sender.transform = .identity
    }
    
    func saveHighScore(_ highest: Int) {
        let defaults = UserDefaults.standard
        defaults.set(highest, forKey: "highestScore")
    }
}

