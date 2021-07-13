//
//  WhackSlot.swift
//  Project14
//
//  Created by user197801 on 6/8/21.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    var isVisible = false
    var isHit = false
    var count = 0
    
    //Creat a crop node that contain a hole, a penguin and a maskNode to hide that penguin
    //Penguin hide by shift -90 in y axis, maskNode only show what in color so when penguin shift below color part it will become invisiable
    
    var charNode: SKSpriteNode!
    func configure(at position: CGPoint) {
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1

        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
        
    }
    
    func show(hideTime: Double) {
        if isVisible {return}
        charNode.xScale = 1     //cause we might tranform it so need to reset here
        charNode.yScale = 1
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime*3.5)) { [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        if !isVisible {return}
        
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisable = SKAction.run { [unowned self] in self.isVisible = false}
        
        charNode.run(SKAction.sequence([delay,hide,notVisable]))
    }
    
    func mud(at position: CGPoint) {
        print(count)
        count += 1
        if let mud = SKEmitterNode(fileNamed: "Mud") {
            mud.position = position
            addChild(mud)
        }
    }
}
