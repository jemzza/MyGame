//
//  GameScene.swift
//  MyGame
//
//  Created by Alexander Litvinov on 23.08.2020.
//  Copyright © 2020 Alexander Litvinov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var ball = Ball.set(at: CGPoint(x: 0, y: 0))
    var moveAndRemove = SKAction()
    var gameStarted = Bool()
    var score = Int()
    let scoreLabel = SKLabelNode()
    var lose = Bool()
    var restartButton = SKSpriteNode()
    var isBallHasContactWithLand = false
    
    override func didMove(to view: SKView) {

        createScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
        
            gameStarted = true
                        
            let spawn = SKAction.run {
                self.createObstruction()
            }
            
            //MARK: - Spawn of Obstructions
            let delay = SKAction.wait(forDuration: 1.5)
            let spawnDelay = SKAction.sequence([spawn, delay])
            let spawnRepeatForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnRepeatForever)
            
            let distance = CGFloat(self.frame.width + 200)
            let moveObstructions = SKAction.moveBy(x: -distance - 400, y: 0, duration: TimeInterval(0.003 * distance ))

            let removeObstructions = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([moveObstructions, removeObstructions])
    
            if isBallHasContactWithLand {
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 400))
                isBallHasContactWithLand = false
            }
            
        } else {
            
            if lose == true {
                
            } else {
                
                if isBallHasContactWithLand {
                    ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
                    isBallHasContactWithLand = false
                }
            }
        }
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if lose == true {
                
                if restartButton.contains(location) {
                    restartGame()
                }
            }
        }
    }
    
    //MARK: - Create Obstructions
    func createObstruction() {
        
        let randomHeight = CGFloat.random(min: 50, max: 180)
        let randomWidth = CGFloat.random(min: 50, max: 200)

        let obstruction = Obstruction.set(at: CGPoint(x: randomWidth, y: randomHeight))
        obstruction.run(moveAndRemove)
        self.addChild(obstruction)
    }
    
    //MARK: - Create RestartButton
    func createRestartButton() {
        
        restartButton = SKSpriteNode(color: SKColor.white, size: CGSize(width: 300, height: 150))
        restartButton.position = CGPoint(x: 0, y: 0)
        restartButton.zPosition = 1
        self.addChild(restartButton)
        
        let restartLabel = SKLabelNode(text: "Restart")
        restartLabel.fontColor = .darkGray
        restartLabel.fontSize = 60
        restartLabel.position = CGPoint(x: 0, y: -25)
        restartButton.addChild(restartLabel)
    }
    
    func restartGame() {
        
        self.removeAllChildren()
        self.removeAllActions()
        
        lose = false
        gameStarted = false
        score = 0
        
        createScene()
    }
    
    func createScene() {
        
        self.physicsWorld.contactDelegate = self
        
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 100
        scoreLabel.text = "\(score)"
        self.addChild(scoreLabel)
        
        let land = Land.set(at: CGPoint(x: 0, y: -self.frame.height / 2 + Constants.Land.height / 2))
        self.addChild(land)
        
        ball = Ball.set(at: CGPoint(x: 0, y: 0))
        self.addChild(ball)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        if !lose {
            
            let firstBody = contact.bodyA
            let secondBody = contact.bodyB
            
            if firstBody.categoryBitMask == BitMaskCategory.Land && secondBody.categoryBitMask == BitMaskCategory.Ball || firstBody.categoryBitMask == BitMaskCategory.Ball && secondBody.categoryBitMask == BitMaskCategory.Land {
                
                isBallHasContactWithLand = true
            } else {
                
                isBallHasContactWithLand = false
            }
            
            if firstBody.categoryBitMask == BitMaskCategory.Score && secondBody.categoryBitMask == BitMaskCategory.Ball || firstBody.categoryBitMask == BitMaskCategory.Ball && secondBody.categoryBitMask == BitMaskCategory.Score {
                
                score += 1
                scoreLabel.text = "\(score)"
            }
            
            if firstBody.categoryBitMask == BitMaskCategory.Ball && secondBody.categoryBitMask == BitMaskCategory.Obstrucion || firstBody.categoryBitMask == BitMaskCategory.Obstrucion && secondBody.categoryBitMask == BitMaskCategory.Ball {
                
                lose = true
                createRestartButton()
            }
        }
    }
}
