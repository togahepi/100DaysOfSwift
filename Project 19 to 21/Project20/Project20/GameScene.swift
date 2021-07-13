//
//  GameScene.swift
//  Project20
//
//  Created by user197801 on 6/23/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var gameTimer: Timer?
    var fireworks = [SKNode]()
    
    let leftEdge = -22
    let bottomEdge = -22
    
    let rightEdge = 1024 + 22
    
    var score = 0 {
        didSet {
            
        }
    }
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.zPosition = -1
        background.blendMode = .replace
        addChild(background)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
        
    }
    
    @objc func launchFireworks() {
//        creatFireworks(xMovement: 1100, x: leftEdge, y: bottomEdge+300)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.creatFireworks(xMovement: 1000, x: self.leftEdge, y: self.bottomEdge+250)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.creatFireworks(xMovement: 1000, x: self.leftEdge, y: self.bottomEdge+250)
        }
//        creatFireworks(xMovement: -1100, x: rightEdge, y: bottomEdge+300)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.creatFireworks(xMovement: -1000, x: self.rightEdge, y: self.bottomEdge+250)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.creatFireworks(xMovement: -1000, x: self.rightEdge, y: self.bottomEdge+250)
        }
        creatFireworks(xMovement: -590, x: 521, y: bottomEdge)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            self?.creatFireworks(xMovement: -590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.creatFireworks(xMovement: -590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.creatFireworks(xMovement: -590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) { [weak self] in
            self?.creatFireworks(xMovement: -590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.creatFireworks(xMovement: -590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) { [weak self] in
            self?.creatFireworks(xMovement: -590, x: 521, y: self!.bottomEdge)
        }
        creatFireworks(xMovement: 590, x: 512, y: bottomEdge)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            self?.creatFireworks(xMovement: 590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.creatFireworks(xMovement: 590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.creatFireworks(xMovement: 590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) { [weak self] in
            self?.creatFireworks(xMovement: 590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.creatFireworks(xMovement: 590, x: 521, y: self!.bottomEdge)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) { [weak self] in
            self?.creatFireworks(xMovement: 590, x: 521, y: self!.bottomEdge)
        }
        
        
        creatFireworksDown(xMovement: 1030, x: 80, y: 790)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.creatFireworksDown(xMovement: 1030, x: 80, y: 790)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.creatFireworksDown(xMovement: 1030, x: 80, y: 790)
        }
        creatFireworksDown(xMovement: -1030, x: -80+1024, y: 790)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.creatFireworksDown(xMovement: -1030, x: -80+1024, y: 790)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.creatFireworksDown(xMovement: -1030, x: -80+1024, y: 790)
        }
        
        
//        switch Int.random(in: 0...3) {
//        case 0:
//            creatHeart(<#T##movementAmount: CGFloat##CGFloat#>)
////            creatFireworks(xMovement: 0, x: 512, y: bottomEdge)
////            creatFireworks(xMovement: 0, x: 512-200, y: bottomEdge)
////            creatFireworks(xMovement: 0, x: 512-100, y: bottomEdge)
////            creatFireworks(xMovement: 0, x: 512+100, y: bottomEdge)
////            creatFireworks(xMovement: 0, x: 512+200, y: bottomEdge)
//        case 1:
//            creatFireworks(xMovement: movementAmount, x: leftEdge, y: bottomEdge+400)
//            creatFireworks(xMovement: -movementAmount, x: rightEdge, y: bottomEdge+400)
//            creatFireworks(xMovement: -100, x: 521-100, y: bottomEdge)
//            creatFireworks(xMovement: -100, x: 521-100, y: bottomEdge)
//            creatFireworks(xMovement: 100, x: 512+100, y: bottomEdge)
//            creatFireworks(xMovement: 100, x: 512+100, y: bottomEdge)
////            creatFireworks(xMovement: 0, x: 512, y: bottomEdge)
////            creatFireworks(xMovement: -200, x: 512-200, y: bottomEdge)
////            creatFireworks(xMovement: -100, x: 512-100, y: bottomEdge)
////            creatFireworks(xMovement: 100, x: 512+100, y: bottomEdge)
////            creatFireworks(xMovement: 200, x: 512+200, y: bottomEdge)
//        case 2:
//            creatFireworks(xMovement: movementAmount, x: leftEdge, y: bottomEdge+400)
//            creatFireworks(xMovement: -movementAmount, x: rightEdge, y: bottomEdge+400)
//            creatFireworks(xMovement: -100, x: 521-100, y: bottomEdge)
//            creatFireworks(xMovement: -100, x: 521-100, y: bottomEdge)
//            creatFireworks(xMovement: 100, x: 512+100, y: bottomEdge)
//            creatFireworks(xMovement: 100, x: 512+100, y: bottomEdge)
//        case 3:
//            creatFireworks(xMovement: movementAmount, x: leftEdge, y: bottomEdge+400)
//            creatFireworks(xMovement: -movementAmount, x: rightEdge, y: bottomEdge+400)
//            creatFireworks(xMovement: -100, x: 521-100, y: bottomEdge)
//            creatFireworks(xMovement: -100, x: 521-100, y: bottomEdge)
//            creatFireworks(xMovement: 100, x: 512+100, y: bottomEdge)
//            creatFireworks(xMovement: 100, x: 512+100, y: bottomEdge)
////            creatFireworks(xMovement: -movementAmount, x: rightEdge, y: bottomEdge+400)
////            creatFireworks(xMovement: -movementAmount, x: rightEdge, y: bottomEdge+300)
////            creatFireworks(xMovement: -movementAmount, x: rightEdge, y: bottomEdge+200)
////            creatFireworks(xMovement: -movementAmount, x: rightEdge, y: bottomEdge+100)
////            creatFireworks(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)
//        default:
//            break
//        }
    }
    
    func creatHeart(_ movementAmount: CGFloat) {
        creatFireworks(xMovement: movementAmount, x: leftEdge, y: bottomEdge+400)
        creatFireworks(xMovement: -movementAmount, x: rightEdge, y: bottomEdge+400)
        creatFireworks(xMovement: -100, x: 521-100, y: bottomEdge)
        creatFireworks(xMovement: -100, x: 521-100, y: bottomEdge)
        creatFireworks(xMovement: 100, x: 512+100, y: bottomEdge)
        creatFireworks(xMovement: 100, x: 512+100, y: bottomEdge)
    }
    
    func creatFireworksDown(xMovement: CGFloat, x: Int, y: Int) {
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.colorBlendFactor = 1
        firework.name = "firework"
        node.addChild(firework)
        
        switch Int.random(in: 0...2) {
        case 0:
            firework.color = .cyan
        case 1:
            firework.color = .red
        case 2:
            firework.color = .green
        default:
            break
        }
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: xMovement, y: -800))
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        node.run(move)
        
        if let emitter = SKEmitterNode(fileNamed: "fuse") {
            emitter.position = CGPoint(x: 0, y: -22)
            node.addChild(emitter)
        }
        
        fireworks.append(node)
        addChild(node)
    }
    
    func creatFireworks(xMovement: CGFloat, x: Int, y: Int) {
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.colorBlendFactor = 1
        firework.name = "firework"
        node.addChild(firework)
        
        switch Int.random(in: 0...2) {
        case 0:
            firework.color = .cyan
        case 1:
            firework.color = .red
        case 2:
            firework.color = .green
        default:
            break
        }
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: xMovement, y: 1000))
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        node.run(move)
        
        if let emitter = SKEmitterNode(fileNamed: "fuse") {
            emitter.position = CGPoint(x: 0, y: -22)
            node.addChild(emitter)
        }
        
        fireworks.append(node)
        addChild(node)
    }
    
    func checkTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)
        
        for case let node as SKSpriteNode in nodesAtPoint {
            guard  node.name == "firework" else {
                return
            }
            node.name = "selected"
            for parent in fireworks {
                guard let firework = parent.children.first as? SKSpriteNode else {
                    return
                }
                
                if firework.name == "selected" && firework.color != node.color {
                    firework.name = "firework"
                    firework.colorBlendFactor = 1
                }
            }
            node.colorBlendFactor = 0
        }
        
    }
    
    func explode(firework: SKNode) {
        if let emitter = SKEmitterNode(fileNamed: "explode") {
            emitter.position = firework.position
            addChild(emitter)
        }
        firework.removeFromParent()
    }
    
    func explodeFireworks() {
        var numExploded = 0
        
        for (index, fireworkContainer) in fireworks.enumerated().reversed() {
            guard let firework = fireworkContainer.children.first as? SKSpriteNode else {return}
            
            if firework.name == "firework" {
                explode(firework: fireworkContainer)
                fireworks.remove(at: index)
                numExploded += 1
            }
        }
        gameTimer?.invalidate()
        let love = SKLabelNode(fontNamed: "Zapfino")
        love.fontColor = .red
        love.fontSize = 69
        love.text = "I love you, babe! <3"
        love.position = CGPoint(x: 512, y: 386)
        addChild(love)
        
        let rotate = SKAction.rotate(byAngle: 3.14/180*20, duration: 0.5)
        let rotate2 = SKAction.rotate(byAngle: -3.14/180*20, duration: 0.5)
        let animate = SKAction.sequence([rotate,rotate2,rotate2,rotate])
        love.run(SKAction.repeat(animate, count: 5))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            love.removeFromParent()
            self.gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.launchFireworks), userInfo: nil, repeats: true)
        }
        switch numExploded {
        case 0:
            break
        case 1:
            score += 500
        case 2:
            score += 1000
        case 3:
            score += 1500
        case 4:
            score += 2500
        default:
            score += 4000
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        checkTouches(touches)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for (index, firework) in fireworks.enumerated().reversed() {
            if firework.position.y > 900{
                fireworks.remove(at: index)
                firework.removeFromParent()
            }
        }
    }
}
