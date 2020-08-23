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
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true
        ball.zPosition = 2
        self.addChild(ball)
        
        createObstruction()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
    }
    
    func createObstruction() {
        
        let obstruction = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
        obstruction.position = CGPoint(x: 200, y: obstruction.frame.height / 2 - self.frame.height / 2 + land.frame.height)
        obstruction.physicsBody?.categoryBitMask = PhysicsCategory.Obstrucion
        obstruction.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        obstruction.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        obstruction.physicsBody?.isDynamic = false
        obstruction.physicsBody?.affectedByGravity = false
        
        obstruction.zPosition = 1
        self.addChild(obstruction)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
