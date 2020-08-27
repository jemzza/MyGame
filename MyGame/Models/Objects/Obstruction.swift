//
//  Obstruction.swift
//  MyGame
//
//  Created by Alexander Litvinov on 25.08.2020.
//  Copyright © 2020 Alexander Litvinov. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

final class Obstruction: SKNode, GameObjectsSpriteable {
    
    static func set(at point: CGPoint?) -> Obstruction {
        
        let obstruction = Obstruction()
        
        guard let point = point else { return Obstruction()}
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 1, height: UIScreen.main.bounds.height * 2)
        scoreNode.position = CGPoint(x: UIScreen.main.bounds.width + point.x, y: point.y + Constants.Land.height)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = BitMaskCategory.Score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = BitMaskCategory.Ball
        
        let landObstruction = SKSpriteNode(color: .red, size: CGSize(width: point.x, height: point.y))
        landObstruction.position = CGPoint(x: UIScreen.main.bounds.width + landObstruction.size.width / 2,
                                           y: landObstruction.frame.height / 2 - UIScreen.main.bounds.height + Constants.Land.height)
        landObstruction.physicsBody = SKPhysicsBody(rectangleOf: landObstruction.size)
        landObstruction.physicsBody?.categoryBitMask = BitMaskCategory.Obstrucion
        landObstruction.physicsBody?.collisionBitMask = BitMaskCategory.Ball
        landObstruction.physicsBody?.contactTestBitMask = BitMaskCategory.Ball
        landObstruction.physicsBody?.isDynamic = false
        landObstruction.physicsBody?.affectedByGravity = false
        
        obstruction.addChild(scoreNode)
        obstruction.addChild(landObstruction)
        
        return obstruction
    }
    
    //MARK: - TODO
    /*
    fileprivate static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
    }
    
    fileprivate static func move(from point: CGPoint, time: TimeInterval) -> SKAction {
        
        let movePoint = CGPoint(x: point.x, y: point.y)
        let moveDistance = point.x + 200
        let movementSpeed: CGFloat = 100.0 + 5.0 * CGFloat(time)
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
 */
}
