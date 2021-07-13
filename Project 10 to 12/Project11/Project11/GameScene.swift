//
//  GameScene.swift
//  Project11
//
//  Created by user197801 on 6/1/21.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var balls = ["Blue","Cyan","Green","Grey","Purple","Red","Yellow"]
    var numberOfBall = Int()
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    var givenBall: SKLabelNode!
    var liveBalls = 5 {
        didSet {
            givenBall.text = "Balls: \(liveBalls)"
        }
    }
    
    var resetGame: SKLabelNode!
    
    override func didMove(to view: SKView) {
        numberOfBall = balls.count
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        creatGameScene()
        
    }
    
    func  creatGameScene() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        resetGame = SKLabelNode(fontNamed: "Chalkduster")
        resetGame.text = "Reset!"
        resetGame.position = CGPoint(x: 300, y: 700)
        addChild(resetGame)
        
        givenBall = SKLabelNode(fontNamed: "Chalkduster")
        givenBall.text = "Balls: \(liveBalls)"
        givenBall.position = CGPoint(x: 530, y: 700)
        addChild(givenBall)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width/2.0)
        bouncer.physicsBody?.isDynamic = false
        bouncer.zPosition = 1
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        let slotBase: SKSpriteNode
        let slotGlow: SKSpriteNode
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        slotGlow.zPosition = 0
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    override func touchesBegan(_ 	touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        
        let object = nodes(at: location)
        
        if object.contains(resetGame) {
            removeAllChildren()
            creatGameScene()
            liveBalls = 5
            score = 0
        }
        
        if object.contains(editLabel) {
            editingMode.toggle()
        } else {
            if editingMode && location.y < 550 {
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                box.name = "box"
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                addChild(box)
                
            } else if !editingMode && location.y >= 550 && location.y <= 680 && liveBalls > 0 {
                liveBalls -= 1
                let ball = SKSpriteNode(imageNamed: "ball\(balls[Int.random(in: 0..<numberOfBall)])")
                ball.position = location
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2.0)
                ball.physicsBody?.restitution = 0.9
                ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask   //this line tell us every collision between our ball and other nodes
                ball.name = "ball"
                addChild(ball)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroyBallGood(ball: ball)
            score += 1
            
        } else if object.name == "bad" {
            destroyBallBad(ball: ball)
            if score > 0 {score -= 1} else {return}
            
        }
        
        if object.name == "box" {
            object.removeFromParent()
        }
    }
    
    func destroyBallBad(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    func destroyBallGood(ball: SKNode) {
        if let snowParticles = SKEmitterNode(fileNamed: "SnowParticles") {
            snowParticles.position = ball.position
            addChild(snowParticles)
        }
        liveBalls += 1
        ball.removeFromParent()
    }
}
