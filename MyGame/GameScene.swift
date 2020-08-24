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
    static let Obstrucion: UInt32 = 0x1 << 3
    static let Score: UInt32 = 0x1 << 4
    
}

class GameScene: SKScene {

    let ball = SKShapeNode(circleOfRadius: 50)
    
    var land: SKSpriteNode = {
        let land = SKSpriteNode(color: .brown, size: CGSize(width: 1000, height: 100))
        land.name = "myLand"
        return land
    }()
        
    var obstruction = SKNode()

    
    var moveAndRemove = SKAction()
    var gameStarted = Bool()
    var score = Int()
    var scoreLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 100
        scoreLabel.text = "\(score)"
        self.addChild(scoreLabel)
        
        land.position = CGPoint(x: 0, y: -self.frame.height / 2 + land.frame.height / 2)
        land.physicsBody = SKPhysicsBody(rectangleOf: land.size)
        land.physicsBody?.categoryBitMask = PhysicsCategory.Land
        land.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        land.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        land.physicsBody?.affectedByGravity = false
        land.physicsBody?.isDynamic = false
        self.addChild(land)
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.fillColor = SKColor.white
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.height / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Land | PhysicsCategory.Obstrucion
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Land | PhysicsCategory.Obstrucion | PhysicsCategory.Score
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
            
            let delay = SKAction.wait(forDuration: 1.5)
            let spawnDelay = SKAction.sequence([spawn, delay])
            let spawnRepeatForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnRepeatForever)
            
            let distance = CGFloat(self.frame.width + obstruction.frame.width)
            let moveObstructions = SKAction.moveBy(x: -distance - 400, y: 0, duration: TimeInterval(0.003 * distance))
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
        
        let randomHeight = CGFloat.random(min: 50, max: 200)
        let randomWidth = CGFloat.random(min: 50, max: 100)
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 1, height: self.frame.height)
        scoreNode.position = CGPoint(x: self.frame.width / 2 + randomWidth, y: land.frame.height + randomHeight)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCategory.Score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        scoreNode.color = SKColor.blue
        
        obstruction = SKNode()
        
        
        let landObstruction = SKSpriteNode(color: .red, size: CGSize(width: randomWidth, height: randomHeight))
        
        landObstruction.position = CGPoint(x: self.frame.width / 2 + landObstruction.size.width / 2, y: landObstruction.frame.height / 2 - self.frame.height / 2 + land.frame.height)
        landObstruction.physicsBody = SKPhysicsBody(rectangleOf: landObstruction.size)
        landObstruction.physicsBody?.categoryBitMask = PhysicsCategory.Obstrucion
        landObstruction.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        landObstruction.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        landObstruction.physicsBody?.isDynamic = false
        landObstruction.physicsBody?.affectedByGravity = false
        
        obstruction.addChild(scoreNode)
        obstruction.addChild(landObstruction)
        landObstruction.zPosition = 1
        
        
        obstruction.run(moveAndRemove)
        self.addChild(obstruction)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == PhysicsCategory.Score && secondBody.categoryBitMask == PhysicsCategory.Ball || firstBody.categoryBitMask == PhysicsCategory.Ball && secondBody.categoryBitMask == PhysicsCategory.Score {
            
            score += 1
            scoreLabel.text = "\(score)"
        }
    }
}
