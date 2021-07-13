//
//  GameScene.swift
//  Project14
//
//  Created by user197801 on 6/8/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var numRounds = 0
    var popupTime = 0.85
    var slots = [WhackSlot]()
    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score is: \(score)"
        }
    }
    let playAgain = SKLabelNode(fontNamed: "Noteworthy")
    let gameOver = SKSpriteNode(imageNamed: "gameOver")
    let scoreFinal = SKLabelNode(fontNamed: "Noteworthy")
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.zPosition = -1
        background.blendMode = .replace
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score is: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        
        
        for i in 0..<5 {creatSlot(at: CGPoint(x: 100 + (i*170), y: 410))}
        for i in 0..<4 {creatSlot(at: CGPoint(x: 180 + (i*170), y: 320))}
        for i in 0..<5 {creatSlot(at: CGPoint(x: 100 + (i*170), y: 230))}
        for i in 0..<4 {creatSlot(at: CGPoint(x: 180 + (i*170), y: 140))}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.creatEnemy()
        }
    }
    func creatSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    func creatEnemy() {
        numRounds += 1
        
        if numRounds >= 30 {
            for slot in slots {
                slot.hide()
            }
            
            
            gameOver.position = CGPoint(x: 512, y: 480)
            gameOver.zPosition = 1
            addChild(gameOver)
            
            
            scoreFinal.text = "Final score is: \(score)"
            scoreFinal.fontSize = 48
            scoreFinal.position = CGPoint(x: 512, y: 348)
            scoreFinal.zPosition = 1
            addChild(scoreFinal)
            
            playAgain.text = "Play again!"
            playAgain.fontSize = 40
            playAgain.position = CGPoint(x: 512, y: 265)
            playAgain.zPosition = 1
            addChild(playAgain)
            
            removeChildren(in: [gameScore])
            return
        }
        popupTime *= 0.991
        
        slots.shuffle()
        slots[0].show(hideTime: popupTime)
        slots[0].mud(at: CGPoint(x: 0, y: -40))
        
        if Int.random(in: 0...12) > 4 {slots[1].show(hideTime: popupTime)
            slots[1].mud(at: CGPoint(x: 0, y: -40))
        }
        if Int.random(in: 0...12) > 8 {slots[2].show(hideTime: popupTime)
            slots[2].mud(at: CGPoint(x: 0, y: -40))
        }
        if Int.random(in: 0...12) > 10 {slots[3].show(hideTime: popupTime)
            slots[3].mud(at: CGPoint(x: 0, y: -40))
        }
        if Int.random(in: 0...12) > 11 {slots[4].show(hideTime: popupTime)
            slots[4].mud(at: CGPoint(x: 0, y: -40))
        }
        
        let minDelay = popupTime/2.0
        let maxDelay = popupTime*2.0
        
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.creatEnemy()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let locationOfTouch = touch.location(in: self)
        
        let tappedNodes = nodes(at: locationOfTouch)
        
        if tappedNodes.contains(playAgain) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.creatEnemy()
            }
            removeChildren(in: [gameOver,playAgain,scoreFinal])
            score = 0
            addChild(gameScore)
            numRounds = 0
            popupTime = 0.85
        }
        
        for node in tappedNodes {
            guard let whackSlot = node.parent?.parent as? WhackSlot else {return}
            if !whackSlot.isVisible {continue}
            if whackSlot.isHit {continue}
            whackSlot.hit()
            print(whackSlot.position)
            
            if node.name == "charFriend" {
                smokeItGood(at: whackSlot.position)
                score -= 5
                
                run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
            } else if node.name == "charEnemy" {
                whackSlot.charNode.xScale = 0.85
                whackSlot.charNode.yScale = 0.85
                
                smokeItBad(at: whackSlot.position)
                score += 1
                
                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            }
        }
    }
    func smokeItBad(at position: CGPoint) {
        if let smoke = SKEmitterNode(fileNamed: "SmokeBad") {
            smoke.position = position
            addChild(smoke)
        }
    }
    
    func smokeItGood(at position: CGPoint) {
        if let smoke = SKEmitterNode(fileNamed: "SmokeGood") {
            smoke.position = position
            addChild(smoke)
        }
    }

}
