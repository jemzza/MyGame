//
//  GameScene.swift
//  MyGame
//
//  Created by Alexander Litvinov on 23.08.2020.
//  Copyright © 2020 Alexander Litvinov. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    
    static let Ball: UInt32 = 0x1 << 1
    static let Land: UInt32 = 0x1 << 2
    static let Obstrucion: UInt32 = 0x1 << 1
    
}

class GameScene: SKScene {

    let ball = SKShapeNode(circleOfRadius: 50)
    
    var land: SKSpriteNode = {
        let land = SKSpriteNode(color: .brown, size: CGSize(width: 1000, height: 100))
        land.name = "myLand"
        return land
    }()
    
//    var obstruction = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
    
    var obstruction = SKNode()

    
    var moveAndRemove = SKAction()
    var gameStarted = Bool()
    
    override func didMove(to view: SKView) {
        
        land.position = CGPoint(x: 0, y: -self.frame.height / 2 + land.frame.height / 2)
        land.physicsBody = SKPhysicsBody(rectangleOf: land.size)
        land.physicsBody?.categoryBitMask = PhysicsCategory.Land
        land.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        land.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
//        land.physicsBody?.pinned = true
        land.physicsBody?.affectedByGravity = false
        land.physicsBody?.isDynamic = false
        self.addChild(land)
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.fillColor = SKColor.white
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.height / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Land | PhysicsCategory.Obstrucion
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Land | PhysicsCategory.Obstrucion
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.isDynamic = true
        ball.zPosition = 2
        self.addChild(ball)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
        
            gameStarted = true
            ball.physicsBody?.affectedByGravity = true
            obstruction = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
            
            let spawn = SKAction.run {
                self.createObstruction()
            }
            
            let delay = SKAction.wait(forDuration: 2.5)
            let spawnDelay = SKAction.sequence([spawn, delay])
            let spawnRepeatForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnRepeatForever)
            
            let distance = CGFloat(self.frame.width + obstruction.frame.width)
            let moveObstructions = SKAction.moveBy(x: -distance - 60, y: 0, duration: TimeInterval(0.01 * distance))
            let removeObstructions = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([moveObstructions, removeObstructions])
            
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
        } else {
            
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
        }
    }
    
    func createObstruction() {
        
        obstruction = SKNode()
        
        let landObstruction = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
        
        landObstruction.position = CGPoint(x: self.frame.width / 2 + landObstruction.size.width / 2, y: landObstruction.frame.height / 2 - self.frame.height / 2 + land.frame.height)
        landObstruction.physicsBody = SKPhysicsBody(rectangleOf: landObstruction.size)
        landObstruction.physicsBody?.categoryBitMask = PhysicsCategory.Obstrucion
        landObstruction.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        landObstruction.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        landObstruction.physicsBody?.isDynamic = false
        landObstruction.physicsBody?.affectedByGravity = false
        
        obstruction.addChild(landObstruction)
        landObstruction.zPosition = 1
        obstruction.run(moveAndRemove)
        self.addChild(obstruction)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
