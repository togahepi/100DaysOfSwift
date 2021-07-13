//
//  GameScene.swift
//  ShootingGallery
//
//  Created by user197801 on 6/18/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let enemies = ["dino1","dino3","dino4","dino5","dinoGood"]
    
    let rowYaxis = [150,350,550]
    
    var gameTimer : Timer?
    
    var reload : SKLabelNode!
    
    var bullet: SKSpriteNode?
    

    override func didMove(to view: SKView) {
        var x = 10
        let y = 730
        for _ in 0...5 {
            
            bullet = SKSpriteNode(imageNamed: "bullet")
            
            bullet?.size = CGSize(width: 40, height: 80)
            
            bullet?.position = CGPoint(x: x, y: y)
            
            x += 20
            
            addChild(bullet!)
        }
        
        
        
        reload = SKLabelNode(fontNamed: "Chalkduster")
        reload.fontSize = 40
        reload.position = CGPoint(x: 215, y: 720)
        reload.text = "Reload"
        addChild(reload)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(creatEnemy), userInfo: nil, repeats: true)
    }
    
    @objc func creatEnemy() {
        guard let enemy = enemies.randomElement() else {return}
        let dino = SKSpriteNode(imageNamed: enemy)
        dino.position = CGPoint(x: 1000, y: rowYaxis.randomElement()!)
        addChild(dino)
        
        dino.physicsBody = SKPhysicsBody(texture: dino.texture!, size: dino.size)
        dino.physicsBody?.velocity = CGVector(dx: -469, dy: 0)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
