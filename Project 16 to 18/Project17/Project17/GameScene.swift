//
//  GameScene.swift
//  Project17
//
//  Created by user197801 on 6/14/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var finalScore: SKLabelNode!
    var resetGame: SKLabelNode!
    let possibleEnemies = ["ball","hammer","tv"]
    var isGameOver = false
    var time: Double = 1
    var enemyCount = 1 {
        didSet {
            
        }
    }
    var gameTimer : Timer? /*= nil {
        willSet {
            gameTimer?.invalidate()
        }
    }*/
    var score = 0 {
        didSet {
            scoreLabel.text = "Score is: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        starField = SKEmitterNode(fileNamed: "starfield")
        starField.position = CGPoint(x: 1024, y: 384)
        starField.advanceSimulationTime(10)
        addChild(starField)
        starField.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(creatEnemy), userInfo: nil, repeats: true)
    }

    @objc func creatEnemy() {
        enemyCount += 1
        if enemyCount%3 == 0 {
            print("if runned")
            gameTimer?.invalidate()
            time -= 0.1
            gameTimer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(creatEnemy), userInfo: nil, repeats: true)
        }
        guard let enemy = possibleEnemies.randomElement() else {return}
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1000, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
//        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
      
        
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        
        var location = touch.location(in: self)
        
        print("tap\(location)")
        print("player was a \(player.position)")
//        if !(tappedNodes.contains(player)) {
//            return
//        }
        if CGPointDistanceSquared(from: player.position, to: location) > 5000 {
            print("too far")
            return
        }
        
        if location.y < 100 {
            location.y = 100
        }
        if location.y > 680 {
            location.y = 680
        }
        
        player.position = location
        print("player is now at \(player.position)")
    }
    
    func CGPointDistanceSquared(from A: CGPoint, to B: CGPoint) -> CGFloat {
        return ((A.x - B.x)*(A.x - B.x) + (A.y - B.y)*(A.y - B.y))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        
        explosion.position = player.position
        
        addChild(explosion)
        player.removeFromParent()
    
        isGameOver = true
        
        if isGameOver {
            gameTimer?.invalidate()
            removeAllChildren()
            finalScore = SKLabelNode(fontNamed: "Chalkduster")
            finalScore.position = CGPoint(x: 512, y: 384)
            finalScore.text = "Your final score is: \(score)"
            addChild(finalScore)

            resetGame = SKLabelNode(fontNamed: "Chalkduster")
            resetGame.position = CGPoint(x: 512, y: 420)
            resetGame.text = "Play again!"
            addChild(resetGame)
            
            addChild(starField)

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        guard (resetGame != nil) else {return}
        let location = touch.location(in: self)
        
        let tappedNodes = nodes(at: location)
        
        if tappedNodes.contains(resetGame) {
            score = 0
            enemyCount = 1
            removeChildren(in: [resetGame,finalScore])
            
            isGameOver = false
            time = 1
            
            gameTimer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(creatEnemy), userInfo: nil, repeats: true)
            player.position = CGPoint(x: 100, y: 384)
            addChild(player)
            addChild(scoreLabel)
            print("Reset game done")
        }
    }
    
}
